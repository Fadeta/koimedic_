import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koimedic/screens/menu/detailhistory.dart';

class Historypage extends StatefulWidget {
  const Historypage({Key? key});

  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _diagnosesStream;

  @override
  void initState() {
    super.initState();
    _diagnosesStream = _loadDiagnosesFromFirestore();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _loadDiagnosesFromFirestore() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      CollectionReference<Map<String, dynamic>> colDiagnoses = FirebaseFirestore
          .instance
          .collection("users")
          .doc(uid)
          .collection("diagnosa");

      return colDiagnoses.snapshots();
    } else {
      print("User is not logged in");
      return Stream.empty();
    }
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _diagnosesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else {
            final diagnoses = snapshot.data!.docs;
            if (diagnoses.isEmpty) {
              return const Center(child: Text('No history available'));
            } else {
              return ListView.builder(
                itemCount: diagnoses.length,
                itemBuilder: (context, index) {
                  final diagnosis = diagnoses[index].data();
                  diagnosis['docId'] = diagnoses[index].id; // Add document ID
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(diagnosis['namakoi']![0]),
                    ),
                    title: Text(diagnosis['namakoi']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jenis Koi: ${diagnosis['jeniskoi']}'),
                        Text('Umur: ${diagnosis['umur']}'),
                        Text(
                            'Hasil Diagnosa: ${diagnosis['hasil_diagnosa'] ?? diagnosis['penyakit']}')
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailHistory(diagnosis: diagnosis),
                        ),
                      );
                    },
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
