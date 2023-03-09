import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/homepage.dart';
import 'package:home_page/make_own_plan.dart';
import 'package:home_page/signin.dart';
import 'package:home_page/splash_screen.dart';
import 'package:home_page/widget/favourite.dart';

import 'dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: MakeOwnPlan(),
      debugShowCheckedModeBanner: false,
    );
  }
}


