import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/homepage.dart';
import 'package:home_page/main.dart';
import 'package:home_page/package_screen.dart';
import 'package:home_page/setting.dart';
import 'package:home_page/widget/favourite.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> favourite = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> allList = [];

  void getData() async {
    allList.clear();
    final QuerySnapshot<Map<String, dynamic>> snap =  await FirebaseFirestore.instance.collection("place").get();
   // final QuerySnapshot<Map<String, dynamic>> snap1 =  await FirebaseFirestore.instance.collection("recommended").get();
      allList.addAll(snap.docs);
     // allList.addAll(snap1.docs);
      findFavourite();

  }

  void findFavourite(){
    setState(() {
      favourite = allList
          .where((element) => UserProfile.favouriteList.contains(element.id))
          .toList();
    });
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text("Favourites")),
        ),
        const SizedBox(
          height: 25,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            child: GridView.builder(
              itemCount: favourite.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, i) {
                final data = favourite[i];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Package(
                          data: data,
                        ),
                      ),
                    ).whenComplete(() => setState((){}));
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: NetworkImage(data['images'][0]),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              tileMode: TileMode.mirror),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 10,
                        child: GestureDetector(
                          onTap: () async {
                            await Favourite.updateFavourite(data.id);
                            findFavourite();
                          },
                          child: Container(
                            child: UserProfile.favouriteList.contains(data.id)
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.favorite_border,
                                    color: Colors.white),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5,
                        bottom: 15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                const Icon(
                                  Icons.location_on_sharp,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 100,
                                  height: 20,
                                  child: Text(
                                    data['name'],
                                    maxLines: 1,
                                    // overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
