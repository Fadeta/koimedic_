import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/profilepage.dart';
import 'package:koimedic/widget/list.dart';

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
        Get.off(() => const Homepage()); // Pindah ke halaman beranda
        break;
      case 1:
        Get.to(() => const Profilepage()); // Pindah ke halaman profil
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 50,
            ),
            Text(
              "Mulai diagnosa ikan Koi anda!",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Urbanist-SemiBold",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            )
          ],
        ),
        toolbarHeight: 130,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                listIcons(
                  Icon: "assets/images/icondiagnosa.png",
                  text: "Diagnosa",
                  height: 150,
                ),
                listIcons(
                  Icon: "assets/images/icondetail.png",
                  text: "Informasi",
                  height: 150,
                ),
                listIcons(
                  Icon: "assets/images/iconhistory.png",
                  text: "History",
                  height: 150,
                ),
              ],
            )
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
