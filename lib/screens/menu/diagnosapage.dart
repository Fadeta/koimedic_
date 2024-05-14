import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/diagnosa/diagnosamodel.dart';
import 'package:koimedic/screens/fade_animation.dart';
import 'package:koimedic/screens/homepage.dart';
import 'package:koimedic/widget/common.dart';

class Diagnosapage extends StatefulWidget {
  const Diagnosapage({super.key});

  @override
  State<Diagnosapage> createState() => _DiagnosapageState();
}

class _DiagnosapageState extends State<Diagnosapage> {
  bool flag = true;
  final namakoi = TextEditingController();
  final jeniskoi = TextEditingController();
  final umur = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  datakoi() async {
    await FirebaseFirestore.instance.collection('users').add({
      'namakoi': namakoi.text,
      'jeniskoi': jeniskoi.text,
      'umur': umur.text,
    });
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
                      Get.to(const Homepage());
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
                          "Isi biodata terlebih dahulu\nuntuk mendiagnosa ikan koi anda!",
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
                  controller: namakoi,
                  decoration: InputDecoration(
                    hintText: 'Enter Name Koi',
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
                  controller: jeniskoi,
                  decoration: InputDecoration(
                    hintText: 'Enter Jenis Koi',
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
                  controller: umur,
                  decoration: InputDecoration(
                    hintText: 'Enter Umur',
                    contentPadding: const EdgeInsets.all(18),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(const Diagnosamodel());
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
                      "Next",
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
