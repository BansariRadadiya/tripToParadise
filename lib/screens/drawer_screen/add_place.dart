//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../config/place.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({Key? key}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _image = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _latitude = TextEditingController();
  TextEditingController _longitude = TextEditingController();
  TextEditingController _rate = TextEditingController();
  TextEditingController _vehical = TextEditingController();
  TextEditingController _hotelDetails = TextEditingController();
  TextEditingController _noOfDays = TextEditingController();
  bool isSwitched = false;
  List<String> Images = [];
  String docid = "";
  String bothid="";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: Column(
                children: [
                  // Update place detail container
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(250, 40),
                          topRight: Radius.elliptical(250, 40),
                          bottomRight: Radius.elliptical(35, 100),
                          bottomLeft: Radius.elliptical(35, 100),
                        ),
                        gradient: LinearGradient(colors: [
                          Color(0xff8fe1f5),
                          Color(0xffa1efc4),
                        ]),
                      ),
                      child: Center(
                        child: Text(
                          "Insert Place Details",
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  ),

                  // Name of Place
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 20),
                    child: TextFormField(
                      controller: _name,
                      cursorColor: Color(0xee5dd2cd),
                      decoration: const InputDecoration(
                          fillColor: Color(0xdfdbf1ea),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Enter Name of Place"),
                    ),
                  ),

                  // Category
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _category,
                      cursorColor: Color(0xee5dd2cd),
                      decoration: const InputDecoration(
                          fillColor: Color(0xdfdbf1ea),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Enter Category"),
                    ),
                  ),

                  // Price
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _price,
                      cursorColor: Color(0xee5dd2cd),
                      decoration: const InputDecoration(
                          fillColor: Color(0xdfdbf1ea),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Enter Price"),
                    ),
                  ),

                  // Description
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _description,
                      cursorColor: Color(0xee5dd2cd),
                      decoration: const InputDecoration(
                          fillColor: Color(0xdfdbf1ea),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Enter Description"),
                    ),
                  ),

                  // Image Url
                  //Padding(
                  // padding: const EdgeInsets.only(right: 10,top: 10,left: 10),
                  //child:
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: SizedBox(
                          width: 260,
                          child: TextFormField(
                            controller: _image,
                            cursorColor: Color(0xee5dd2cd),
                            decoration: const InputDecoration(
                                fillColor: Color(0xdfdbf1ea),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                hintText: "Enter Image Url"),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            if (_image.text.isNotEmpty) {
                              Images.add(_image.text.toString().trim().trim());
                            }
                            setState(() {
                              _image.clear();
                            });
                          },
                          child: const Text('Add Url',style: TextStyle(color: Color(0xee769796)),)),
                    ],
                  ),
                  //),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      top: 10,
                      left: 10,
                    ),
                    child: Container(

                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xdfdbf1ea),
                          border: Border.all(width: 1, color: Colors.black12),
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext cotext, int index) {
                            return imgs(index);
                            // return Text("${Images[index]}",style: TextStyle(overflow: TextOverflow.ellipsis),);
                          },
                          itemCount: Images.length,
                        ),
                      ),
                    ),
                  ),
                  //State
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _state,
                      cursorColor: Color(0xee5dd2cd),
                      decoration: const InputDecoration(
                          fillColor: Color(0xdfdbf1ea),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Enter State"),
                    ),
                  ),

                  //Location
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _latitude,
                      cursorColor: Color(0xee5dd2cd),
                      decoration: const InputDecoration(
                          fillColor: Color(0xdfdbf1ea),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Enter Latitude"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _longitude,
                      cursorColor: Color(0xee5dd2cd),
                      decoration: const InputDecoration(
                          fillColor: Color(0xdfdbf1ea),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Enter Longitude"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _rate,
                      cursorColor: Color(0xee5dd2cd),
                      decoration: const InputDecoration(
                          fillColor: Color(0xdfdbf1ea),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Enter Rate"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _vehical,
                      cursorColor: Color(0xee5dd2cd),
                      decoration: const InputDecoration(
                          fillColor: Color(0xdfdbf1ea),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Enter Vehical"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      controller: _hotelDetails,
                      cursorColor: Color(0xee5dd2cd),
                      decoration: const InputDecoration(
                          fillColor: Color(0xdfdbf1ea),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Enter Hotel Details"),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _noOfDays,
                      cursorColor: Color(0xee5dd2cd),
                      decoration: const InputDecoration(
                          fillColor: Color(0xdfdbf1ea),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Enter Number of Days"),
                    ),
                  ),
                  // Recommended
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Row(
                      children: [
                        Text(
                          "isRecommended?",
                          style: TextStyle(fontSize: 17),
                        ),
                        Switch(
                          value: isSwitched,
                          activeColor: Color(0xcea7e5d1),
                          onChanged: (bool value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                      top: 5,
                      bottom: 16,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[200],
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          )),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Place place = Place(
                            id: "",
                            name: _name.text.toString().trim(),
                            category: _category.text.toString().trim(),
                            price: int.parse(_price.text),
                            description: _description.text.toString().trim(),
                            placeList: Images,
                            state: _state.text.toString().trim(),
                            latitude: double.parse(_latitude.text),
                            longitude: double.parse(_longitude.text),
                            rate: double.parse(_rate.text),
                            vehical: _vehical.text.toString().trim(),
                            hotelDetails: _hotelDetails.text.toString().trim(),
                            nuofDays: _noOfDays.text.toString().trim(),
                            isRecommended: isSwitched,
                          );
                          print("Data================${place.toJson()}");
                          // await FirebaseFirestore.instance.collection('place')
                          //     .add(place.toJson()).then((DocumentReference doc){
                          //       FirebaseFirestore.instance.collection("place").doc(doc.id).set({"id":doc.id},SetOptions(merge: true));
                          // });
                          if (isSwitched) {
                            await FirebaseFirestore.instance
                                .collection('place')
                                .add(place.toJson())
                                .then((DocumentReference doc) {
                                  setState(() {
                                    bothid=doc.id;
                                  });
                              FirebaseFirestore.instance
                                  .collection("place")
                                  .doc(doc.id)
                                  .set({"id": doc.id}, SetOptions(merge: true));
                            }).then((_) async {
                              await FirebaseFirestore.instance
                                  .collection('recommended').doc(bothid)
                                  .set(place.toJson())
                                  .then((_) {
                                FirebaseFirestore.instance
                                    .collection("recommended")
                                    .doc(bothid)
                                    .set({"id": bothid},
                                        SetOptions(merge: true));
                              });
                            });
                          } else {
                            await FirebaseFirestore.instance.collection('place')
                                .add(place.toJson()).then((DocumentReference doc){
                                  FirebaseFirestore.instance.collection("place").doc(doc.id).set({"id":doc.id},SetOptions(merge: true));
                            });
                          }
                          setState(() {
                            _category.clear();
                            _name.clear();
                            _price.clear();
                            _description.clear();
                            Images.clear();
                            _state.clear();
                            _longitude.clear();
                            _latitude.clear();
                            _rate.clear();
                            _vehical.clear();
                            _hotelDetails.clear();
                            _noOfDays.clear();
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 210,
                        alignment: Alignment.center,
                        child: Text(
                          'Add Place',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imgs(int i) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 5, top: 5, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Color(0xee769796)),
        width: 100,
        height: 30,
        child: Row(
          children: [
            Container(
                width: 50,
                padding: const EdgeInsets.only(left: 10),
                child: Center(
                    child: Text(
                  '${Images[i]}',
                  style: TextStyle(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ))),
            IconButton(
                onPressed: () {
                  setState(() {
                    Images.removeAt(i);
                    print(Images.length);
                  });
                },
                icon: Icon(Icons.cancel)),
          ],
        ),
      ),
    );
  }
}
