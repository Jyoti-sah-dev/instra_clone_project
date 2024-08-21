import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'insta_home_screen.dart';
import 'insta_login_scrren.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 2),
          () {
        checkUser();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 290),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(),
                child: Text("KriCent", style: TextStyle(color: Colors.black,fontSize: 30),),
              ),
              CupertinoActivityIndicator(),
            ],
          ),
        ),
      ),
    );

  }

  void checkUser() async {
    bool isLogin = FirebaseAuth.instance.currentUser?.uid != null;
    if (isLogin) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}
