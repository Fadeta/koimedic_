import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailHistory extends StatefulWidget {
  final Map<String, dynamic> diagnosis;

  const DetailHistory({Key? key, required this.diagnosis}) : super(key: key);

  @override
  _DetailHistoryState createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  final TextEditingController _feedbackController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _saveFeedback() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      String docId = widget.diagnosis['docId'];

      try {
        await _firestore
            .collection("users")
            .doc(uid)
            .collection("diagnosa")
            .doc(docId)
            .update({'feedback': _feedbackController.text});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ulasan berhasil disimpan!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memberikan ulasan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail History'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Koi: ${widget.diagnosis['namakoi']}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Urbanist")),
              const SizedBox(height: 10),
              Text('Jenis Koi: ${widget.diagnosis['jeniskoi']}',
                  style: const TextStyle(fontSize: 18, fontFamily: "Urbanist")),
              const SizedBox(height: 10),
              Text('Umur: ${widget.diagnosis['umur']}',
                  style: const TextStyle(fontSize: 18, fontFamily: "Urbanist")),
              const SizedBox(height: 10),
              Text(
                  'Hasil Diagnosa: ${widget.diagnosis['hasil_diagnosa'] ?? widget.diagnosis['penyakit']}',
                  style: const TextStyle(fontSize: 18, fontFamily: "Urbanist")),
              const SizedBox(height: 10),
              Text('Treatment: ${widget.diagnosis['treatment']}',
                  style: const TextStyle(fontSize: 18, fontFamily: "Urbanist")),
              const SizedBox(height: 30),
              TextField(
                controller: _feedbackController,
                decoration: const InputDecoration(
                  labelText: 'Berikan Ulasanmu Disini!',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Urbanist",
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
