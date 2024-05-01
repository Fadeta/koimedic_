import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/loginpage.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  bool flag = true;
  final namafarm = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  regist() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text, password: password.text);
    Get.to(const Loginpage());

    await FirebaseFirestore.instance.collection('users').add({
      'email': email.text,
      'password': password.text,
      'namafarm': namafarm.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: namafarm,
              decoration: const InputDecoration(hintText: 'Enter Name Farm'),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: 'Enter Email'),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(hintText: 'Enter Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                regist();
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
