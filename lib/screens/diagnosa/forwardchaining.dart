import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:koimedic/screens/models/koi_data.dart';

import '../dashboard.dart';

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
  String diagnosis = '';
  String treatment = '';

  Future<void> diagnoseKoi() async {
    final response = await http.post(
      Uri.parse(
          'https://deploykoimedic-59755e52928d.herokuapp.com/diagnosaforward'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'gejala': symptoms}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final diagnosis = data['hasil_diagnosa'];
      final treatment = data['treatment'];

      setState(() {
        this.diagnosis = diagnosis;
        this.treatment = treatment;
      });

      await saveDiagnosisToFirestore(diagnosis, symptoms.join(', '));
      _showDiagnosisDialog(diagnosis, treatment);
    } else {
      setState(() {
        diagnosis = 'Failed to get diagnosis';
        treatment = '';
      });
      _showDiagnosisDialog(diagnosis, treatment);
    }
  }

  Future<void> saveDiagnosisToFirestore(
      String diagnosis, String symptoms) async {
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
        "hasil_diagnosa": diagnosis,
        "timestamp": now,
      }, SetOptions(merge: true));
    } else {
      print("User is not logged in");
    }
  }

  void _showDiagnosisDialog(String diagnosis, String treatment) {
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Diagnosis: $diagnosis',
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
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.offAll(() => const Dashboard());
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
            return CheckboxListTile(
              title: Text(key),
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
          ),
          child: const Text(
            'Diagnose',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
