import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/authpage.dart';
import 'package:koimedic/screens/fade_animation.dart';
import 'package:koimedic/screens/loginpage.dart';
import 'package:koimedic/widget/common.dart';

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

  Future<void> regist() async {
    try {
      // Buat pengguna baru dengan email dan password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Ambil UID pengguna yang baru dibuat
      String uid = userCredential.user!.uid;

      // Tambahkan data pengguna ke koleksi 'users' dengan UID sebagai ID dokumen
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email.text,
        'namafarm': namafarm.text,
        // Jangan simpan password dalam bentuk plaintext di Firestore
        // 'password': password.text, // Tidak disarankan
      });

      // Navigasi ke halaman login setelah pendaftaran selesai
      Get.to(const Loginpage());
    } catch (e) {
      // Tangani kesalahan (misalnya tampilkan pesan kesalahan)
      print('Failed to register user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeAnimation(
                        delay: 1.3,
                        child: Text(
                          "Daftarkan farm anda!",
                          style: Common().titelTheme,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: namafarm,
                  decoration: InputDecoration(
                    hintText: 'Enter Name Farm',
                    contentPadding: const EdgeInsets.all(18),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    contentPadding: const EdgeInsets.all(18),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    contentPadding: const EdgeInsets.all(18),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () async {
                      regist();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: "Urbanist-SemiBold",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
