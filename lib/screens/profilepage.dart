import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/loginpage.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
    Get.to(const Loginpage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profilepage"),
      ),
      body: Center(
        child: Text(user != null ? user!.email ?? 'No Email' : 'Not Logged In'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signout(),
        child: const Icon(Icons.logout_rounded),
      ),
    );
  }
}
