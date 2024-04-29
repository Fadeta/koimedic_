import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/loginpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
    Get.to(Loginpage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
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
