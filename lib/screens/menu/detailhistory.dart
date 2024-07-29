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
        title: const Text(
          'Detail History',
          style: TextStyle(fontFamily: "Urbanist-Bold"),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.all_out_outlined,
                              color: Colors.black),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Nama Koi: ${widget.diagnosis['namakoi']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Urbanist",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.category, color: Colors.black),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Jenis Koi: ${widget.diagnosis['jeniskoi']}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "Urbanist",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.timeline, color: Colors.black),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Umur: ${widget.diagnosis['umur']}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "Urbanist",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.medical_services,
                              color: Colors.black),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Hasil Diagnosa: ${widget.diagnosis['hasil_diagnosa'] ?? widget.diagnosis['penyakit']}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "Urbanist",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.healing, color: Colors.black),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Treatment: ${widget.diagnosis['treatment']}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: "Urbanist",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _feedbackController,
                decoration: const InputDecoration(
                  labelText: 'Berikan Ulasanmu Disini!',
                  labelStyle: TextStyle(fontFamily: "Urbanist"),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Urbanist",
                      color: Colors.white,
                    ),
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
