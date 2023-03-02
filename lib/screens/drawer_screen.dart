// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:home_page/config/user.dart';
// import 'package:home_page/screens/login_option.dart';
// import 'package:home_page/screens/signin.dart';

// class DrawerScreen extends StatelessWidget {
//   const DrawerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     String firstLetter = UserProfile.name.toString()[0].toUpperCase();
//     //String firstLetter = user.email.toString()[0].toUpperCase();
//     String name = UserProfile.name.toString().toUpperCase();
//     return Drawer(
//       child: Column(
//         children: [
//           UserAccountsDrawerHeader(
//             accountName: Text(
//               name,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             accountEmail: Text("${UserProfile.email}"),
//             currentAccountPicture: CircleAvatar(
//               backgroundColor: Colors.black54,
//               child: Text(
//                 firstLetter,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.logout,
//               color: Colors.black,
//             ),
//             title: Text('Sign out'),
//             onTap: () {
//               showDialog(
//                   context: context,
//                   builder: (context) {
//                     return Container(
//                       child: AlertDialog(
//                         title: Text('Alert!!'),
//                         content:
//                             Text('Are you sure,that you want to Sign out?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               GoogleSignIn().disconnect();
//                               FirebaseAuth.instance.signOut();
//                               //await FacebookAuth.instance.logOut();
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => LoginOption()));
//                             },
//                             child: Text('Yes'),
//                           ),
//                           TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 Navigator.pop(context);
//                               },
//                               child: Text('No'))
//                         ],
//                       ),
//                     );
//                   });
//             },
//             // GoogleSignIn().disconnect();
//             // FirebaseAuth.instance.signOut();
//             //            Navigator.pop(context);
//             // Navigator.of(context).pushReplacementNamed('/');
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.account_circle_outlined,
//               color: Colors.black,
//             ),
//             title: Text('Profile'),
//             onTap:
//                 (() {}// ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>),
//                 ),

//             // biuldListTile('Cart', Icons.shopping_cart, () {
//             //   //Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
//             // }),
//             // biuldListTile('Orders', Icons.payment, () {
//             //   //Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
//             // }),
//             // biuldListTile('Contact us', Icons.contact_page, () {
//             //   Navigator.of(context).pushReplacementNamed(ContactUs.routeName);
//             //}
//             //  ),
//           ),
//         ],
//       ),
//     );
//   }
// }
