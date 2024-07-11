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
      String docId =
          widget.diagnosis['docId']; // Assuming you have docId in diagnosis map

      try {
        await _firestore
            .collection("users")
            .doc(uid)
            .collection("diagnosa")
            .doc(docId)
            .update({'feedback': _feedbackController.text});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback saved successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save feedback: $e')),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Jenis Koi: ${widget.diagnosis['jeniskoi']}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Umur: ${widget.diagnosis['umur']}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text(
                  'Hasil Diagnosa: ${widget.diagnosis['hasil_diagnosa'] ?? widget.diagnosis['penyakit']}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              TextField(
                controller: _feedbackController,
                decoration: InputDecoration(
                  labelText: 'Feedback',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _saveFeedback,
                child: Text('Save Feedback'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
