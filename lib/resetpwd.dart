import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/checkmail.dart';
import 'package:home_page/validation.dart';
import 'package:home_page/widget/loading_dialog.dart';
import 'package:lottie/lottie.dart';

import 'dashboard_screen.dart';

class ResetPwd extends StatefulWidget {
  const ResetPwd({Key? key}) : super(key: key);

  @override
  State<ResetPwd> createState() => _ResetPwdState();
}

class _ResetPwdState extends State<ResetPwd> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  void resetPassword() async {
    try {
      LoadingDialog.showLoadingDialog();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
      LoadingDialog.hideLoading();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CheckMail()));
    } catch (e) {
      LoadingDialog.hideLoading();
      LoadingDialog.showErrorToast("Something went wrong please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 30,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios, color: Color(0xE80A0A0A)),
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
                    "Check your email",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  "Enter the email address\n associated with your account.",
                  style: TextStyle(fontSize: 16),
                )),
                Center(
                  child: Text(
                    "getting started !",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    decoration: const InputDecoration(

                      prefixIcon: Icon(Icons.email),

                      fillColor: Color.fromRGBO(0, 0, 0, 490),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Your Email",
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: InkWell(
                    onTap: () {
                      resetPassword();
                      // if(_key.currentState!.validate()){
                      //   Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //       builder: (context) => DashboardScreen()),
                      // );
                      // }
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
                        "Sent Email",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.of(context).pop();
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
                //     child: Text("Edit phone number?"),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
    //   return SafeArea(
    //     child: Scaffold(
    //       body: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Column(
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 InkWell(
    //                   child: const Icon(Icons.arrow_back_sharp),
    //                   onTap: () {
    //                     Navigator.of(context).pop();
    //                   },
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 40,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: const [
    //                 Text(
    //                   "Reset password",
    //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 15,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: const [
    //                 Text(
    //                   "Enter the email address\n associated with your account.",
    //                   textAlign: TextAlign.center,
    //                 )
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             Form(
    //               key: _key,
    //               child: Padding(
    //                 padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
    //                 child: TextFormField(
    //                   controller: _email,
    //                   validator: (value) => Validators.validateEmail(value),
    //                   decoration: const InputDecoration(
    //                       filled: true,
    //                       fillColor:
    //                           Color.fromRGBO(189, 187, 187, 0.5647058823529412),
    //                       border: OutlineInputBorder(
    //                         borderSide: BorderSide.none,
    //                       ),
    //                       contentPadding: EdgeInsets.symmetric(horizontal: 12),
    //                       hintText: "Your email"),
    //                 ),
    //               ),
    //             ),
    //             InkWell(
    //               onTap: () {
    //                 if (_key.currentState!.validate()) {
    //                   resetPassword();
    //                 }
    //               },
    //               child: Container(
    //                 height: 50,
    //                 margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
    //                 alignment: Alignment.center,
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(5),
    //                     color: Colors.blueAccent),
    //                 child: const Text(
    //                   "Sent Email",
    //                   style: TextStyle(
    //                       color: Colors.white, fontWeight: FontWeight.bold),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
  }
}
