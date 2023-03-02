import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/dashboard_screen.dart';
import 'package:home_page/screens/phone_login.dart';
import 'package:home_page/widget/globals.dart' as global;
import 'package:home_page/widget/loading_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _optController = TextEditingController();

  
  FirebaseAuth _auth = FirebaseAuth.instance;
  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      LoadingDialog.hideLoading();
      LoadingDialog.showErrorToast("Some Error Occured. Try Again Later!!");
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  "Phone Verification",
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
                  "We need to register your phone without",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
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
                child: Pinput(
                  length: 6,
                  controller: _optController,
                  // validator: (s) {
                  //   return s == '2222' ? null : 'Pin is incorrect';
                  // },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter OTP';
                    }
                    return null;
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: InkWell(
                  onTap: () {
                    AuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: global.verificationId,
                            smsCode: _optController.text);
                    signInWithPhoneAuthCred(phoneAuthCredential);
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //       builder: (context) => DashboardScreen()),
                    // );
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
                      "Verify",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  // AuthCredential phoneAuthCredential =
                  //     PhoneAuthProvider.credential(
                  //         verificationId: verificationID,
                  //         smsCode: _optController.text);
                  // signInWithPhoneAuthCred(phoneAuthCredential);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, bottom: 20),
                  child: Text("Edit phone number?"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
