import 'package:flutter/material.dart';

class Forwardchaining extends StatefulWidget {
  const Forwardchaining({super.key});

  @override
  State<Forwardchaining> createState() => _ForwardchainingState();
}

class _ForwardchainingState extends State<Forwardchaining> {
  final Map<String, bool> _symptoms = {
    'Menurunnya kekebalan tubuh atau lemas': false,
    'Badan ikan kurus': false,
    'Terdapat bintik-bintik putih': false,
    'Terdapat bintik-bintik hitam': false,
    'Mata Berkabut': false,
    'Produksi lendir berlebih': false,
    'Mata menonjol': false,
    'Badan gembur': false,
    'Perut membengkak': false,
    'Kesulitan dalam berenang': false,
    'Sisik nanas atau mulai menanggal dari badan ikan': false,
    'Sirip dan ekor mulai membusuk': false,
    'Tulang sirip dan ekor buram': false,
    'Terdapat cacing yang menempel pada tubuh': false,
    'Sering menggesekkan tubuh pada dinding': false,
  };

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
              value: _symptoms[key],
              onChanged: (bool? value) {
                setState(() {
                  _symptoms[key] = value!;
                });
              },
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<String> selectedSymptoms = _symptoms.entries
              .where((element) => element.value)
              .map((element) => element.key)
              .toList();
          print("Gejala yang dipilih: $selectedSymptoms");
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Forwardchaining(),
  ));
}
