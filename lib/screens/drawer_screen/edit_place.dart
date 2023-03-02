import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPlace extends StatefulWidget {
  const EditPlace({Key? key}) : super(key: key);

  @override
  State<EditPlace> createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {
  TextEditingController _nameofplace = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _image = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _location = TextEditingController();
  bool isSwitched = true;

  List<Map<String, dynamic>> dataList = [];
  final firestore = FirebaseFirestore.instance.collection("User");
  addFirestore() async {
    final doc = firestore.doc();
    final Map<String, dynamic> data = {
      "did":doc.id,
      "nameofplace": _nameofplace.text,
      "category": _category.text,
      "price": int.parse(_price.text),
      "description": _description.text,
      "image": _image.text,
      "state": _state.text,
      "location": _location.text,
    };
    await doc.set(data);
  }

  void addData({int? id}) {
    if (id != null) {
      _nameofplace.text = dataList[id]['nameofplace'];
      _category.text = dataList[id]['category'];
      _price.text = dataList[id]['price'];
      _description.text = dataList[id]['description'];
      _image.text = dataList[id]['image'];
      _state.text = dataList[id]['state'];
      _location.text = dataList[id]['location'];
    } else {
      clearText();
    }
  }

  void clearText() {
    _nameofplace.clear();
    _category.clear();
    _price.clear();
    _description.clear();
    _image.clear();
    _state.clear();
    _location.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 5,left: 5),
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
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
                  child: TextFormField(
                    controller: _nameofplace,
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
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
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
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
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
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
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
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
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
                        contentPadding: EdgeInsets.all(14),
                        hintText: "Enter Image Url"),
                  ),
                ),

                //State
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
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
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                  child: TextFormField(
                    controller: _location,
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
                        hintText: "Enter Location"),
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

                // Save button
                InkWell(
                  onTap: () {
                    // addData();
                    addFirestore();
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
