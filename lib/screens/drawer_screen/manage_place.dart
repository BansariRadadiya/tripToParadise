import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_page/screens/drawer_screen/add_place.dart';
import 'package:home_page/screens/drawer_screen/edit_place.dart';

class ManagePlace extends StatefulWidget {
  const ManagePlace({Key? key}) : super(key: key);

  @override
  State<ManagePlace> createState() => _ManagePlaceState();
}

class _ManagePlaceState extends State<ManagePlace> {
  final firestore = FirebaseFirestore.instance.collection("User");

  getFireStore() async {
    final getdata = await firestore.get();
    getdata.docs.forEach((element) {
      print("------->${element.data()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Packages"), actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => EditPlace()));
          },
          icon: Icon(Icons.add),
        ),
      ]),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore.snapshots(),
          builder: (context, snapshot) {
            print("------>>${snapshot.hasData}");

            if (snapshot.hasData) {
              final data = snapshot.data!.docs;

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  final user = data[i].data();
                  return Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: Card(
                      color: Color(0xffcaf3e9),
                      elevation: 3,
                      shadowColor: Color(0xee769796),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      margin: const EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          user["nameofplace"]
                                              .toString()
                                              .split("")
                                              .first
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 15),
                                      child: Text(user["nameofplace"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Category: ${user["category"]}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "Price: ${user["price"]}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "Description: ${user["description"]}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "State: ${user["state"]}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  "Location: ${user["location"]}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: 10, right: 5, left: 5, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => EditPlace(),
                                            ),
                                          );
                                        },
                                        child: Flexible(
                                          flex: 1,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width -
                                                250,
                                            height: 45,
                                            margin: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.white54,
                                              border: Border.all(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.2),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.edit),
                                                Text("  Edit"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await firestore
                                              .doc(user["did"])
                                              .delete();
                                        },
                                        child: Flexible(
                                          flex: 1,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width -
                                                250,
                                            height: 45,
                                            margin: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.white54,
                                              border: Border.all(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.2),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.delete),
                                                Text("  Delete"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
