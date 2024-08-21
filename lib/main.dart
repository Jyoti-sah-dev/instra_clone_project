
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instra_clone_project/firebase_options.dart';

import 'application_project/auth_controller_screen.dart';
import 'application_project/insta_login_scrren.dart';
import 'application_project/insta_registesion.dart';
import 'application_project/splash_insta_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
      getPages: [
        GetPage(name: '/register', page: () => RegistrationScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
      ],
    );
  }
}
