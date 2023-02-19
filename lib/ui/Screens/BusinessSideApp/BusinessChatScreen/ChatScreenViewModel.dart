import 'dart:developer';

import 'package:app_876/Model/business_user_model.dart';
import 'package:app_876/service/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessChatscreenViewModel extends ChangeNotifier {
  BusinessUserModel businessUser = BusinessUserModel();
  double distanceInkm = 0.0;
  TextEditingController messageController = TextEditingController();
  var businessUid;

  BusinessChatscreenViewModel({
    required double endLatitude,
    required double endLongitude,
  }) {
    getAllFunctions(
      endLatitude: endLatitude,
      endLongitude: endLongitude,
    );
  }

  bool minScreenLoading = false;

  getAllFunctions({
    required double endLatitude,
    required double endLongitude,
  }) async {
    minScreenLoading = true;
    notifyListeners();
    await getUid();

    await FirebaseServices()
        .businessUserFromFirebase(businessUser)
        .then((value) {
      businessUser = value;
      notifyListeners();
    });
    await calculateDistance(endLatitude, endLongitude);
    log("business");
    minScreenLoading = false;
    notifyListeners();
  }
  //calculate distance

  calculateDistance(
    double endLatitude,
    double endLongitude,
  ) async {
    if (businessUser.latitude != null && businessUser.longitude != null) {
      double distanceInMeters = await Geolocator.distanceBetween(
          double.parse(businessUser.latitude!),
          double.parse(businessUser.longitude!),
          endLatitude,
          endLongitude);
      distanceInkm = distanceInMeters / 1000;
      notifyListeners();
      log(">>>>>>>>> $distanceInkm");
    } else {
      log(">>>>>>>>> latitude and longitude is null");
    }
  }

  //send chat functionality

  bool loading = false;
  sendChat({
    customerID,
    businessUid,
  }) async {
    loading = true;
    notifyListeners();
    await FirebaseFirestore.instance.collection("Chats").add({
      "customerId": customerID,
      "businessId": businessUid,
      "message": messageController.text,
      "sendBy": businessUser.uid,
      "date": DateTime.now().toString()
    });
    messageController.clear();
    loading = false;
    notifyListeners();
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    businessUid = prefs.getString('buid');
    notifyListeners();
  }
}
