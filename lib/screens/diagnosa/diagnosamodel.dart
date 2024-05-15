import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/diagnosa/forwardchaining.dart';

import '../../widget/common.dart';
import '../fade_animation.dart';
import '../homepage.dart';

class Diagnosamodel extends StatefulWidget {
  const Diagnosamodel({super.key});

  @override
  State<Diagnosamodel> createState() => _DiagnosamodelState();
}

class _DiagnosamodelState extends State<Diagnosamodel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                    Get.to(const Homepage());
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    size: 35,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _animation,
                        child: Image.asset(
                          'assets/images/logo1.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(const Forwardchaining());
                        },
                        style: ElevatedButton.styleFrom(
                          //primary: Colors.blueAccent, // Background color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Forward Chaining',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Aksi untuk metode Backward Chaining
                        },
                        style: ElevatedButton.styleFrom(
                          //primary: Colors.green, // Background color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Backward Chaining',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
