import 'package:flutter/material.dart';

class Custtab extends StatefulWidget {
  const Custtab({Key? key}) : super(key: key);

  @override
  State<Custtab> createState() => _CusttabState();
}

class _CusttabState extends State<Custtab> {
  int selectedButton = 0;
  List<String> buttonList = ["All", "Asia", "Europe"];

  List<Widget> widgetList = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.yellow,
    ),
    Container(
      color: Colors.blue,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                  itemCount: buttonList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedButton = i;
                        });
                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.all(15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: selectedButton == i
                                ? Border.all(color: Colors.black, width: 2)
                                : null),
                        child: Text(buttonList[i]),
                      ),
                    );
                  }),
            ),
            Expanded(child: widgetList[selectedButton])
          ],
        ),
      ),
    );
  }
}
