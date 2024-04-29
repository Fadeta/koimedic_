import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/fade_animation.dart';
import 'package:koimedic/screens/loginpage.dart';
import 'package:koimedic/screens/registerpage.dart';
import 'package:koimedic/widget/widget.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Image.asset(
                'assets/images/logo1.png',
                fit: BoxFit.scaleDown,
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),
          ),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: SizedBox(
                child: Column(
                  children: [
                    FadeAnimation(
                      delay: 1,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const FadeAnimation(
                      delay: 1.5,
                      child: Text(
                        "Koi Medic",
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    FadeAnimation(
                      delay: 2,
                      child: CustomElevatedButton(
                          message: "Login",
                          function: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Loginpage()),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      delay: 2.5,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(const Registerpage());
                          },
                          style: ButtonStyle(
                              side: const WidgetStatePropertyAll(
                                  BorderSide(color: Colors.red)),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              fixedSize: const WidgetStatePropertyAll(
                                  Size.fromWidth(370)),
                              padding: const WidgetStatePropertyAll(
                                EdgeInsets.symmetric(vertical: 20),
                              ),
                              backgroundColor:
                                  const WidgetStatePropertyAll(Colors.white)),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Urbanist-SemiBold",
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          )),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
