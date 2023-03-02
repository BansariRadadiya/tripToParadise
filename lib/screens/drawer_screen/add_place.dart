import 'package:flutter/material.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({Key? key}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  TextEditingController _name = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _image = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _location = TextEditingController();
  bool isSwitched = true;

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
                        "Insert Place Details",
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                ),

                // Name of Place
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: "Enter Price"),
                  ),
                ),

                // Description
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
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


              ],
            ),
          ),
        ),
      ),
    );
  }
}
