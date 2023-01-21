import 'package:flutter/material.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  int sbutton = 0;
  List<String> tButton = ["On Going", "Closed"];
  List closed = [
    {
      'title': 'March 2021',
      'data': [
        {
          'place': 'Taj mahal Package',
          'duration': '2 days 3 nights',
          'image': 'assets/tajmahal.jpg',
          'icon': Icons.star,
          'icon': Icons.star,
          'icon': Icons.star,
          'icon': Icons.star,
          'icon': Icons.star,
          'no': '70'
        },
      ]
    },
    {
      'title': 'December 2020',
      'data': [
        {
          'place': 'Bali Honeymoon Package',
          'duration': '2 days 3 nights',
          'image': 'assets/kashmir.jpg',
          'icon': const Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          'icon': Icons.star,
          'icon': Icons.star,
          'icon': Icons.star,
          'icon': Icons.star,
          'no': '32'
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const SizedBox(width: 10,),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back_sharp,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 120,
              ),
              const Text(
                "My Booking",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
            width: 380,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        sbutton = i;
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(400),
                        color: sbutton == i ? Colors.blue : null,
                      ),
                      child: Center(
                        child: Text(
                          tButton[i],
                          style: TextStyle(
                            color: sbutton == i ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          if (sbutton == 0)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/Ganesh.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Bandarbans Package",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue.withOpacity(0.3),
                                ),
                                child: const Center(
                                  child: Text(
                                    "On Going",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(height: 10,),
                          const Text(
                            "2 days 3 night",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                              ),
                              const Text("November 4,2020"),
                              const SizedBox(
                                width: 45,
                              ),
                              SizedBox(
                                height: 30,
                                width: 90,
                                child: Row(
                                  children: const [
                                    SizedBox(
                                      width: 17,
                                    ),
                                    Text(
                                      "Details",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    // SizedBox(width: 10,),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (sbutton == 1)
            SizedBox(
              height: 350,
              child: ListView.builder(
                  itemCount: closed.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              closed[i]['title'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        ListView.builder(
                            itemCount: closed[i]['data'].length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.all(10),
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  height: 95,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color: Colors.red,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ///Image
                                      Container(
                                        height: 80,
                                        width: 79,
                                        margin: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            closed[i]['data'][index]['image'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 190,
                                        // color: Colors.yellow,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                closed[i]['data'][index]
                                                    ['place'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                closed[i]['data'][index]
                                                    ['duration'],
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  i == 0
                                                      ? Icon(
                                                          closed[i]['data']
                                                              [index]['icon'],
                                                          size: 20,
                                                          color:
                                                              Colors.grey[400],
                                                        )
                                                      : Icon(
                                                          closed[i]['data']
                                                              [index]['icon'],
                                                          size: 20,
                                                          color: Colors.yellow,
                                                        ),
                                                  i == 0
                                                      ? Icon(
                                                          closed[i]['data']
                                                              [index]['icon'],
                                                          size: 20,
                                                          color:
                                                              Colors.grey[400],
                                                        )
                                                      : Icon(
                                                          closed[i]['data']
                                                              [index]['icon'],
                                                          size: 20,
                                                          color: Colors.yellow,
                                                        ),
                                                  i == 0
                                                      ? Icon(
                                                          closed[i]['data']
                                                              [index]['icon'],
                                                          size: 20,
                                                          color:
                                                              Colors.grey[400],
                                                        )
                                                      : Icon(
                                                          closed[i]['data']
                                                              [index]['icon'],
                                                          size: 20,
                                                          color: Colors.yellow,
                                                        ),
                                                  i == 0
                                                      ? Icon(
                                                          closed[i]['data']
                                                              [index]['icon'],
                                                          size: 20,
                                                          color:
                                                              Colors.grey[400],
                                                        )
                                                      : Icon(
                                                          closed[i]['data']
                                                              [index]['icon'],
                                                          size: 20,
                                                          color: Colors.yellow,
                                                        ),
                                                  i == 0
                                                      ? Icon(
                                                          closed[i]['data']
                                                              [index]['icon'],
                                                          size: 20,
                                                          color:
                                                              Colors.grey[400],
                                                        )
                                                      : Icon(
                                                          closed[i]['data']
                                                              [index]['icon'],
                                                          size: 20,
                                                          color: Colors.yellow,
                                                        ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        height: 95,
                                        width: 60,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 27,
                                              width: 56,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.blue
                                                    .withOpacity(0.3),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Closed",
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              closed[i]['data'][index]['no'],
                                              style: const TextStyle(
                                                fontSize: 22,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                "Attended",
                                                style: TextStyle(
                                                  color: Colors.blue
                                                      .withOpacity(0.6),
                                                  fontSize: 13,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    );
                  }),
            )
        ],
      ),
    );
  }
}
