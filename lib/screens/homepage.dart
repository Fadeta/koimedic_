import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/menu/detailpage.dart';
import 'package:koimedic/screens/menu/diagnosapage.dart';
import 'package:koimedic/screens/menu/historypage.dart';
import 'package:koimedic/widget/banner.dart';
import 'package:koimedic/widget/menu.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              child: const Icon(
                CupertinoIcons.bell,
                color: Colors.black,
              ),
            ),
          ),
        ],
        title: const Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Hi, Astrokoi Farm \nMulai diagnosa ikan Koi anda!",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Urbanist-Bold",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1),
            )
          ],
        ),
        toolbarHeight: 130,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MenuItem(
                  icon: CupertinoIcons.plus,
                  label: "Diagnosa",
                  onTap: () {
                    Get.to(const Diagnosapage());
                  },
                ),
                MenuItem(
                  icon: Icons.history_rounded,
                  label: "Riwayat",
                  onTap: () {
                    Get.to(const Historypage());
                  },
                ),
                MenuItem(
                  icon: Icons.info_outline,
                  label: "Detail",
                  onTap: () {
                    Get.to(const Detailpage());
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Bannerpage(),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Artikel",
                    style: TextStyle(
                      fontFamily: "Urbanist-Bold",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
