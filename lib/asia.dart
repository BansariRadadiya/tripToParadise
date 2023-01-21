import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_page/bangladesh.dart';
import 'package:home_page/main.dart';
import 'package:home_page/package_screen.dart';

class Asia extends StatefulWidget {
  final List<List<QueryDocumentSnapshot<Map<String, dynamic>>>> packageList;
  const Asia({Key? key,required this.packageList}) : super(key: key);

  @override
  State<Asia> createState() => _AsiaState();
}

class _AsiaState extends State<Asia> {
  int selected = 0;
  List<String> countryName = [
    "All",
    "Asia",
    "Europe",
    "America",
    "Ocenia",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Packages"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  itemCount: countryName.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selected = i;
                        });
                      },
                      child: Container(
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selected == i ? Colors.lightBlue : null,
                        ),
                        child: Center(
                          child: Text(
                            countryName[i],
                            style: TextStyle(
                              color: selected == i ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: SizedBox(
                height: 645,
                child: GridView.builder(
                    itemCount: widget.packageList[selected].length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, i) {
                      final data = widget.packageList[selected][i];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext) => Package(data: data))).whenComplete(() => setState((){}));
                        },
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: GridTile(
                              footer: Container(
                                height: 60,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ClipRRect(
                                          child: Image(
                                            image: NetworkImage(data['images'][1]),
                                            height: 30,
                                            width: 40,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width:120,
                                              child: Text(
                                                data['name'],
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              child:  Image(
                                image: NetworkImage(data['images'][0]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
