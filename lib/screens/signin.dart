import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/dashboard_screen.dart';
import 'package:home_page/homepage.dart';
import 'package:home_page/resetpwd.dart';
import 'package:home_page/screens/signup.dart';
import 'package:home_page/validation.dart';
import 'package:home_page/widget/loading_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_page/config/global.dart' as globals;

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pswdController = TextEditingController();
  bool state = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Future signIn() async {
  //   // showDialog(
  //   //     context: context,
  //   //     barrierDismissible: true,
  //   //     builder: (context) => Center(
  //   //           child: CircularProgressIndicator(),
  //   //         ));
  //   LoadingDialog.showLoadingDialog();
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _pswdController.text.trim());
  //       Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => DashboardScreen()));
  //     print("Successful");
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     if (e.code == 'user-not-found') {
  //       print('Account Already Exists.');
  //       LoadingDialog.hideLoading();
  //       LoadingDialog.showErrorToast("User Not Found");
  //       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       //   backgroundColor: Colors.red[500],
  //       //   content: Text('User Not Found'),
  //       //));
  //     } else if (e.code == 'wrong-password') {
  //       print('Account Already Exists.');
  //       LoadingDialog.hideLoading();
  //       LoadingDialog.showErrorToast("Wrong Password");
  //       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       //   backgroundColor: Colors.red[500],
  //       //   content: Text('Wrong Password'),
  //       // ));
  //     }
  //     // Utils.showSnackBar(e.message);
  //   }

  //   //navigatorKey.currentState!.popUntil((route) => route.isFirst);
  // }

  void signIn() async {
    try {
      LoadingDialog.showLoadingDialog();
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _pswdController.text,
      );
      if (userCred.user != null) {
        final data = await FirebaseFirestore.instance
            .collection("users")
            .doc(userCred.user!.uid)
            .get();
        if (data.data() != null && data.exists) {
          final res = data.data();
          UserProfile.userName = res!['userName'];
          UserProfile.id = res['id'];
          // UserProfile.name = res['name'];
          UserProfile.profile = res['profile'];
          UserProfile.email = res['email'];
          SharedPreferences _pref = await SharedPreferences.getInstance();
          //  _pref.setString("name", res['name']);
          _pref.setString("id", res['id']);
          _pref.setString("userName", res['userName']);
          _pref.setString("profile", res['profile']);
          _pref.setString("email", res['email']);
          // _pref.setBool('isLogin', true);
          LoadingDialog.hideLoading();
          LoadingDialog.showSuccessToast("Login Successfully");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DashboardScreen()));
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        print('Account Already Exists.');
        LoadingDialog.hideLoading();
        LoadingDialog.showErrorToast("User Not Found");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   backgroundColor: Colors.red[500],
        //   content: Text('User Not Found'),
        //));
      } else if (e.code == 'wrong-password') {
        print('Account Already Exists.');
        LoadingDialog.hideLoading();
        LoadingDialog.showErrorToast("Wrong Password");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   backgroundColor: Colors.red[500],
        //   content: Text('Wrong Password'),
        // ));
      }
    }
  }

  /*void google() async {
    GoogleSignInAccount? account = await _googleSignIn.signIn();

    if (account != null) {
      GoogleSignInAuthentication credential = await account.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: credential.idToken,
        accessToken: credential.accessToken,
      );
      final userCred = await _auth.signInWithCredential(authCredential);
      if (userCred.credential != null) {
        print("-----------Success----------");
        print(userCred.additionalUserInfo);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      }
    }
  }*/
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading:  Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios,
                color: Color(0xE80A0A0A)),
          ),
        ), ),
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                               Center(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Lottie.asset("assets/roatating_planet.json",
                        fit: BoxFit.fill),
                  ),
                ),
                const Center(
                  child: Text(
                    "Sign In with Email",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    left: 10,
                    right: 10,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      fillColor: Color.fromRGBO(0, 0, 0, 490),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Email",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains(".com") &&
                          !value.contains("@gmail")) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: TextFormField(
                    obscureText: _obscureText,
                    controller: _pswdController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.key),
                      fillColor: const Color.fromRGBO(0, 0, 0, 490),
                      filled: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Password",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ResetPwd()));
                          },
                          child: const Text("Forgot Password?",style: TextStyle(decoration: TextDecoration.underline)),
                        ),
                      ]),
                ),
                InkWell(
                  onTap: () {
                    if (_key.currentState!.validate()) {
                      if (_emailController.text.toString().trim() ==
                              "admin@gmail.com" &&
                          _pswdController.text.toString().trim() ==
                              "admin@123") {
                        LoadingDialog.hideLoading();
                        LoadingDialog.showErrorToast("Wrong Id & Password");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignIn()));
                      } else {
                        setState(() {
                          globals.isAdmin=false;
                        });
                        signIn();
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 20,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 1.2),
                      color: const Color(0x881CD7DB),
                    ),
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
