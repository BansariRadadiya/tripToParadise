import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/dashboard_screen.dart';
import 'package:home_page/signin.dart';
import 'package:home_page/validation.dart';
import 'package:home_page/widget/loading_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool state = true;
  String gender = 'Male';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  void signUp() async {
    try {
      LoadingDialog.showLoadingDialog();
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
          email: _mailController.text, password: _pwdController.text);
      if (userCred.user != null) {
        final Map<String, dynamic> userData = {
          "name": _nameController.text,
          "userName": _userNameController.text,
          "dob": dob.text,
          "gender": gender,
          "email": _mailController.text,
          "mobile": _mobileController.text,
          "profile": "",
          "id": userCred.user!.uid
        };
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCred.user!.uid)
            .set(userData);
        SharedPreferences _pref = await SharedPreferences.getInstance();
        UserProfile.id = userCred.user!.uid;
        UserProfile.name = _nameController.text;
        UserProfile.userName = _userNameController.text;
        _pref.setString("name", _nameController.text);
        _pref.setString("id", userCred.user!.uid);
        _pref.setString("userName", _userNameController.text);
        LoadingDialog.hideLoading();
        LoadingDialog.showSuccessToast("You are Signup Successfully");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => DashboardScreen()),
            (route) => false);
      }
    } catch (e) {
      print("e == $e");
      LoadingDialog.hideLoading();
      LoadingDialog.showErrorToast("Something Went Wrong Please Try Again!!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 25),
                    child: Image.asset("assets/tour_cartoon2.jpg"),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Text(
                      "Create Account",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) =>
                          Validators().validateName(value, "Name"),
                      decoration: const InputDecoration(
                          fillColor:
                              Color.fromRGBO(189, 187, 187, 0.5647058823529412),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          hintText: "Your name"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _userNameController,
                      validator: (value) =>
                          Validators().validateName(value, "User Name"),
                      decoration: const InputDecoration(
                          fillColor:
                              Color.fromRGBO(189, 187, 187, 0.5647058823529412),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          hintText: "Your Username"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: dob,
                      validator: (value) => Validators().validatedate(value),
                      decoration: const InputDecoration(
                          fillColor:
                              Color.fromRGBO(189, 187, 187, 0.5647058823529412),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          hintText: "Your DOB"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Text("Gender"),
                            SizedBox(
                              width: 10,
                            ),
                            Radio(
                                value: "Male",
                                groupValue: gender,
                                onChanged: (String? val) {
                                  setState(() {
                                    gender = val!;
                                  });
                                }),
                            Text("Male"),
                            Radio(
                                value: "Female",
                                groupValue: gender,
                                onChanged: (String? val) {
                                  setState(() {
                                    gender = val!;
                                  });
                                }),
                            Text("Female"),
                          ],
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _mailController,
                      validator: (value) => Validators.validateEmail(value),
                      decoration: const InputDecoration(
                          fillColor:
                              Color.fromRGBO(189, 187, 187, 0.5647058823529412),
                          filled: true,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          hintText: "Your email"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _mobileController,
                      validator: (value) => Validators().validateMobile(value),
                      decoration: const InputDecoration(
                          fillColor:
                              Color.fromRGBO(189, 187, 187, 0.5647058823529412),
                          filled: true,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          hintText: "Your Mobile"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _pwdController,
                      validator: (value) =>
                          Validators().validatepass(value),
                      obscureText: state,
                      decoration: InputDecoration(
                          fillColor: const Color.fromRGBO(
                              189, 187, 187, 0.5647058823529412),
                          filled: true,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          hintText: "Password",
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  state = !state;
                                });
                              },
                              child: const Icon(Icons.remove_red_eye_rounded))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: InkWell(
                      onTap: () {
                        if (_form.currentState?.validate() ?? false) {
                          signUp();
                        }
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blueAccent),
                        child: const Text(
                          "Registration",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("already have an account? "),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop(const SignIn());
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
