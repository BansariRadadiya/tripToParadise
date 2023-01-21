import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/checkmail.dart';
import 'package:home_page/validation.dart';
import 'package:home_page/widget/loading_dialog.dart';

class ResetPwd extends StatefulWidget {
  const ResetPwd({Key? key}) : super(key: key);

  @override
  State<ResetPwd> createState() => _ResetPwdState();
}

class _ResetPwdState extends State<ResetPwd> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  void resetPassword() async{
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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: const Icon(Icons.arrow_back_sharp),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Reset password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Enter the email address\n associated with your account.",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                  child: TextFormField(
                    controller: _email,
                    validator: (value) => Validators.validateEmail(value),
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor:
                            Color.fromRGBO(189, 187, 187, 0.5647058823529412),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        hintText: "Your email"),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_key.currentState!.validate()) {
                    resetPassword();
                  }
                },
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueAccent),
                  child: const Text(
                    "Sent Email",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
