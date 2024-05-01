import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/authpage.dart';
import 'package:koimedic/screens/fade_animation.dart';
import 'package:koimedic/screens/homepage.dart';
import 'package:koimedic/widget/common.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool flag = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text);
    Get.to(const Homepage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FadeAnimation(
              delay: 1,
              child: IconButton(
                onPressed: () {
                  Get.to(const Authpage());
                },
                icon: const Icon(
                  CupertinoIcons.back,
                  size: 35,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeAnimation(
                    delay: 1.3,
                    child: Text(
                      "Selamat datang kembali!",
                      style: Common().titelTheme,
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: 'Enter Email'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(hintText: 'Enter Password'),
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                signIn();
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
