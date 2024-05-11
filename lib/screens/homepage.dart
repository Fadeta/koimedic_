import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/menu/detailpage.dart';
import 'package:koimedic/screens/menu/diagnosapage.dart';
import 'package:koimedic/screens/menu/historypage.dart';
import 'package:koimedic/screens/profilepage.dart';
import 'package:koimedic/widget/menu.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Get.off(() => const Homepage());
        break;
      case 1:
        Get.to(() => const Profilepage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
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
                  fontSize: 20,
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[500],
        selectedFontSize: 14,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
