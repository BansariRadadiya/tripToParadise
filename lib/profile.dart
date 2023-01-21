import 'package:flutter/material.dart';
import 'package:home_page/editprofile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 130,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Column(
                    children: const [
                      Text(
                        "Hi, Jit Banik!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Joined - Mar 2021",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                      height: 80,
                      width: 80,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                  focusColor: Colors.black,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Phone no.",
                  labelText: "Phone Number",
                  focusColor: Colors.black,
                ),
                keyboardType: TextInputType.phone,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Gender",
                  labelText: "Gender",
                  focusColor: Colors.black,
                ),
                keyboardType: TextInputType.text,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Date of Birth",
                  labelText: "DOB",
                  focusColor: Colors.black,
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: const Image(
                      image: AssetImage("assets/Ganesh.jpg"),
                      height: 30,
                      width: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Connect Facebook"),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              const Spacer(),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfile()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.lightBlue,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
