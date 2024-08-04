import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:koimedic/screens/menu/historypage.dart';
import 'package:koimedic/screens/models/koi_data.dart';

class Forwardchaining extends StatefulWidget {
  final KoiData koiData;
  const Forwardchaining({super.key, required this.koiData});

  @override
  State<Forwardchaining> createState() => _ForwardchainingState();
}

class _ForwardchainingState extends State<Forwardchaining> {
  final List<String> symptoms = [];
  final Map<String, String> _symptoms = {
    'Menurunnya kekebalan tubuh atau lemas': 'G1',
    'Badan ikan kurus': 'G2',
    'Terdapat bintik-bintik putih': 'G3',
    'Terdapat bintik-bintik hitam': 'G4',
    'Mata Berkabut': 'G5',
    'Produksi lendir berlebih': 'G6',
    'Mata menonjol': 'G7',
    'Badan gembur': 'G8',
    'Perut membengkak': 'G9',
    'Kesulitan dalam berenang': 'G10',
    'Sisik nanas atau mulai menanggal dari badan ikan': 'G11',
    'Sirip dan ekor mulai membusuk': 'G12',
    'Tulang sirip dan ekor buram': 'G13',
    'Terdapat cacing yang menempel pada tubuh': 'G14',
    'Sering menggesekkan tubuh pada dinding': 'G15',
  };

  List<Map<String, String>> diagnosisList = [];

  Future<void> diagnoseKoi() async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://deploykoimedic-59755e52928d.herokuapp.com/diagnosaforward'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'gejala': symptoms}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Diagnosis data: $data'); // Debugging line

        // Asumsikan data yang diterima adalah List<dynamic> dan kita konversi ke List<Map<String, String>>
        if (data is List) {
          List<Map<String, String>> parsedData =
              (data as List<dynamic>).map((item) {
            // Pastikan item adalah Map<String, dynamic> atau sesuaikan sesuai format data yang diterima
            if (item is Map<String, dynamic>) {
              return {
                'disease': item['disease']?.toString() ?? '',
                'cf_persen': item['cf_persen']?.toString() ?? '',
                'treatment': item['treatment']?.toString() ?? '',
              };
            } else {
              return {'disease': '', 'cf_persen': '', 'treatment': ''};
            }
          }).toList();

          setState(() {
            diagnosisList = parsedData;
            print('Processed diagnosis list: $diagnosisList');
          });

          await saveDiagnosisToFirestore(diagnosisList, symptoms.join(', '));
          _showDiagnosisDialog(diagnosisList);
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        print('Failed to get diagnosis, status code: ${response.statusCode}');
        _showErrorDialog("Error: Failed to get diagnosis from server.");
      }
    } catch (e) {
      print('An error occurred: $e');
      _showErrorDialog("An error occurred: $e");
    }
  }

  Future<void> saveDiagnosisToFirestore(
      List<Map<String, String>> diagnosisList, String symptoms) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      CollectionReference<Map<String, dynamic>> colDiagnosa = FirebaseFirestore
          .instance
          .collection("users")
          .doc(uid)
          .collection("diagnosa");

      DateTime now = DateTime.now();
      String todayDocID = DateFormat('yyyy-MM-dd_HH-mm-ss').format(now);

      DocumentReference<Map<String, dynamic>> docRef =
          colDiagnosa.doc(todayDocID);

      await docRef.set({
        "metode": "forward chaining",
        "namakoi": widget.koiData.name,
        "jeniskoi": widget.koiData.species,
        "umur": widget.koiData.age,
        "gejala": symptoms,
        "hasil_diagnosa": diagnosisList.map((e) => e['disease']).toList(),
        "cf_persen": diagnosisList.map((e) => e['cf_persen']).toList(),
        "treatment": diagnosisList.map((e) => e['treatment']).toList(),
        "timestamp": now,
      }, SetOptions(merge: true));
      print("Diagnosis saved to Firestore"); // Debugging line
    } else {
      print("User is not logged in");
    }
  }

  void _showDiagnosisDialog(List<Map<String, String>> diagnosisList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Hasil Diagnosa',
              style: TextStyle(
                fontFamily: "Urbanist-SemiBold",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: diagnosisList.map((diagnosis) {
                final disease = diagnosis['disease'] ?? 'Tidak diketahui';
                final cfPersen = diagnosis['cf_persen'] ?? 'N/A';
                final treatment =
                    diagnosis['treatment'] ?? 'Tidak ada treatment';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diagnosis: $disease',
                      style: const TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Akurasi: $cfPersen',
                      style: const TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Treatment: $treatment',
                      style: const TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.to(() => const Historypage());
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Error',
              style: TextStyle(
                fontFamily: "Urbanist-SemiBold",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          content: Text(
            errorMessage,
            style: const TextStyle(
              fontFamily: "Urbanist",
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gejala Ikan Koi',
          style: TextStyle(
            fontFamily: "Urbanist-Bold",
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: _symptoms.keys.map((String key) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: CheckboxListTile(
                title: Text(
                  key,
                  style: const TextStyle(
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: symptoms.contains(_symptoms[key]),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      symptoms.add(_symptoms[key]!);
                    } else {
                      symptoms.remove(_symptoms[key]!);
                    }
                  });
                },
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: diagnoseKoi,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Diagnose',
            style: TextStyle(
              fontSize: 16,
              fontFamily: "Urbanist-Bold",
            ),
          ),
        ),
      ),
    );
  }
}
