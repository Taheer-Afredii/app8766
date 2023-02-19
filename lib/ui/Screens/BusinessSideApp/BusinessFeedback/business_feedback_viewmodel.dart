import 'dart:developer';

import 'package:app_876/Model/business_user_model.dart';
import 'package:app_876/service/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessFeedbackViewModel extends ChangeNotifier {
  BusinessUserModel userModel = BusinessUserModel();

  BusinessFeedbackViewModel() {
    functions();
  }

  functions() async {
    await FirebaseServices().businessUserFromFirebase(userModel).then((value) {
      userModel = value;
      notifyListeners();
    });
  }

  double rating = 1.0;
  bool loading = false;

  void onRatingChanged(double value) {
    rating = value;
    log("$rating");
    notifyListeners();
  }

  ratingToCustomerBYBusiness(
      {customerid, reviewControler, docid, context}) async {
    loading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('buid');
    await FirebaseFirestore.instance
        .collection("CustomerUsers")
        .doc(customerid)
        .update(
      {
        "ratingByServiceProvider": FieldValue.arrayUnion([
          {
            "rating": rating,
            "review": reviewControler,
            "ratingBy": uid,
            "orderId": docid,
            "ratingByName": userModel.businessName,
            "date": DateTime.now().toString()
          }
        ])
      },
    ).then((value) {
      rating = 1.0;

      Get.snackbar("Success", "Thank you for your feedback");

      loading = false;
      Navigator.pop(context);
      notifyListeners();
    });
  }
}
