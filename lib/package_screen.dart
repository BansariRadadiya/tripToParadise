import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/widget/favourite.dart';
import 'package:home_page/widget/mapdemo.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dashboard_screen.dart';

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
  String Hotelname = "";
  String Hotel = "";
  String Des = "";
  String Descr = "";
  double varrat=0.0;
  List<String> detailOption = ["Overview", "Itinerary", "Review & Ratings"];

  @override
  void initState() {
    Hotelname = widget.data['hotelname'].toString();
    Des = widget.data['description'].toString();
    Hotel = Hotelname.toString().replaceAll(RegExp('<br>'), '\n');
    Descr = Des.toString().replaceAll(RegExp('<br>'), '\n');
    print("After:$Hotel");
    print("after:$Descr");
    String bansari = 'bansari';
    print('bansari'.replaceAll(RegExp('a'), '@'));
    print(bansari.toString().replaceAll(RegExp('a'), '@'));
    super.initState();
  }

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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => KeepAlive(
                                keepAlive: true, child: DashboardScreen())));
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
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
                          : const Icon(Icons.favorite_border,
                              color: Colors.white),
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
                                  color: Colors.red,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    widget.data['state'],
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
                              "\u{20B9}${widget.data['price']}",
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
                        Descr.toString(),
                        style: const TextStyle(
                            color:
                                Color.fromRGBO(24, 23, 23, 0.6980392156862745),
                            fontSize: 17),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.fastfood,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Hotels',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Text(Hotel.toString()),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "${widget.data['numberofdays']} in this Package",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.photo_camera,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          const Text(
                            "Photo Gallery",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                        ],
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
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          const Text(
                            "Location",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                          onTap: () {
                            // GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(double.parse(widget.data['latitude']),double.parse(widget.data['latitude']))),);
                            //  GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(15.515447,73.768402)),);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MapDemo(
                                      latitude: widget.data['latitude'],
                                      longitute: widget.data['longitude'],
                                    )));
                            // MapDemo();
                          },
                          child: ClipRRect(
                            child: Image.asset("assets/google-map.png",
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 200,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            IconButton(onPressed: (){
                                              Navigator.of(context).pop();
                                            }, icon: Icon(Icons.cancel,color: Colors.grey,)),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child:RatingBar.builder(
                                                      initialRating: 0.0,
                                                      minRating: 1,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                      itemBuilder: (context,_){
                                                    return Icon(Icons.star,color: Colors.amber,);
                                                  }, onRatingUpdate: (rating){
                                                        setState(() {
                                                          varrat=rating;
                                                          //print(varrat);
                                                        });
                                                      //  print(rating);
                                                  }),
                                                ),
                                              ElevatedButton(onPressed: (){
                                                if(varrat!=0.0){
                                                  print(varrat);
                                                  FirebaseFirestore.instance.collection("place").doc(widget.data['id']).set({"rating":varrat},SetOptions(merge: true));

                                                Navigator.of(context).pop();}
                                              }, child: Text('Submit'))
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                'Rate this Place',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
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
