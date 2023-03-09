class Place {
  final String id;
  final String name;
  final String category;
  final int price;
  final String description;
  final List placeList;
  final String state;
  final double latitude;
  final double longitude;
  final double rate;
  final String vehical;
  final bool isRecommended;
  final String hotelDetails;
  final String nuofDays;

  Place({
    required this.id,
   required this.category,
   required this.price,
   required this.description,
   required this.placeList,
   required this.state,
   required this.latitude,
   required this.longitude,
   required this.rate,
   required this.vehical,
   required this.isRecommended,
    required this.name,
    required this.hotelDetails,
    required this.nuofDays,
  });

  /// This method used to map convert to model class
  factory Place.fromJson(Map<String, dynamic> json) => Place(
      id:json["id"],
      name: json["name"],
      category: json["category"],
      price: json["price"],
      description: json["description"],
      placeList: json["images"],
      state: json["state"],
      latitude: json["latitude"],
    longitude: json["longitude"],
    rate: json["rating"],
    vehical: json["vehical"],
    isRecommended: json["isrecommended"],
    hotelDetails: json["hotelname"],
    nuofDays: json["numberofdays"],
  );

  /// This method userd to model class convert to map
  Map<String, dynamic> toJson() => {
    "id":id,
    "name": name,
    "category": category,
    "price": price,
    "description": description,
    "images": placeList,
    "state": state,
    "latitude": latitude,
    "longitude":longitude,
    "rating":rate,
    "vehical":vehical,
    "isrecommended":isRecommended  ,
    "hotelname":hotelDetails,
    "numberofdays":nuofDays,
  };


}
