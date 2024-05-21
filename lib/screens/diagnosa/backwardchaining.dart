import 'package:flutter/material.dart';

final Map<String, List<String>> diseaseSymptoms = {
  'White Spot': [
    'Menurunnya kekebalan tubuh atau lemas',
    'Badan ikan kurus',
    'Terdapat bintik-bintik putih'
  ],
  'Black Spot': [
    'Menurunnya kekebalan tubuh atau lemas',
    'Badan ikan kurus',
    'Terdapat bintik-bintik hitam'
  ],
  'Cloudy Eyes': ['Mata berkabut', 'Produksi lendir berlebih', 'Mata menonjol'],
  'Dropsy': [
    'Badan gembur'
        'Perut membengkak',
    'Sisik nanas atau mulai menanggal dari badan ikan',
    'Kesulitan dalam berenang'
  ],
  'Fin/Tail Rot': [
    'Menurunnya kekebalan tubuh atau lemas',
    'Sirip dan ekor mulai membusuk',
    'Tulang sirip dan ekor buram'
  ],
  'Kutu Jangkar': [
    'Menurunnya kekebalan tubuh atau lemas',
    'Terdapat cacing yang menempel pada tubuh',
    'Sering menggesekkan tubuh pada dinding',
  ],
};

class BackwardChainingPage extends StatefulWidget {
  const BackwardChainingPage({super.key});

  @override
  State<BackwardChainingPage> createState() => _BackwardChainingPageState();
}

class _BackwardChainingPageState extends State<BackwardChainingPage> {
  String? selectedDisease;
  List<String> selectedSymptoms = [];
  Map<String, bool> symptomSelection = {};

  void _onDiseaseSelected(String? disease) {
    setState(() {
      selectedDisease = disease;
      selectedSymptoms = disease != null ? diseaseSymptoms[disease]! : [];
      symptomSelection = {for (var symptom in selectedSymptoms) symptom: false};
    });
  }

  void _showDiagnosisDialog() {
    int selectedCount =
        symptomSelection.values.where((bool value) => value).length;
    int totalSymptoms = selectedSymptoms.length;
    double accuracy = (selectedCount / totalSymptoms) * 100;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Diagnosis Result'),
          content: Text(
              'Penyakit yang dipilih: $selectedDisease\nGejala-gejala yang dipilih: ${symptomSelection.keys.where((key) => symptomSelection[key]!).join(', ')}\nAkurasi: ${accuracy.toStringAsFixed(2)}%'),
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
              items: diseaseSymptoms.keys.map((String disease) {
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
          onPressed: _showDiagnosisDialog,
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
