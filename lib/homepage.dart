import 'dart:ui';
//after first commit.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_page/asia.dart';
import 'package:home_page/category.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/favourites.dart';
import 'package:home_page/main.dart';
import 'package:home_page/package_screen.dart';
import 'package:home_page/screens/drawer_screen.dart';
import 'package:home_page/screens/drawer_screen/manage_place.dart';
import 'package:home_page/screens/login_option.dart';
import 'package:home_page/setting.dart';
import 'package:home_page/widget/favourite.dart';
import 'package:home_page/widget/search_page.dart';
import 'package:home_page/config/global.dart' as globals ;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tabButton = ["All", "Asia", "Europe", "America", "Oceania"];
  String firstLetter = "U";
  String uname = "User";

  int selectButton = 0;
  int button = 0;
  List<String> category = [
    "assets/mountain.png",
    "assets/beach.png",
    "assets/history.png",
    "assets/desert.png",
  ];
  List<String> name = ["Mountains", "Beach", "History", "Desert"];

  List appSpecial = [
    {
      'name': 'Safety insured',
      'description': 'There are many variations of passages lorem.',
      'icon': Icons.masks_outlined
    },
    {
      'name': 'Become a Sponsor',
      'description': 'There are many variations of passages lorem.',
      'icon': Icons.attach_money
    },
    {
      'name': '24x7 Help & Support',
      'description': 'There are many variations of passages lorem.',
      'icon': Icons.add_ic_call_rounded
    },
  ];
  bool selectedIcon = true;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> recommendedList = [];
  List<List<QueryDocumentSnapshot<Map<String, dynamic>>>> packageList = [];

  @override
  void initState() {
    super.initState();
    getData();
    getRecommended();
    if (UserProfile.userName.isNotEmpty) {
      uname = UserProfile.userName.toString().toUpperCase();
    } else {
      uname = 'User';
    }
    if (UserProfile.userName.isNotEmpty) {
      firstLetter =
          UserProfile.userName.toString().split("").first.toUpperCase();
      // String firstLetter = UserProfile.userName.toString().split("").first.toUpperCase();
    } else {
      firstLetter = 'U';
    }
  }

  void getData() async {
    final QuerySnapshot<Map<String, dynamic>> snap =
        await FirebaseFirestore.instance.collection("places").get();
    setState(() {
      dataList = snap.docs;
      for (var e in tabButton) {
        if (e == "All") {
          packageList.add(dataList);
        } else {
          packageList.add(
              dataList.where((element) => element['location'] == e).toList());
        }
      }
    });
    print(dataList.length);
  }

  void getRecommended() async {
    final QuerySnapshot<Map<String, dynamic>> snap =
        await FirebaseFirestore.instance.collection("recommended").get();
    setState(() {
      recommendedList = snap.docs;
    });
    print(dataList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          UserProfile.userName == ""
              ? "User"
              : "${UserProfile.userName.toUpperCase()}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
    drawer: globals.isAdmin == true
        ? Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              uname == null ? "User" : uname,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              '${UserProfile.email}',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            // Text("${UserProfile.email}",style: TextStyle(color: Colors.white,fontSize: 18),),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black54,
              child: Text(
                firstLetter == null ? "U" : firstLetter,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: Text('Sign out'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: AlertDialog(
                        title: Text('Alert!!'),
                        content: Text(
                            'Are you sure,that you want to Sign out?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              GoogleSignIn().disconnect();
                              FirebaseAuth.instance.signOut();
                              //await FacebookAuth.instance.logOut();
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginOption()));
                            },
                            child: Text('Yes'),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('No'))
                        ],
                      ),
                    );
                  });
            },
            // GoogleSignIn().disconnect();
            // FirebaseAuth.instance.signOut();
            //            Navigator.pop(context);
            // Navigator.of(context).pushReplacementNamed('/');
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            title: Text('Profile'),
            onTap:
            (() {} // ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>),
            ),

            // biuldListTile('Cart', Icons.shopping_cart, () {
            //   Navigator.of(context).pushReplacementNamed(.routeName);
            // }),
            // biuldListTile('Orders', Icons.payment, () {
            //   //Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
            // }),
            // biuldListTile('Contact us', Icons.contact_page, () {
            //   Navigator.of(context).pushReplacementNamed(ContactUs.routeName);
            //}
            //  ),
          ),
          ListTile(
            leading: Icon(
              Icons.image_outlined,
              color: Colors.black,
            ),
            title: Text('Manage Palces'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManagePlace()));
            },
            // GoogleSignIn().disconnect();
            // FirebaseAuth.instance.signOut();
            //            Navigator.pop(context);
            // Navigator.of(context).pushReplacementNamed('/');
          ),
        ],
      ),
    )
        : Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              uname == null ? "User" : uname,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            accountEmail: Text(
              "${UserProfile.email}",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black54,
              child: Text(
                firstLetter == null ? "U" : firstLetter,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: Text('Sign out'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: AlertDialog(
                        title: Text('Alert!!'),
                        content: Text(
                            'Are you sure,that you want to Sign out?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              GoogleSignIn().disconnect();
                              FirebaseAuth.instance.signOut();
                              //await FacebookAuth.instance.logOut();
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginOption()));
                            },
                            child: Text('Yes'),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('No'))
                        ],
                      ),
                    );
                  });
            },
            // GoogleSignIn().disconnect();
            // FirebaseAuth.instance.signOut();
            //            Navigator.pop(context);
            // Navigator.of(context).pushReplacementNamed('/');
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            title: Text('Profile'),
            onTap:(){
              //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileScreen()));
              setState((){
                setState((){
                  globals.selectedIndex2 =2;
                  print('===============${globals.selectedIndex2}');
                });
              });
              Navigator.of(context).pop();
            },

          ),
        ],
      ),
    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(children: [
                const Text(
                  "Explore the world",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
                child: TextField(
                  showCursor: false,
                  readOnly: true,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchPage(
                              dataList: dataList,
                            )));
                  },
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor:
                          Color.fromRGBO(196, 196, 196, 0.5647058823529412),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),

                        borderSide: BorderSide(width: 1,color: Colors.blue),
                      ),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Where are you going?",
                      contentPadding: EdgeInsets.symmetric(horizontal: 12)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Exclusive Package",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 30,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          if (i == 5) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Asia(packageList: packageList),
                            ));
                          } else {
                            setState(() {
                              selectButton = i;
                            });
                          }
                        },
                        child: Container(
                          // margin: EdgeInsets.only(left: 1),
                          height: 30,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(400),
                            color: selectButton == i ? Colors.blue : null,
                          ),
                          child: Center(
                            child: i == 5
                                ? const Icon(
                                    Icons.arrow_forward,
                                    size: 25,
                                  )
                                : Text(
                                    tabButton[i],
                                    style: TextStyle(
                                        color: selectButton == i
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 250,
                margin: const EdgeInsets.only(bottom: 20),
                child: packageList.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: packageList[selectButton].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          final data = packageList[selectButton][i];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => Package(
                                            data: data,
                                          )))
                                  .whenComplete(() => setState(() {}));
                            },
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          height: 180,
                                          width: 280,
                                          child: Image(
                                            image:
                                                NetworkImage(data['images'][0]),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 250),
                                        child: InkWell(
                                          onTap: () async {
                                            await Favourite.updateFavourite(
                                                data.id);
                                            setState(() {});
                                          },
                                          child: Container(
                                            child: UserProfile.favouriteList
                                                    .contains(data.id)
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : Icon(Icons.favorite_border,
                                                    color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 60,
                                    width: 250,
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data['name'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(
                                              "South Asia",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amberAccent,
                                        ),
                                        const Text(
                                          "4.6",
                                          style: TextStyle(
                                              color: Colors.amberAccent),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
              ),
              const SizedBox(
                height: 10,
              ),

              ///exclusive package
              const Text(
                "Explore Category",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                ///explore category
                height: 130,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (context) => Categ(
                                    index: i,
                                    dataList: dataList,
                                  ),
                                ),
                              )
                              .whenComplete(() => setState(() {}));
                        },
                        child: Container(
                          height: 120,
                          width: 90,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 55,
                                child: ClipRRect(
                                  child: Image.asset(
                                    category[i],
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                name[i],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 22,
              ),

              ///category
              const Text(
                "Recommended Package",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                height: 200,
                color: Colors.white,
                child: recommendedList.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recommendedList.length,
                        itemBuilder: (context, i) {
                          final data = recommendedList[i];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Package(data: data)));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 250,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      data['images'][0],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 250,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green,
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.black54,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      tileMode: TileMode.clamp,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 175,
                                  top: 20,
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: InkWell(
                                      onTap: () async {
                                        await Favourite.updateFavourite(
                                            data.id);
                                        setState(() {});
                                      },
                                      child: Container(
                                        child: UserProfile.favouriteList
                                                .contains(data.id)
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : Icon(Icons.favorite_border,
                                                color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 135,
                                  left: 20,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "${data['name']}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25),
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "App Special",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, i) {
                  return Container(
                    height: 50,
                    width: 200,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.yellow,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(left: 1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.withOpacity(0.2),
                          ),
                          child: Icon(
                            appSpecial[i]['icon'],
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(appSpecial[i]['name']),
                              const SizedBox(
                                height: 2,
                              ),
                              Flexible(
                                child: Text(
                                  appSpecial[i]['description'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
