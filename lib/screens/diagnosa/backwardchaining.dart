import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'http://127.0.0.1:5001';

class BackwardChainingPage extends StatefulWidget {
  const BackwardChainingPage({super.key});

  @override
  State<BackwardChainingPage> createState() => _BackwardChainingPageState();
}

class _BackwardChainingPageState extends State<BackwardChainingPage> {
  String? selectedDisease;
  List<String> diseases = [];
  List<String> symptoms = [];
  Map<String, bool> symptomSelection = {};

  @override
  void initState() {
    super.initState();
    fetchDiseases();
  }

  Future<void> fetchDiseases() async {
    final response = await http.get(Uri.parse('$baseUrl/diseases'));
    if (response.statusCode == 200) {
      setState(() {
        diseases = List<String>.from(json.decode(response.body));
      });
    } else {
      // Handle error
      print('Failed to load diseases');
    }
  }

  Future<void> fetchSymptoms(String disease) async {
    final response =
        await http.get(Uri.parse('$baseUrl/symptoms?disease=$disease'));
    if (response.statusCode == 200) {
      setState(() {
        symptoms = List<String>.from(json.decode(response.body));
        symptomSelection = {for (var symptom in symptoms) symptom: false};
      });
    } else {
      // Handle error
      print('Failed to load symptoms');
    }
  }

  Future<void> diagnose() async {
    final selectedSymptoms = symptomSelection.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    final response = await http.post(
      Uri.parse('$baseUrl/diagnosabackward'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'disease': selectedDisease,
        'symptoms': selectedSymptoms,
      }),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      _showDiagnosisDialog(result);
    } else {
      // Handle error
      print('Failed to diagnose');
    }
  }

  void _onDiseaseSelected(String? disease) {
    setState(() {
      selectedDisease = disease;
    });
    if (disease != null) {
      fetchSymptoms(disease);
    }
  }

  void _showDiagnosisDialog(Map<String, dynamic> result) {
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
            'Penyakit yang dipilih:\n ${result['disease']}\n'
            'Gejala-gejala yang dipilih:\n ${result['selected_symptoms'].join(', ')}\n'
            'Akurasi:\n ${result['accuracy']}',
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
          'Diagnosa Penyakit Ikan Koi',
          style: TextStyle(
            fontFamily: "Urbanist-Bold",
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Penyakit:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedDisease,
              hint: const Text('Pilih Penyakit'),
              items: diseases.map((String disease) {
                return DropdownMenuItem<String>(
                  value: disease,
                  child: Text(disease),
                );
              }).toList(),
              onChanged: _onDiseaseSelected,
            ),
            const SizedBox(height: 20),
            const Text(
              'Gejala-gejala terkait:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: symptomSelection.keys.map((String symptom) {
                    return CheckboxListTile(
                      title: Text(symptom),
                      value: symptomSelection[symptom],
                      onChanged: (bool? value) {
                        setState(() {
                          symptomSelection[symptom] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: diagnose,
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
