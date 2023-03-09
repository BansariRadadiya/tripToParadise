import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/widget/loading_dialog.dart';
import 'package:lottie/lottie.dart';
import 'otp_screen.dart';
import '../widget/globals.dart' as global;

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _countryCode = TextEditingController();
  TextEditingController _number = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList = [];
  int number = 0;

  void getData() async {
    final QuerySnapshot<Map<String, dynamic>> snap =
        await FirebaseFirestore.instance.collection("users").get();
    setState(() {
      dataList = snap.docs;
      print("=====================data list ${dataList.length}");
      print("${dataList[0]['mobile']}");
      for (int i = 0; i < dataList.length; i++) {
        if (dataList[i]['mobile'] == _number.text.toString().trim()) {
          number = dataList[i]['mobile'];
          print("===========in getData    $number");
        }
      }
    });
  }

  @override
  void initState() {
    _countryCode.text = "+91";
    getData();
    super.initState();
  }

  Future sendOTP() async {
    LoadingDialog.showLoadingDialog();
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91${_number.text}",
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (verificationFailed) {
          print(verificationFailed);
        },
        codeSent: (verificationID, resendingToken) async {
          setState(() {
            LoadingDialog.hideLoading();
            LoadingDialog.showSuccessToast("OTP Send Successfully!");
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => OtpScreen()));
            global.verificationId = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (verificationID) async {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  child: Lottie.asset("assets/roatating_planet.json",
                      fit: BoxFit.fill),
                ),
                Text(
                  "Phone Verification",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "We need to register your phone before",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "getting started !",
                  style: TextStyle(fontSize: 16),
                ),
                Form(
                  key: _key,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25, left: 3, right: 3, bottom: 10),
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 50,
                            child: TextField(
                              controller: _countryCode,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              readOnly: true,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "|",
                            style: TextStyle(fontSize: 30, color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _number,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "Phone"),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter phone number';
                                } else if (value.length < 10 ||
                                    value.length > 10) {
                                  return 'Please enter valid number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (_key.currentState!.validate()) {
                        print("==================$number");
                        sendOTP();
                        // if (_number == number) {
                        //   sendOTP();
                        // } else {
                        //   LoadingDialog.hideLoading();
                        //   LoadingDialog.showErrorToast(
                        //       "number is not register");
                        // }
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context) => OtpScreen()),
                        // );
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
                        "Send OTP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
