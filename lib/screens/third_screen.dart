import 'package:flutter/material.dart';

import 'login_option.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/thirdpage.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 170,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(5),
    border: Border.all(width: 1, color: Colors.white,)
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(5),
    border: Border.all(width: 1, color: Colors.white,)
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 17,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: Colors.black)
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    width: 120,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginOption()),
                            (route) => false);
                      },
                      child: Text(
                        "Get Start >>",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: "Poppins"),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black12,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          //side: BorderSide(width: 1,color:Colors.black)
                        ),
                      ),
                    ),
                  ),
                ),
                // TextButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.black12,
                //       shape: ContinuousRectangleBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(30),
                //         ),
                //         // side: BorderSide(color: Colors.black,width: 3)
                //       ),
                //     ),
                //     onPressed: () {},
                //     child: Text(
                //       "",
                //       style: TextStyle(
                //         fontFamily: "Poppins",
                //         color: Colors.white,
                //         fontWeight: FontWeight.w900,
                //         fontSize: 17,
                //       ),
                //     )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        )
      ],
    );
  }
}
