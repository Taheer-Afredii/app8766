import 'dart:developer';

import 'package:app_876/Model/CustomerUser/customer_user_model.dart';
import 'package:app_876/service/firebase/Customer/customer_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedBackScreenVoiewModel extends ChangeNotifier {
  CustomerUserModel customerUser = CustomerUserModel();

  FeedBackScreenVoiewModel() {
    CustomerFirebaseService().customerFromFirebase(customerUser).then((value) {
      customerUser = value;
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

  ratingToBusinessByCustomer(
      {businessId, reviewControler, docid, context}) async {
    loading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('cuid');
    await FirebaseFirestore.instance
        .collection("BusinessUsers")
        .doc(businessId)
        .update(
      {
        "ratingByCustomers": FieldValue.arrayUnion([
          {
            "rating": rating,
            "review": reviewControler,
            "ratingBy": uid,
            "orderId": docid,
            "ratingByName": customerUser.name,
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
