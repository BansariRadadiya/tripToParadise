//import 'dart:html';
//priti
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_page/checkmail.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/screens/auth.dart';
import 'package:home_page/screens/login_option.dart';
import 'package:home_page/screens/signin.dart';
import 'package:home_page/splash_screen.dart';
import 'package:home_page/widget/favourite.dart';
import 'package:home_page/widget/loading_dialog.dart';
import 'package:home_page/widget/mapdemo.dart';

import 'dashboard_screen.dart';
import 'screens/first_screen.dart';

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
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: StreamBuilder<User?>(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: ((context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text('Something Went Wrong!!!'),
//                 );
//               } else if (snapshot.hasData) {
//                 return DashboardScreen ();
//               } else {
//                 return Auth();
//               }
//             })),
//       );
// }
