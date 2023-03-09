import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:home_page/config/user.dart';
import 'package:home_page/main.dart';
import 'package:home_page/package_screen.dart';
import 'package:home_page/widget/favourite.dart';

import '../config/place_list.dart';

class SearchPage extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList;

  const SearchPage({Key? key, required this.dataList}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> searchList = [];

  @override
  void initState() {
    searchList = widget.dataList;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.clear();
    super.dispose();
  }

  void search(String value) {
    if (value.isNotEmpty) {
      setState(() {
        searchList = widget.dataList
            .where((element) => element['name'].toString().contains(value))
            .toList();
      });
    } else {
      setState(() {
        searchList = widget.dataList;
      });
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //       title: Text('Search',style:TextStyle(color: Colors.black),),
  //       centerTitle: true,
  //       leading:IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){
  //         Navigator.of(context).pop();
  //       },),),
  //     body: Column(
  //       children: [
  //         const SizedBox(
  //           height: 25,
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(left: 10, right: 10),
  //           child: TextField(
  //             onChanged: (value) {
  //               search(value);
  //             },
  //             decoration: const InputDecoration(
  //                 filled: true,
  //                 fillColor: Color.fromRGBO(196, 196, 196, 0.5647058823529412),
  //                 border: OutlineInputBorder(

  //                   borderRadius: BorderRadius.all(Radius.circular(20)),
//                     borderSide: BorderSide(width: 1,color: Colors.blue),
//                   ),
//                   prefixIcon: Icon(Icons.search),
//                   hintText: "Where are you going?",
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12)),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               margin: const EdgeInsets.all(12),
//               child: GridView.builder(
//                 itemCount: searchList.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                 ),
//                 itemBuilder: (context, i) {
//                   final data = searchList[i];
//                   return InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => Package(
//                                 data: data,
//                               ))).whenComplete(() => setState((){}));
//                     },
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.all(5),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: Image(
//                               image: NetworkImage(data['images'][0]),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             gradient: LinearGradient(
//                                 colors: [
//                                   Colors.transparent,
//                                   Colors.black.withOpacity(0.3)
//                                 ],
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 tileMode: TileMode.mirror),
//                           ),
//                         ),
//                         Positioned(
//                           top: 15,
//                           right: 10,
//                           child: GestureDetector(
//                             onTap: () async {
//                               await Favourite.updateFavourite(data.id);
//                               setState(() {});
//                             },
//                             child: Container(
//                               child: UserProfile.favouriteList.contains(data.id)
//                                   ? Icon(
//                                       Icons.favorite,
//                                       color: Colors.red,
//                                     )
//                                   : Icon(Icons.favorite_border,
//                                       color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: 5,
//                           bottom: 15,
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(
//                                     width: 15,
//                                   ),
//                                   const Icon(
//                                     Icons.location_on_sharp,
//                                     color: Colors.white,
//                                     size: 15,
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   Container(
//                                     width: 100,
//                                     height: 20,
//                                     child: Text(
//                                       data['name'],
//                                       maxLines: 1,
//                                       // overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               // Row(
//                               //   mainAxisAlignment: MainAxisAlignment.start,
//                               //   children: const [
//                               //     SizedBox(
//                               //       width: 45,
//                               //     ),
//                               //     Icon(
//                               //       Icons.star,
//                               //       color: Colors.yellow,
//                               //       size: 15,
//                               //     ),
//                               //     Icon(
//                               //       Icons.star,
//                               //       color: Colors.yellow,
//                               //       size: 15,
//                               //     ),
//                               //     Icon(
//                               //       Icons.star,
//                               //       color: Colors.yellow,
//                               //       size: 15,
//                               //     ),
//                               //     Icon(
//                               //       Icons.star,
//                               //       color: Colors.yellow,
//                               //       size: 15,
//                               //     ),
//                               //     Icon(
//                               //       Icons.star,
//                               //       color: Colors.yellow,
//                               //       size: 15,
//                               //     ),
//                               //   ],
//                               // ),
//                             ],
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

  String? userSelected;
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Search',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 20, left: 10.0),
            child: SizedBox(
                height: 45,
                width: double.infinity,
                child: TypeAheadField(
                  noItemsFoundBuilder: (context) => const SizedBox(
                    height: 50,
                    child: Center(
                      child: Text('No Item Found'),
                    ),
                  ),
                  suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                      color: Colors.white,
                      elevation: 4.0,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  debounceDuration: const Duration(milliseconds: 400),
                  textFieldConfiguration: TextFieldConfiguration(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            Color.fromRGBO(196, 196, 196, 0.5647058823529412),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.blue),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                          15.0,
                        )),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            borderSide: BorderSide(color: Colors.blue)),
                        hintText: "Where are you going?",
                        contentPadding: const EdgeInsets.only(top: 4, left: 10),
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search, color: Colors.grey)),
                      )),
                  suggestionsCallback: (value) {
                    return StateServices.getSuggestions(value);
                  },
                  itemBuilder: (context, String suggestion) {
                    return Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.refresh,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              suggestion,
                              maxLines: 1,
                              // style: TextStyle(color: Colors.red),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  onSuggestionSelected: (String suggestion) {
                    setState(() {
                      userSelected = suggestion;
                      _searchController.text = userSelected!;
                      print("==============$userSelected");
                      search(userSelected!);
                    });
                  },
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: searchList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, i) {
                  final data = searchList[i];
                  return InkWell(
                    onTap: () {
                      _searchController.clear();
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => Package(
                                    data: data,
                                  )))
                          .whenComplete(() => setState(() {}));
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              image: NetworkImage(data['images'][0]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
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
                        Positioned(
                          top: 15,
                          right: 10,
                          child: GestureDetector(
                            onTap: () async {
                              await Favourite.updateFavourite(data.id);
                              setState(() {});
                            },
                            child: Container(
                              child: UserProfile.favouriteList.contains(data.id)
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(Icons.favorite_border,
                                      color: Colors.white),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 5,
                          bottom: 15,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Icon(
                                    Icons.location_on_sharp,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    height: 20,
                                    child: Text(
                                      data['name'],
                                      maxLines: 1,
                                      // overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: const [
                              //     SizedBox(
                              //       width: 45,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //   ],
                              // ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ]));
  }
}
