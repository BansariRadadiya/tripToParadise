import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/dashboard_screen.dart';
import 'package:home_page/homepage.dart';
import 'package:home_page/resetpwd.dart';
import 'package:home_page/signup.dart';
import 'package:home_page/validation.dart';
import 'package:home_page/widget/loading_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

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
          UserProfile.name = res['name'];
          UserProfile.profile = res['profile'];
          SharedPreferences _pref = await SharedPreferences.getInstance();
          _pref.setString("name", res['name']);
          _pref.setString("id", res['id']);
          _pref.setString("userName", res['userName']);
          _pref.setString("profile", res['profile']);
          LoadingDialog.hideLoading();
          LoadingDialog.showSuccessToast("Login Successfully");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DashboardScreen()));
        }
      }
    } catch (e) {
      LoadingDialog.hideLoading();
      LoadingDialog.showErrorToast("Something went wrong please try again");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ),
                  child: Image.asset("assets/tour_cartoon.jpg"),
                ),
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: TextFormField(
                    validator: (value) => Validators.validateEmail(value),
                    controller: _emailController,
                    decoration: const InputDecoration(
                        fillColor:
                            Color.fromRGBO(189, 187, 187, 0.5647058823529412),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        hintText: "Your email"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: TextFormField(
                    controller: _pswdController,
                    validator: (value) => Validators().validatepass(value),
                    obscureText: state,
                    decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(
                          189, 187, 187, 0.5647058823529412),
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      hintText: "Your password",
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            state = !state;
                          });
                        },
                        child: const Icon(Icons.remove_red_eye_outlined),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_key.currentState!.validate()) {
                      signIn();
                    }
                    print("success");
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blueAccent),
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                /*InkWell(
                  onTap: () {
                    google();
                    print("success");
                  },
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/google.png",
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Sign in with Google",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ResetPwd()));
                  },
                  child: const Text("Forgot Password ?"),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an Account? "),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
