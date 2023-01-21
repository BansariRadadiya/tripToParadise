import 'package:flutter/material.dart';

class Bangladesh extends StatefulWidget {
  const Bangladesh({Key? key}) : super(key: key);

  @override
  State<Bangladesh> createState() => _BangladeshState();
}

class _BangladeshState extends State<Bangladesh> {

  List favourite = [
    {
      'image': "assets/maldives.jpg",
      'name': "Tanguar Haor",
    },
    {
      'image': "assets/dubai.jpg",
      'name': "Nijhum Dwip",
    },
    {
      'image': "assets/kashmir.jpg",
      'name': "Sitakund",
    },
    {
      'image': "assets/israel.jpg",
      'name': "Amiakhum",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Bangladesh")),
        ),
        body: Column(
          children: [
            const SizedBox(height: 25,),
            Container(
              height: 690,
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: favourite.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, i) {
                  return Stack(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        margin: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: AssetImage(favourite[i]['image']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.3)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              tileMode: TileMode.mirror),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 140,
                              top: 5,
                            ),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 90,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              const Icon(
                                Icons.location_on_sharp,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                favourite[i]['name'],
                                maxLines: 1,
                                // overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              SizedBox(
                                width: 45,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
