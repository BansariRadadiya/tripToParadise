import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../config/place.dart';

class EditPlace extends StatefulWidget {
  const EditPlace({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<EditPlace> createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {
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
  bool isSwitched =true;
  List<dynamic> Images = [];

  List<Map<String, dynamic>> dataList = [];

  Future getData() async {
    await FirebaseFirestore.instance
        .collection('place')
        .doc(widget.id)
        .get()
        .then((ds) {
      Map<String, dynamic>? data;
      data = ds.data();
      print(data);
      setState(() {
        _name.text = data!['name'];
        _category.text = data['category'];
        _price.text = data['price'].toString();
        _description.text = data['description'];
        _state.text = data['state'];
        _latitude.text = data['latitude'].toString();
        _longitude.text = data['longitude'].toString();
        _rate.text = data['rating'].toString();
        _vehical.text = data['vehical'];
        _hotelDetails.text = data['hotelname'];
        _noOfDays.text = data['numberofdays'].toString();
        isSwitched = data['isrecommended'];
        Images = data['images'];
        print(Images);
      });
    });
  }

  // addFirestore() async {
  //   final doc = firestore.doc();
  //   final Map<String, dynamic> data = {
  //     "id":doc.id,
  //     "name": _name.text,
  //     "category": _category.text,
  //     "price": int.parse(_price.text),
  //     "description": _description.text,
  //     "image": Images,
  //     "state": _state.text,
  //   };
  //   await doc.set(data);
  // }
  //
  // void addData({int? id}) {
  //   if (id != null) {
  //     _name.text = dataList[id]['name'];
  //     _category.text = dataList[id]['category'];
  //     _price.text = dataList[id]['price'];
  //     _description.text = dataList[id]['description'];
  //     _image.text = dataList[id]['image'];
  //     _state.text = dataList[id]['state'];
  //   } else {
  //     clearText();
  //   }
  // }
  //
  // void clearText() {
  //   _name.clear();
  //   _category.clear();
  //   _price.clear();
  //   _description.clear();
  //   _image.clear();
  //   _state.clear();
  // }

  @override
  void initState() {
    print(widget.id);
    getData();
    // final firestore= FirebaseFirestore.instance.collection("place");
    // final getdata =  firestore.get();
    // print(getdata.toString());
    super.initState();
  }

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
                          "Update Place Details",
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
                          contentPadding: EdgeInsets.all(14),
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
                          contentPadding: EdgeInsets.all(14),
                          hintText: "Enter Category"),
                    ),
                  ),

                  // Price
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: TextFormField(
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
                          contentPadding: EdgeInsets.all(14),
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
                      decoration: InputDecoration(
                        fillColor: Color(0xdfdbf1ea),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(14),
                        hintText: "Enter Description",
                      ),
                      maxLines: 8,
                      minLines: 1,
                    ),
                  ),

                  // Image Url
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
                          contentPadding: EdgeInsets.all(14),
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
                   //   keyboardType: TextInputType.number,
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
                          activeColor:const  Color(0xcea7e5d1),
                          onChanged: (bool value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  // Save button
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
                            id: widget.id,
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
                          // await FirebaseFirestore.instance
                          //     .collection('place')
                          //     .doc(widget.id)
                          //     .update(place.toJson());
                           if(isSwitched==true){
                             await FirebaseFirestore.instance.collection("place").doc(widget.id).update(place.toJson()).then((_)async {
                               await FirebaseFirestore.instance.collection("recommended").doc(widget.id).delete().then((_) async{
                                 await FirebaseFirestore.instance.collection("recommended").doc(widget.id).set(place.toJson());
                               } );
                             } );
                           }else if(isSwitched==false) {
                             await FirebaseFirestore.instance.collection("place").doc(widget.id).update(place.toJson()).then((_)async {
                             await FirebaseFirestore.instance.collection("recommended").doc(widget.id).delete();});
                           }
                          // if (isSwitched == false) {
                          //   FirebaseFirestore.instance
                          //       .collection("recommended")
                          //       .doc(widget.id)
                          //       .delete();
                          // } else {
                          //   try {
                          //     await FirebaseFirestore.instance
                          //         .collection('place')
                          //         .doc(widget.id)
                          //         .update(place.toJson())
                          //         .then((_) async {
                          //       await FirebaseFirestore.instance
                          //           .collection('recommended')
                          //           .doc(widget.id)
                          //           .update(place.toJson());
                          //     });
                          //   } catch (e) {
                          //     print(e);
                          //   }
                          // }
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
                          'Edit Place',
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
