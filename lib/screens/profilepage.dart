import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/loginpage.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.to(const Loginpage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 60,
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Astrokoi Farm",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Urbanist-Bold",
              ),
            ),
            const SizedBox(height: 10),
            Text(
              user != null ? user!.email ?? 'No Email' : 'Not Logged In',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                ),
                title: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontFamily: "Urbanist-SemiBold",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onTap: () => signOut(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
