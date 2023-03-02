import 'package:flutter/material.dart';
import 'package:home_page/screens/signin.dart';

class CheckMail extends StatefulWidget {
  const CheckMail({Key? key}) : super(key: key);

  @override
  State<CheckMail> createState() => _CheckMailState();
}

class _CheckMailState extends State<CheckMail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 170.0,top: 170.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const  Align(
                alignment: Alignment.center,
              ),
              const Spacer(),
              const Text(
                "Check your email",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                height: 70,
                width: 70,
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 50),
              ),
              const Text(
                "Enter the email address associated \n with your account.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 100),
             // const Spacer(flex: 1),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);
                },
              child: Container(
                        height: 50,
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                         // top: 20,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(width: 1.2),
                          color: Color(0x881CD7DB),
                        ),
                        child: const Text(
                          "Go Back",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}