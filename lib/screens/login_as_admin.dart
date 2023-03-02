import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginAsAdmin extends StatefulWidget {
  const LoginAsAdmin({super.key});

  @override
  State<LoginAsAdmin> createState() => _LoginAsAdminState();
}

class _LoginAsAdminState extends State<LoginAsAdmin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pswdController = TextEditingController();
  bool state = true;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
 @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // SizedBox(
            //   height: double.infinity,
            //   width: double.infinity,
            //   child: Image.asset(
            //     "assets/background_all.png",
            //     fit: BoxFit.fill,
            //   ),
            // ),
            SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        top: 20,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back_ios,
                            color: Color(0xE80A0A0A)),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 300,
                        width: 300,
                        child: Lottie.asset("assets/roatating_planet.json",
                            fit: BoxFit.fill),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Sign In As Admin",
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
                        controller: _emailController,
                        decoration: const InputDecoration(
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
                        controller: _pswdController,
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(0, 0, 0, 490),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          hintText: "Password",
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                state = !state;
                              });
                            },
                            child: const Icon(Icons.remove_red_eye_outlined),
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
                    // Container(
                    //   padding: EdgeInsets.only(right: 10),
                    //   child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.end,
                    //       children: [
                    //         InkWell(
                    //           onTap: () {
                    //             Navigator.of(context).push(MaterialPageRoute(
                    //                 builder: (context) => ResetPwd()));
                    //           },
                    //           child: const Text("Forgot Password?"),
                    //         ),
                    //       ]),
                    // ),
                    InkWell(
                      onTap: () {
                        if (_key.currentState!.validate()) {
                        //  signIn();
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
                          color: Color(0x881CD7DB),
                        ),
                        child: const Text(
                          "Sign in As Admin",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}