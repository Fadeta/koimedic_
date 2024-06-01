import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/diagnosa/backwardchaining.dart'; // Import BackwardChainingPage
import 'package:koimedic/screens/diagnosa/forwardchaining.dart';
import 'package:koimedic/screens/menu/diagnosapage.dart';
import '../../widget/common.dart';
import '../fade_animation.dart';
import 'package:koimedic/screens/models/koi_data.dart';

class Diagnosamodel extends StatefulWidget {
  final KoiData koiData; // Define koiData parameter

  const Diagnosamodel({Key? key, required this.koiData})
      : super(key: key); // Initialize koiData

  @override
  State<Diagnosamodel> createState() => _DiagnosamodelState();
}

class _DiagnosamodelState extends State<Diagnosamodel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeAnimation(
                delay: 1,
                child: IconButton(
                  onPressed: () {
                    Get.to(const Diagnosapage());
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    size: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeAnimation(
                      delay: 1.3,
                      child: Text(
                        "Pilih metode diagnosa penyakit ikan koi!",
                        style: Common().titelTheme,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/koi.png',
                        height: 360,
                        width: 360,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(Forwardchaining(koiData: widget.koiData));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white30),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Diagnosa berdasarkan gejala',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "Urbanist-SemiBold",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(BackwardChainingPage(
                              koiData: widget
                                  .koiData)); // Pass koiData to BackwardChainingPage
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          side: const BorderSide(color: Colors.white30),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Diagnosa berdasarkan penyakit',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: "Urbanist-SemiBold",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
