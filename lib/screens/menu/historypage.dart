import 'package:flutter/material.dart';

class Historypage extends StatefulWidget {
  const Historypage({super.key});

  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
  final List<Map<String, String>> _diagnosisHistory = [];

  void _addDiagnosis(String name, String type, String age, String result) {
    setState(() {
      _diagnosisHistory.add({
        'name': name,
        'type': type,
        'age': age,
        'result': result,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(
            fontFamily: "Urbanist-Bold",
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: _diagnosisHistory.isEmpty
          ? const Center(
              child: Text(
                'No history available',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _diagnosisHistory.length,
              itemBuilder: (context, index) {
                final diagnosis = _diagnosisHistory[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(diagnosis['name']![0]),
                  ),
                  title: Text(diagnosis['name']!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jenis Koi: ${diagnosis['type']}'),
                      Text('Umur: ${diagnosis['age']}'),
                      Text('Hasil Diagnosa: ${diagnosis['result']}'),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addDiagnosis('Koi A', 'Kohaku', '2 tahun', 'White Spot');
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
