import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MakeOwnPlan extends StatefulWidget {
  const MakeOwnPlan({Key? key}) : super(key: key);

  @override
  State<MakeOwnPlan> createState() => _MakeOwnPlanState();
}

class _MakeOwnPlanState extends State<MakeOwnPlan> {
  TextEditingController _nameofplace = TextEditingController();
  TextEditingController _firstdate = TextEditingController();
  TextEditingController _lastdate = TextEditingController();
  TextEditingController _numberofdays = TextEditingController();
  TextEditingController _numberofperson = TextEditingController();
  TextEditingController _below18 = TextEditingController();
  TextEditingController _above18 = TextEditingController();
  TextEditingController _hotel = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _numberofrooms = TextEditingController();
  TextEditingController _location = TextEditingController();

  String dropDownValueBudget = "1000 - 5000";
  String dropDownValueVehicle = "Airplane";
  String dropDownValueAge = "1";
  var ageList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18"
  ];
  var budgetList = [
    "1000 - 5000",
    "5000 - 10000",
    "10000 - 15000",
    "15000 - 25000",
    "25000 or above"
  ];
  var vehicleTypeList = ["Airplane", "Bus", "Train", "Taxi"];

  bool? day;
  List<String> tabButton = ["Family Tour", "Students Picnic", "One Day Plan"];
  int selectButton = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // Update plan detail container
            Padding(
              padding: const EdgeInsets.only(
                left: 3,
                right: 3,
                bottom: 5,
              ),
              child: Container(
                height: 85,
                padding: EdgeInsets.only(bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(305, 90),
                    bottomLeft: Radius.elliptical(305, 90),
                  ),
                  gradient: LinearGradient(colors: [
                    Color(0xff8fe1f5),
                    Color(0xffa1efc4),
                  ]),
                ),
                child: Center(
                  child: Text(
                    "Add Plan Details",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ),

            // gradient color container
            Container(
              height: 850,
              width: 400,
              margin: EdgeInsets.only(top: 5, right: 5, left: 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffa2e2f1),
                  Color(0xffaef1e4),
                  Color(0xffc1f3d7),
                  Color(0xffc1ecd4),
                  Color(0xffe9faf1),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  // ListView buttons
                  Container(
                    height: 40,
                    margin: EdgeInsets.all(10),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectButton = i;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(400),
                                gradient: selectButton == i
                                    ? LinearGradient(
                                    colors: [
                                      Color(0xff44c2c1),
                                      Color(0xff55cecc),
                                      Color(0xff71d7d5)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)
                                    : null,
                              ),
                              child: Center(
                                child: i == 5
                                    ? const Icon(
                                  Icons.arrow_forward,
                                  size: 25,
                                )
                                    : Padding(
                                  padding: const EdgeInsets.only(
                                      right: 13,
                                      left: 13,
                                      top: 5,
                                      bottom: 5),
                                  child: Text(
                                    tabButton[i],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: selectButton == i
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),

                  if (selectButton == 0)
                  // Form
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: Column(
                        children: [
                          // Name of Place
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: TextFormField(
                              controller: _nameofplace,
                              cursorColor: Color(0xee5dd2cd),
                              decoration: const InputDecoration(
                                  fillColor: Color(0xc1dfefeb),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(14),
                                  hintText: "Enter Name of Place",
                                  hintStyle: TextStyle()),
                            ),
                          ),

                          // Days of Visit
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                        left: 15,
                                      ),
                                      child: Text("Days:"),
                                    ),
                                    // Number Of Days
                                    SizedBox(
                                      width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10, top: 10),
                                        child: TextFormField(
                                          controller: _numberofdays,
                                          readOnly: true,
                                          cursorColor: Color(0xee5dd2cd),
                                          decoration: const InputDecoration(
                                              fillColor:
                                              Color.fromRGBO(0, 0, 0, 490),
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              hintText: "Days"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                        left: 15,
                                      ),
                                      child: Text("First Date"),
                                    ),
                                    // First Date
                                    SizedBox(
                                      width: 120,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10, top: 10),
                                        child: TextFormField(
                                          readOnly: true,
                                          onTap: () async {
                                            DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1960),
                                                lastDate: DateTime(2101));
                                            if (pickedDate != null) {
                                              //print(pickedDate);
                                              // String formattedDate =
                                              // DateFormat('dd/MM/yyyy').format(pickedDate);

                                              setState(() {
                                                if (pickedDate.day >=
                                                    DateTime.now().day + 10) {
                                                  day = true;
                                                } else {
                                                  day = false;
                                                }
                                                // _dateofvisit.text = formattedDate;
                                              });
                                            } else {
                                              //print("Date is not selected");
                                            }
                                          },
                                          controller: _firstdate,
                                          //  validator: (value) => Validators().validatedate(value),
                                          decoration: const InputDecoration(
                                            fillColor: Color(0xc1dfefeb),
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            hintText: "First Date",
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please Select Date';
                                            } else if (day == false) {
                                              return 'Date must be 15 days later than current day';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                        left: 15,
                                      ),
                                      child: Text("Last Date"),
                                    ),
                                    // Last Date
                                    SizedBox(
                                      width: 120,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10, top: 10),
                                        child: TextFormField(
                                          readOnly: true,
                                          onTap: () async {
                                            DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1960),
                                                lastDate: DateTime(2101));
                                            if (pickedDate != null) {
                                              //print(pickedDate);
                                              // String formattedDate =
                                              // DateFormat('dd/MM/yyyy').format(pickedDate);

                                              setState(() {
                                                // if (pickedDate.day >= _firstdate.text) {
                                                //   day = true;
                                                // } else {
                                                //   day = false;
                                                // }
                                                // _dateofvisit.text = formattedDate;
                                              });
                                            } else {
                                              //print("Date is not selected");
                                            }
                                          },
                                          controller: _lastdate,
                                          //  validator: (value) => Validators().validatedate(value),
                                          decoration: const InputDecoration(
                                            fillColor: Color(0xc1dfefeb),
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            hintText: "Last Date",
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please Select Date';
                                            } else if (day == false) {
                                              return 'Date must be 15 days later than current day';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          // Number of person
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 10,
                                        left: 15,
                                      ),
                                      child: Text("Person"),
                                    ),
                                    // Number Of Person
                                    SizedBox(
                                      width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10, top: 10),
                                        child: TextFormField(
                                          controller: _numberofperson,
                                          readOnly: true,
                                          cursorColor: Color(0xee5dd2cd),
                                          decoration: const InputDecoration(
                                              fillColor:
                                              Color.fromRGBO(0, 0, 0, 490),
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              hintText: "Person"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 10,
                                        left: 15,
                                      ),
                                      child: Text("01-18:"),
                                    ),
                                    // 18 below
                                    DropdownButton(
                                        value: dropDownValueAge,
                                        menuMaxHeight: 250,
                                        items: ageList.map((String items) {
                                          return DropdownMenuItem(
                                            child: Text(items),
                                            value: items,
                                          );
                                        }).toList(),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                        dropdownColor: Color(0xc1dfefeb),
                                        elevation: 0,
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_rounded),
                                        onChanged: (String? newvalue) {
                                          setState(() {
                                            dropDownValueAge = newvalue!;
                                          });
                                        }),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 10,
                                        left: 15,
                                      ),
                                      child: Text("Person"),
                                    ),
                                    // Number Of Person
                                    SizedBox(
                                      width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10, top: 10),
                                        child: TextFormField(
                                          controller: _above18,
                                          cursorColor: Color(0xee5dd2cd),
                                          decoration: const InputDecoration(
                                              fillColor: Color(0xc1dfefeb),
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              hintText: "Age"),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          // Budget
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text(
                                  "Budget: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              DropdownButton(
                                  value: dropDownValueBudget,
                                  items: budgetList.map((String items) {
                                    return DropdownMenuItem(
                                      child: Text(items),
                                      value: items,
                                    );
                                  }).toList(),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  dropdownColor: Color(0xc1dfefeb),
                                  elevation: 0,
                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                  onChanged: (String? newvalue) {
                                    setState(() {
                                      dropDownValueBudget = newvalue!;
                                    });
                                  }),
                            ],
                          ),
                          // Vehicle
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text(
                                  "Vehicle: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              DropdownButton(
                                  value: dropDownValueVehicle,
                                  items: vehicleTypeList.map((String items2) {
                                    return DropdownMenuItem(
                                      child: Text(items2),
                                      value: items2,
                                    );
                                  }).toList(),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  dropdownColor: Color(0xc1dfefeb),
                                  elevation: 0,
                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                  onChanged: (String? newvalue2) {
                                    setState(() {
                                      dropDownValueVehicle = newvalue2!;
                                    });
                                  }),
                            ],
                          ),

                          // Hotel
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: TextFormField(
                              controller: _hotel,
                              cursorColor: Color(0xee5dd2cd),
                              decoration: const InputDecoration(
                                  fillColor: Color(0xc1dfefeb),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(14),
                                  hintText: "Enter Hotel Name"),
                            ),
                          ),

                          // Number of Rooms
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: TextFormField(
                              controller: _numberofrooms,
                              cursorColor: Color(0xee5dd2cd),
                              decoration: const InputDecoration(
                                  fillColor: Color(0xc1dfefeb),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(14),
                                  hintText: "Enter Number Of Rooms"),
                            ),
                          ),

                          // Location
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: TextFormField(
                              controller: _location,
                              cursorColor: Color(0xee5dd2cd),
                              decoration: const InputDecoration(
                                  fillColor: Color(0xc1dfefeb),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(14),
                                  hintText: "Enter Location Of Place"),
                            ),
                          ),

                          // Contact no
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: TextFormField(
                              controller: _contact,
                              cursorColor: Color(0xee5dd2cd),
                              decoration: const InputDecoration(
                                  fillColor: Color(0xc1dfefeb),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(14),
                                  hintText: "Enter Contact Number"),
                            ),
                          ),

                          // City
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            child: TextFormField(
                              controller: _city,
                              cursorColor: Color(0xee5dd2cd),
                              decoration: const InputDecoration(
                                  fillColor: Color(0xc1dfefeb),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(14),
                                  hintText: "Enter Your City"),
                            ),
                          ),

                          // Create button
                          InkWell(
                            onTap: () {
                              // addData();
                              // addFirestore();
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                height: 60,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xff3ebf82),
                                        Color(0xff56c793),
                                        Color(0xff76d5ac)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "Create",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
