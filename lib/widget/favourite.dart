import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_page/config/user.dart';

class Favourite {
  static Future<void> updateFavourite(String id) async {
    if (UserProfile.favouriteList.contains(id)) {
      UserProfile.favouriteList.remove(id);
    } else {
      UserProfile.favouriteList.add(id);
    }
    await FirebaseFirestore.instance
        .collection('favourite')
        .doc(UserProfile.id)
        .set({"favourite": UserProfile.favouriteList});
  }
}
