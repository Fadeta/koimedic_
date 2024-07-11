import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koimedic/screens/dashboard.dart';
import 'package:koimedic/screens/diagnosa/diagnosamodel.dart';
import 'package:koimedic/screens/fade_animation.dart';
import 'package:koimedic/screens/models/koi_data.dart';
import 'package:koimedic/widget/common.dart';

class Diagnosapage extends StatefulWidget {
  const Diagnosapage({super.key});

  @override
  State<Diagnosapage> createState() => _DiagnosapageState();
}

class _DiagnosapageState extends State<Diagnosapage> {
  final _formKey = GlobalKey<FormState>();
  final _koiData = KoiData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeAnimation(
                delay: 1,
                child: IconButton(
                  onPressed: () {
                    Get.to(const Dashboard());
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    size: 35,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FadeAnimation(
                  delay: 1.3,
                  child: Text(
                    "Isi biodata terlebih dahulu\nuntuk mendiagnosa ikan koi anda!",
                    style: Common().titelTheme,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onSaved: (value) {
                  _koiData.name = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Name Koi',
                  contentPadding: const EdgeInsets.all(18),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name of the Koi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                onSaved: (value) {
                  _koiData.species = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Jenis Koi',
                  contentPadding: const EdgeInsets.all(18),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the species of the Koi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                onSaved: (value) {
                  _koiData.age = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Umur',
                  contentPadding: const EdgeInsets.all(18),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the age of the Koi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Diagnosamodel(koiData: _koiData),
                        ),
                      );
                    }
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
                    "Selanjutnya",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: "Urbanist-SemiBold",
                      fontWeight: FontWeight.bold,
                    ),
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
