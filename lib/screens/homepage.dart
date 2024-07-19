import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/artikel.dart';
import 'package:koimedic/screens/artikel_detail.dart';
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
  final user = FirebaseAuth.instance.currentUser;
  String farmName = 'Loading...';
  final ArticleController articleController = Get.put(ArticleController());

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _fetchFarmName();
    }
  }

  Future<void> _fetchFarmName() async {
    try {
      DocumentSnapshot farmData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      setState(() {
        farmName = farmData['namafarm'] ?? 'No Farm Name';
      });
    } catch (e) {
      setState(() {
        farmName = 'Error fetching name';
      });
    }
  }

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
        title: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              "Hi, $farmName \nMulai diagnosa ikan Koi anda!",
              style: const TextStyle(
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
            ),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: articleController.articles.length,
                itemBuilder: (context, index) {
                  final article = articleController.articles[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            article.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          article.title,
                          style: const TextStyle(
                            fontFamily: "Urbanist-Bold",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          "Read more...",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        onTap: () {
                          Get.to(() => ArticleDetailPage(article: article));
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
