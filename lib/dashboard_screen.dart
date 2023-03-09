import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/favourites.dart';
import 'package:home_page/homepage.dart';
import 'package:home_page/profile.dart';
import 'package:home_page/profile_screen.dart';
import 'config/global.dart' as globals;
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  void getFavouriteList() async {
    final DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection("favourite")
        .doc(UserProfile.id)
        .get();
    UserProfile.favouriteList = data['favourite'];
  }

  void initState() {
    getFavouriteList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: [
          HomePage(),
          Favorites(),
          ProfileScreen(),
        ].elementAt(globals.selectedIndex2),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: globals.selectedIndex2,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined), label: "Profile"),
            ],
            onTap: (value) {
              setState(() {
               globals.selectedIndex2 = value;
              });
            }),
      ),
    );
  }
}
