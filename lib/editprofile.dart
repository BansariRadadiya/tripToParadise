import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController no = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back, size: 30),
                ),
              ),
              const SizedBox(
                width: 100,
              ),
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 90,
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 15,
                    ),
                  ),
                )
              ])
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(196, 196, 196, 0.5647058823529412),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                // contentPadding: EdgeInsets.symmetric(horizontal: 12),
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: email,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(196, 196, 196, 0.5647058823529412),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                prefixIcon: Icon(Icons.mail),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: no,
              decoration: const InputDecoration(
                fillColor: Color.fromRGBO(196, 196, 196, 0.5647058823529412),
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                prefixIcon: Icon(Icons.call),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(196, 196, 196, 0.5647058823529412),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                height: 60,
                width: 150,
                margin: const EdgeInsets.all(10),
                child: const TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        Color.fromRGBO(196, 196, 196, 0.5647058823529412),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
                width: 180,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        Color.fromRGBO(196, 196, 196, 0.5647058823529412),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.calendar_month),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 360,
              // margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: const Center(
                child: Text(
                  "Save Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
