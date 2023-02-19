import 'dart:developer';

import 'package:app_876/Model/CustomerUser/customer_user_model.dart';
import 'package:app_876/service/firebase/Customer/customer_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerChatScreenViewModel extends ChangeNotifier {
  CustomerUserModel customerUser = CustomerUserModel();
  double distanceInkm = 0.0;
  TextEditingController messageController = TextEditingController();
  var customerUid;

  CustomerChatScreenViewModel({
    required double endLatitude,
    required double endLongitude,
  }) {
    getAllFunctions(
      endLatitude: endLatitude,
      endLongitude: endLongitude,
    );
  }

  //all functions
  bool minScreenLoading = false;

  getAllFunctions({
    required double endLatitude,
    required double endLongitude,
  }) async {
    minScreenLoading = true;
    notifyListeners();
    await getUid();

    await CustomerFirebaseService()
        .customerFromFirebase(customerUser)
        .then((value) {
      customerUser = value;
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
    if (customerUser.latitude != null && customerUser.longitude != null) {
      double distanceInMeters = await Geolocator.distanceBetween(
          double.parse(customerUser.latitude!),
          double.parse(customerUser.longitude!),
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
      "sendBy": customerUser.uid,
      "date": DateTime.now().toString()
    });
    messageController.clear();
    loading = false;
    notifyListeners();
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customerUid = prefs.getString('cuid');
    notifyListeners();
  }
}
