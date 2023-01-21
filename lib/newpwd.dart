import 'package:flutter/material.dart';

class NewPwd extends StatefulWidget {
  const NewPwd({Key? key}) : super(key: key);

  @override
  State<NewPwd> createState() => _NewPwdState();
}

class _NewPwdState extends State<NewPwd> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Create New Password",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Your new password must be different\nfrom previous used passwords",textAlign: TextAlign.center,)
                ],
              ),
              const SizedBox(height: 15,),
              const  Padding(
                padding: EdgeInsets.only(top: 8,right: 8,left: 8,bottom: 4),
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor:  Color.fromRGBO(189, 187, 187, 0.5647058823529412),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      hintText: "Password"
                  ),
                ),
              ),
              const Padding(
                padding:  EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor:  Color.fromRGBO(189, 187, 187, 0.5647058823529412),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      hintText: "Confirm Password"
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 360,
                margin: const EdgeInsets.only(top: 1,left: 5,right: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blueAccent
                ),
                child: const Text("Reset Password",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}