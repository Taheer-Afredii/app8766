import 'dart:developer';

import 'package:app_876/Model/business_user_model.dart';
import 'package:app_876/Model/selecte_service_Model.dart';
import 'package:app_876/service/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessHomeScreenViewModel extends ChangeNotifier {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  SelectedServiceModel model = SelectedServiceModel();

  List upcomingOrdersIds = [];
  List<SelectedServiceModel> businessUpcomingOrders = [];

  bool loading = false;

  BusinessHomeScreenViewModel() {
    allFunctions();
    log("in usiness home model constructor");
  }
  allFunctions() async {
    loading = true;
    notifyListeners();

    log("1");
    await getUpcomingOrdersIds();
    log("2");
    await getBusinessUpcomingOrders();
    log("3");
  }

  getUpcomingOrdersIds() async {
    upcomingOrdersIds.clear();

    await firebase.collection("CustomerUsers").get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        upcomingOrdersIds.add(value.docs[i].id);
      }
      notifyListeners();
    });
  }

  getBusinessUpcomingOrders() async {
    businessUpcomingOrders.clear();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('buid');
    for (int i = 0; i < upcomingOrdersIds.length; i++) {
      log("1");
      await firebase
          .collection("CustomerUsers")
          .doc(upcomingOrdersIds[i])
          .collection("selectedServices")
          .where("businessuid", isEqualTo: uid)
          .where("status", isEqualTo: "pending")
          .snapshots()
          .listen((event) {
        if (event.docs.isNotEmpty) {
          businessUpcomingOrders.clear();
          for (int i = 0; i < event.docs.length; i++) {
            businessUpcomingOrders.add(SelectedServiceModel.fromFirebase(
                firebase: event.docs[i].data()));
          }
          notifyListeners();
        }
        loading = false;
        notifyListeners();
      });
    }
  }

  bool acceptLoading = false;
  acceptOrder({docid, required bool getback}) async {
    acceptLoading = true;
    notifyListeners();
    for (var i = 0; i < upcomingOrdersIds.length; i++) {
      await firebase
          .collection("CustomerUsers")
          .doc(upcomingOrdersIds[i])
          .collection("selectedServices")
          .doc(docid)
          .update({"status": "accepted"});
      getback == true ? Get.back() : null;
      Get.snackbar("Order Accepted", "Order Accepted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2));
    }

    acceptLoading = false;
    notifyListeners();
  }

  bool rejectLoading = false;

  removeOrder({docid, required bool getback}) {
    rejectLoading = true;
    notifyListeners();
    for (var i = 0; i < upcomingOrdersIds.length; i++) {
      firebase
          .collection("CustomerUsers")
          .doc(upcomingOrdersIds[i])
          .collection("selectedServices")
          .doc(docid)
          .delete();
      getback == true ? Get.back() : null;
      notifyListeners();

      Get.snackbar("Order Rejected", "Order Rejected Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 2));
    }

    rejectLoading = false;
    notifyListeners();
  }
}
