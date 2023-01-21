import 'package:flutter/material.dart';
import 'package:home_page/favourites.dart';
import 'package:home_page/homepage.dart';
import 'package:home_page/profile.dart';

import 'MyBooking.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
                },
                child: Column(
                  children:[
                    Icon(
                      Icons.home_filled,
                      color: Colors.grey,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Favorites()));
                },
                child: Column(
                  children: const [
                    Icon(
                      Icons.favorite,
                      color: Colors.grey,
                    ),
                    Text(
                      "Favorite",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Setting()));
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                    Text(
                      "More",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // child: SizedBox(
        //   height: 50,
        //   child: Column(
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           InkWell(
        //             onTap: () {
        //               Navigator.of(context).push(
        //                 MaterialPageRoute(
        //                   builder: (context) => const HomePage(),
        //                 ),
        //               );
        //             },
        //             child: const Icon(
        //               Icons.home_filled,
        //               color: Colors.grey,
        //             ),
        //           ),
        //           InkWell(
        //             onTap: () {
        //               Navigator.of(context).push(
        //                 MaterialPageRoute(
        //                   builder: (context) => const Favorites(),
        //                 ),
        //               );
        //             },
        //             child: const Icon(
        //               Icons.favorite,
        //               color: Colors.grey,
        //             ),
        //           ),
        //           InkWell(
        //             onTap: () {
        //               Navigator.of(context).push(
        //                   MaterialPageRoute(builder: (context) => Setting()));
        //             },
        //             child: Icon(
        //               Icons.more_vert,
        //               color: Colors.grey,
        //             ),
        //           ),
        //         ],
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: const [
        //           Text(
        //             "home",
        //             style: TextStyle(color: Colors.grey),
        //           ),
        //           Text(
        //             "favorite",
        //             style: TextStyle(color: Colors.grey),
        //           ),
        //           Text(
        //             "more",
        //             style: TextStyle(color: Colors.grey),
        //           )
        //         ],
        //       )
        //     ],
        //   ),
        // ),
      ),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///profile
            SizedBox(
              height: 100,
              width: 360,
              // margin: EdgeInsets.all(10),
              // color: Colors.redAccent,
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.only(left: 5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.red,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: Image.network(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Jit Banik",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "jit.banik@mail.com",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Liner(),

            ///account
            const Padding(
              padding: EdgeInsets.only(left: 13, top: 15),
              child: Text("Account"),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Profile(),
                  ),
                );
              },
              child: SizedBox(
                height: 70,
                width: double.infinity,
                // color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Your Profile",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Liner(),
            SizedBox(
              height: 70,
              width: double.infinity,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.payment_outlined,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Payment History",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Liner(),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyBooking(),
                  ),
                );
              },
              child: SizedBox(
                height: 70,
                width: double.infinity,
                // color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "My Booking",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Liner(),
            SizedBox(
              height: 70,
              width: double.infinity,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const  [
                    Icon(
                      Icons.pie_chart_rounded,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Your offers",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Liner(),
            SizedBox(
              height: 70,
              width: double.infinity,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.flag_rounded,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "All Country",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Liner(),

            ///setting
            const Padding(
              padding: EdgeInsets.only(top: 8, left: 8),
              child: Text("Setting"),
            ),
            SizedBox(
              height: 70,
              width: double.infinity,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.language_rounded,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Language",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Liner(),
            SizedBox(
              height: 70,
              width: double.infinity,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.dark_mode,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Dark Mood",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Liner(),

            ///help and legal
            const Padding(
              padding: EdgeInsets.only(top: 8, left: 8),
              child: Text("Help & Legal"),
            ),
            SizedBox(
              height: 70,
              width: double.infinity,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.emergency_outlined,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Emergency Support",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Liner(),
            SizedBox(
              height: 70,
              width: double.infinity,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.help,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Help",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Liner(),
            SizedBox(
              height: 70,
              width: double.infinity,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.dangerous_outlined,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Terms & conditions",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Liner(),
            SizedBox(
              height: 70,
              width: double.infinity,
              // color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.logout_rounded,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Logout",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

///custom widget
class Liner extends StatelessWidget {
  const Liner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 5),
      height: 1,
      width: 390,
      color: Colors.black12,
    );
  }
}
