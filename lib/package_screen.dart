import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/widget/favourite.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Package extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  const Package({Key? key, required this.data}) : super(key: key);

  @override
  State<Package> createState() => _PackageState();
}

class _PackageState extends State<Package> {
  int selected = 0;
  bool showDetail = false;
  bool showFaq = false;
  List<String> detailOption = ["Overview", "Itinerary", "Review & Ratings"];

  @override
  Widget build(BuildContext context) {
    print(widget.data.data());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Image.network(
              widget.data['images'][0],
              fit: BoxFit.cover,
              height: 400.0,
              width: double.infinity,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                    top: 50,
                  ),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      )),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    top: 50,
                  ),
                  child: InkWell(
                    onTap: () async {
                      await Favourite.updateFavourite(widget.data.id);
                      setState(() {});
                    },
                    child: Container(
                      child: UserProfile.favouriteList.contains(widget.data.id)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite_border, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 370),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: 30,
                  right: 20,
                  left: 20,
                ),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    widget.data['show_location'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                widget.data['name'],
                                style: const TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 50,
                              top: 10,
                            ),
                            child: Text(
                              "\$${widget.data['price']}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 50,
                              top: 5,
                            ),
                            child: Text(
                              "Estimated",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Trip Plan",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.data['description'],
                        style: const TextStyle(
                            color:
                                Color.fromRGBO(24, 23, 23, 0.6980392156862745),
                            fontSize: 17),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Photo Gallery",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),

                      ///Picture GridView
                      SizedBox(
                        height: 280,
                        child: GridView.builder(
                          itemCount: widget.data['images'].length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        contentPadding: EdgeInsets.zero,
                                        backgroundColor:
                                        Color.fromRGBO(0, 138, 189, 1),
                                        title: Center(
                                          child: Text('${widget.data['name']}'),
                                        ),
                                        shape: ContinuousRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                Radius.circular(20)),
                                            child: Image.network(
                                              widget.data['images'][i],
                                              fit: BoxFit.fill,
                                              // color: Colors.transparent,
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  widget.data['images'][i],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Location",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20,),
                      InkWell(
                          onTap: () {},
                          child: ClipRRect(
                            child: Image.asset("assets/google-map.png",
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Share Social Media",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          String message =
                              "Name : ${widget.data['name']}\n\nImage : \n${(widget.data['images'] as List).join("\n\n")}\n\n\nDescription : \n${widget.data['description']}";
                          await Share.share(
                            message,
                            subject: widget.data['name'],
                          );
                        },
                        child: const ListTile(
                          leading: Icon(Icons.share),
                          title: Text("Share"),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () async {
                          //shorten url
                          await launchUrl(Uri.parse("tel:9909988088"));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Text(
                              "Book Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
