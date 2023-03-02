import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/dashboard_screen.dart';
import 'package:home_page/screens/signin.dart';
import 'package:home_page/validation.dart';
import 'package:home_page/widget/loading_dialog.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  final Function() onClickdSignIn;
  const SignUp({Key? key, required this.onClickdSignIn}) : super(key: key);

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
  final TextEditingController _repwdController = TextEditingController();

  bool state = true;
  bool state2 = true;
  String gender = 'Male';
  bool? year;

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
       // UserProfile.name = _nameController.text;
        UserProfile.userName = _userNameController.text;
      //  _pref.setString("name", _nameController.text);
        _pref.setString("id", userCred.user!.uid);
        _pref.setString("userName", _userNameController.text);
        LoadingDialog.hideLoading();
        LoadingDialog.showSuccessToast("You are Signup Successfully");
        
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => DashboardScreen()),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      print("e == $e");
      if (e.code == 'email-already-in-use') {
        LoadingDialog.hideLoading();
        LoadingDialog.showErrorToast("Email Already Exists.");
      } else if (e.code == 'weak-password') {
        LoadingDialog.hideLoading();
        LoadingDialog.showErrorToast("Weak Password");
      }
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
                  Text(
                    "Create Account",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    child: Lottie.asset("assets/roatating_planet.json",
                        fit: BoxFit.fill),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _userNameController,
                      validator: (value) =>
                          Validators().validateName(value, "User Name"),
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(0, 0, 0, 490),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Username"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1960),
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          //print(pickedDate);
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);

                          setState(() {
                            if (DateTime.now().year - pickedDate.year >= 18) {
                              year = true;
                            } else {
                              year = false;
                            }
                            dob.text = formattedDate;
                          });
                        } else {
                          //print("Date is not selected");
                        }
                      },
                      controller: dob,
                      //  validator: (value) => Validators().validatedate(value),
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(0, 0, 0, 490),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "DOB"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter DOB';
                        } else if (year == false) {
                          return 'Age Must be 18';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 15, top: 10),
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
                          fillColor: Color.fromRGBO(0, 0, 0, 490),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Email"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _mobileController,
                      validator: (value) => Validators().validateMobile(value),
                      decoration: const InputDecoration(
                          fillColor: Color.fromRGBO(0, 0, 0, 490),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Mobile"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _pwdController,
                      validator: (value) => Validators().validatepass(value),
                      obscureText: state,
                      decoration: InputDecoration(
                          fillColor: Color.fromRGBO(0, 0, 0, 490),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Password",
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                state = !state;
                              });
                            },
                            child: const Icon(Icons.remove_red_eye_rounded),
                          )),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _repwdController,
                      //validator: (value) => Validators().validatepass(value),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        } else if (value.length < 9) {
                          return 'Must be more than 8 charater';
                        } else if (_pwdController.value !=
                            _repwdController.value) {
                          return 'Password Not Match';
                        }
                        return null;
                      }),
                      obscureText: state2,
                      decoration: InputDecoration(
                          fillColor: Color.fromRGBO(0, 0, 0, 490),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Re-password",
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                state2 = !state2;
                              });
                            },
                            child: const Icon(Icons.remove_red_eye_rounded),
                          )),
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
                        if (_form.currentState!.validate()) {
                          signUp();
                        }
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(width: 1.2),
                          color: Color(0x881CD7DB),
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
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
                          widget.onClickdSignIn;
                          // Navigator.of(context).pop(const SignIn());
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.blueGrey,
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
