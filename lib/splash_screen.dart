import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/dashboard_screen.dart';
import 'package:home_page/screens/login_option.dart';
import 'package:home_page/screens/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), (){
      checkLogin();
    });
  }


  void checkLogin()async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? id = _pref.getString('id');
    print("Here id == $id");
    if (id != null) {
      final data = await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .get();
      if (data.data() != null && data.exists) {
        final res = data.data();
        UserProfile.userName = res!['userName'];
        UserProfile.id = res['id'];
       // UserProfile.name = res['name'];
        UserProfile.profile = res['profile'];
        SharedPreferences _pref = await SharedPreferences.getInstance();
       // _pref.setString("name", res['name']);
        _pref.setString("id", res['id']);
        _pref.setString("userName", res['userName']);
        _pref.setString("profile", res['profile']);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DashboardScreen()));
      } else {
        print("Here");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginOption()), (
            route) => false);
      }
    }else{
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginOption()), (
          route) => false);
    }
  }

  final MovieTween tween = MovieTween()
    ..scene(
        begin: const Duration(milliseconds: 0),
        end: const Duration(milliseconds: 1000))
        .tween('width', Tween(begin: 0.0, end: 100.0))
    ..scene(
        begin: const Duration(milliseconds: 1000),
        end: const Duration(milliseconds: 1500))
        .tween('width', Tween(begin: 100.0, end: 200.0))
    ..scene(
        begin: const Duration(milliseconds: 0),
        duration: const Duration(milliseconds: 2500))
        .tween('height', Tween(begin: 0.0, end: 200.0))
    ..scene(
        begin: const Duration(milliseconds: 0),
        duration: const Duration(milliseconds: 3000))
        .tween('color', ColorTween(begin: Colors.red, end: Colors.blue));




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children:[ 
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset("assets/splash_icon.png",fit: BoxFit.contain,)),
    ]));
  }
}
