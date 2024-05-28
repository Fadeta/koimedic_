import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class Forwardchaining extends StatefulWidget {
  const Forwardchaining({super.key});

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

  Future<void> diagnoseKoi() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5001/diagnosaforward'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'gejala': symptoms}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        diagnosis = data['hasil_diagnosa'];
      });
      await saveDiagnosisToFirestore(diagnosis);
      _showDiagnosisDialog(diagnosis);
    } else {
      setState(() {
        diagnosis = 'Failed to get diagnosis';
      });
      _showDiagnosisDialog(diagnosis);
    }
  }

  Future<void> saveDiagnosisToFirestore(String diagnosis) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      CollectionReference<Map<String, dynamic>> colDiagnosa = FirebaseFirestore
          .instance
          .collection("users")
          .doc(uid)
          .collection("diagnosa");

      DateTime now = DateTime.now();
      String todayDocID = DateFormat('yyyy-MM-dd').format(now);

      await colDiagnosa.doc(todayDocID).set({
        "gejala": symptoms,
        "hasil_diagnosa": diagnosis,
        "timestamp": now,
      });
    }
  }

  void _showDiagnosisDialog(String diagnosis) {
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
          content: Text(
            diagnosis,
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
            return CheckboxListTile(
              title: Text(key),
              value: symptoms.contains(_symptoms[key]),
              onChanged: (bool? value) {
                setState(() {
                  if (value!) {
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
