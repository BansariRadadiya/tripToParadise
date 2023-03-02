import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/dashboard_screen.dart';
import 'package:home_page/screens/signin.dart';
import 'package:home_page/screens/signup.dart';
import 'package:home_page/widget/loading_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_login.dart';
import 'otp_screen.dart';
import 'phone_login.dart';
//import 'package:home_page/Screen/email_login.dart';
//import 'package:home_page/Screen/otp_screen.dart';
//import 'package:home_page/Screen/phone_login.dart';
//import 'package:home_page/Screen/signup.dart';
//import 'package:lottie/lottie.dart';

class LoginOption extends StatefulWidget {
  const LoginOption({Key? key}) : super(key: key);

  @override
  State<LoginOption> createState() => _LoginOptionState();
}

class _LoginOptionState extends State<LoginOption> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void google() async {
    GoogleSignInAccount? account = await _googleSignIn.signIn();

    if (account != null) {
      GoogleSignInAuthentication credential = await account.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: credential.idToken,
        accessToken: credential.accessToken,
      );
      final userCred = await _auth.signInWithCredential(authCredential);
      if (userCred.credential != null) {
        final Map<String, dynamic> userData = {
         //  "name":userCred.user!.displayName,
          "userName": userCred.user!.displayName,
          "dob": "",
          "gender": "Female",
          "email": userCred.user!.email,
          "mobile": "0",
          "profile": "",
          "id": userCred.user!.uid
        };
         await FirebaseFirestore.instance
            .collection("users")
            .doc(userCred.user!.uid)
            .set(userData);
        SharedPreferences _pref = await SharedPreferences.getInstance();
        UserProfile.id = userCred.user!.uid;
        //UserProfile.name = userCred.user!.displayName.toString();
        UserProfile.userName = userCred.user!.displayName.toString();
       // _pref.setString("name", userCred.user!.displayName.toString());
        _pref.setString("id", userCred.user!.uid);
        _pref.setString("gender", "Female");
        _pref.setString("dob", "");
        _pref.setString("email", userCred.user!.email.toString());
        _pref.setString("mobile",userCred.user!.phoneNumber.toString() );
        _pref.setString("userName", userCred.user!.displayName.toString());
        LoadingDialog.hideLoading();
        LoadingDialog.showSuccessToast("You are Signup Successfully");
        
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => DashboardScreen()),
            (route) => false);
        // print("-----------Success----------");
        // print(userCred.additionalUserInfo);
        // LoadingDialog();
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => DashboardScreen(),
        // ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Container(
            //   height: double.infinity,
            //   width: double.infinity,
            //   child: Image.asset("assets/background_all.png", fit: BoxFit.fill),
            // ),
            SingleChildScrollView(
              child: Column(
                children: [
                  // Container(
                  //   height: 300,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Color(0x7BF5B7E9),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //       top: 30,
                  //       left: 10,
                  //       right: 10,
                  //     ),
                  //     child: Text(
                  //       "Life is short and the world is wide, the sooner you start exploring it, the better.",
                  //       style: TextStyle(fontSize: 35),
                  //     ),
                  //   ),
                  // ),

                  // Login with phone number........................

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Text(
                      "Trip To Paradise",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0), //position of shadow
                            blurRadius: 6.0, //blur intensity of shadow
                            color: Colors.lightBlueAccent.withOpacity(
                                0.8), //color of shadow with opacity
                          ),
                        ],
                        fontWeight: FontWeight.bold,
                        // foreground: Paint()
                        //   ..shader = LinearGradient(
                        //     colors: <Color>[
                        //       Color(0xE822E6EF),
                        //       Color(0xE822E6EF),
                        //     ],
                        //   ).createShader(
                        //     Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                        //   ),
                        fontSize: 45,
                      ),
                    ),
                  ),

                  Container(
                    height: 300,
                    width: 300,
                    // margin: EdgeInsets.only(bottom: 10),
                    child: Lottie.asset("assets/roatating_planet.json",
                        fit: BoxFit.fill),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PhoneLogin(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black87,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          color: Color(0x4F92E9EC),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.phone),
                              SizedBox(width: 20),
                              Text(
                                "Login with phone number",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // login with email.........................

                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignIn(
                              )));
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 20, left: 20, top: 10),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black87,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          color: Color(0x4F92E9EC),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.email),
                              SizedBox(width: 20),
                              Text(
                                "Login with email",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Continue with google..........................

                  InkWell(
                    onTap: () {
                      google();
                      print("Success");
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 20, left: 20, top: 10),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black87,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          color: Color(0x4F92E9EC),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              Image(
                                image: AssetImage("assets/google_icon.png"),
                                width: 37,
                                height: 37,
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Continue with Google",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Don't have an account..........................

                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUp(
                                      onClickdSignIn: () {},
                                    )));
                          },
                          child:const Text(
                            " Sign up",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                 const SizedBox(height: 100,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AdminLogin(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 20),
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black87,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(40),
                              ),
                              color: const Color(0x4F92E9EC),
                            ),
                            child: Center(
                              child: Row(
                                children: const[
                                  SizedBox(width: 20),
                                  Text(
                                    "Login As Admin",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
