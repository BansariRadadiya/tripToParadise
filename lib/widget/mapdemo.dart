import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDemo extends StatefulWidget {
   MapDemo({Key? key, this.longitute, this.latitude}) : super(key: key);

  final double? longitute;
  final double? latitude;

  @override
  State<MapDemo> createState() => _MapDemoState();
}

class _MapDemoState extends State<MapDemo> {
  late GoogleMapController _mapController;
  Map<String, Marker> _markers = {};


@override
  void initState() {
    // TODO: implement initState
  setState(() {
    double long=widget.longitute!;
    double lati=widget.latitude!;
    print("LOng runtype ${long.runtimeType}");
    print("LAti runtype ${lati.runtimeType}");
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double long=widget.longitute!;
    double lati=widget.latitude!;
    print("LOng runtype ${long.runtimeType}");
    print("LAti runtype ${lati.runtimeType}");
    return Scaffold(
      appBar: AppBar(title: Text('Location'),leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
        Navigator.of(context).pop();
      },),),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            lati.toDouble(),
            long.toDouble()
            // 15.515447,
            // 73.768402,

          ),
          zoom: 18,
        ),
        onMapCreated: (controler) {
          _mapController = controler;
          addMarker(
              'test',
              LatLng(
                  lati.toDouble(),
                  long.toDouble()
                // 15.515447,
                // 73.768402,
              ));
        },
        markers: _markers.values.toSet(),
      ),
    );
    ;
  }

  addMarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
    );
    _markers[id] = marker;
    setState(() {});
  }
}
