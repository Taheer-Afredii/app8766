import 'dart:developer';

import 'package:app_876/Model/selecte_service_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessBookingViewModel extends ChangeNotifier {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  List upcomingOrdersIds = [];
  List<SelectedServiceModel> businessAcceptedOrders = [];
  List<SelectedServiceModel> businessAcceptedUpcomingOrder = [];
  List<SelectedServiceModel> businessAwaitingOrders = [];
  List<SelectedServiceModel> businessAwaitORdidnotArriveOrders = [];
  List<SelectedServiceModel> businessCompletedOrders = [];

//dispose provider

  @override
  void dispose() {
    super.dispose();
  }

  BusinessBookingViewModel({required int index}) {
    allFunctions(index: index);
  }
  bool completedLoading = false;
  bool awaitingLoading = false;
  bool acceptedLoading = false;

  void allFunctions({required int index}) async {
    log("index is $index");
    acceptedLoading = true;
    awaitingLoading = true;
    completedLoading = true;
    notifyListeners();
    await getUpcomingOrdersId();
    if (index == 1) {
      await getBusinessAcceptedOrders();
    } else if (index == 2) {
      await getBusinessAwaitingOrder();
    } else if (index == 3) {
      await getBusinessCompletedOrder();
    }
  }
//>>>>>>>>get all customer ids<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  getUpcomingOrdersId() async {
    upcomingOrdersIds.clear();
    await firebase.collection("CustomerUsers").get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        upcomingOrdersIds.add(value.docs[i].id);
      }
    });
    notifyListeners();
  }

//>>>>>>>>>>accepted orders <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  getBusinessAcceptedOrders() async {
    log("in accepted orders");
    businessAcceptedOrders.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('buid');
    for (int i = 0; i < upcomingOrdersIds.length; i++) {
      await firebase
          .collection("CustomerUsers")
          .doc(upcomingOrdersIds[i])
          .collection("selectedServices")
          .where("businessuid", isEqualTo: uid)
          .where("status", isEqualTo: "accepted")
          .snapshots()
          .listen((event) async {
        businessAcceptedOrders.clear();
        if (event.docs.isNotEmpty) {
          log("in accept listener");
          for (int i = 0; i < event.docs.length; i++) {
            businessAcceptedOrders.add(SelectedServiceModel.fromFirebase(
                firebase: event.docs[i].data()));
          }
        }
        acceptedLoading = false;
        await getBusinessUpcomingOrders();
      });
      notifyListeners();
    }
  }

  getBusinessUpcomingOrders() async {
    businessAcceptedUpcomingOrder.clear();
    //convert time stamp to date time

    if (businessAcceptedOrders.isNotEmpty) {
      for (int i = 0; i < businessAcceptedOrders.length; i++) {
        if (businessAcceptedOrders[i].date!.toDate().isAfter(DateTime.now())) {
          businessAcceptedUpcomingOrder.add(businessAcceptedOrders[i]);
        }
      }

      notifyListeners();
    }
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>get business completed orders><><><><>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  getBusinessCompletedOrder() async {
    log("in completed orders");
    businessCompletedOrders.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('buid');
    for (int i = 0; i < upcomingOrdersIds.length; i++) {
      await firebase
          .collection("CustomerUsers")
          .doc(upcomingOrdersIds[i])
          .collection("selectedServices")
          .where("businessuid", isEqualTo: uid)
          .where("completed", isEqualTo: true)
          .snapshots()
          .listen((event) async {
        businessCompletedOrders.clear();
        if (event.docs.isNotEmpty) {
          log("in completed order listener");
          for (int i = 0; i < event.docs.length; i++) {
            businessCompletedOrders.add(SelectedServiceModel.fromFirebase(
                firebase: event.docs[i].data()));
          }
        }
        completedLoading = false;
        notifyListeners();
      });
    }

    notifyListeners();
  }

  //>>>>>>>>>>get business awaiting orders>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  getBusinessAwaitingOrder() async {
    log("in awaiting orders");
    businessAwaitORdidnotArriveOrders.clear();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('buid');
    for (int i = 0; i < upcomingOrdersIds.length; i++) {
      await firebase
          .collection("CustomerUsers")
          .doc(upcomingOrdersIds[i])
          .collection("selectedServices")
          .where("businessuid", isEqualTo: uid)
          .where("date", isLessThan: DateTime.now())
          .where("completed", isEqualTo: false)
          .snapshots()
          .listen((event) async {
        businessAwaitORdidnotArriveOrders.clear();
        if (event.docs.isNotEmpty) {
          log("in awaiting order listener");
          for (int i = 0; i < event.docs.length; i++) {
            businessAwaitORdidnotArriveOrders.add(
                SelectedServiceModel.fromFirebase(
                    firebase: event.docs[i].data()));
          }
        }
        awaitingLoading = false;
        notifyListeners();
      });
    }
  }

  //>>>>>>>>>>get business awaiting orders
  // awaitingOrders() {
  //   log("in awaiting orders");
  //   businessAwaitingOrders.clear();
  //   for (int i = 0; i < businessAwaitORdidnotArriveOrders.length; i++) {
  //     if (businessAcceptedOrders[i].date!.toDate().isBefore(DateTime.now())) {
  //       businessAwaitingOrders.add(businessAwaitORdidnotArriveOrders[i]);
  //     }
  //     notifyListeners();
  //   }
  // }

  //>>>>>>>>>>>>>>>>>>>>  mark as completed and mark is not arrivied <<<<<<<<<<<<<<<<<<<<<<<<

  markIsCompleted({required String docid, required String customerId}) async {
    log("customer $customerId");
    await firebase
        .collection("CustomerUsers")
        .doc(customerId)
        .collection("selectedServices")
        .doc(docid)
        .update({
      "completed": true,
    });
    log("docid $docid");
    log("customerId $customerId");

    Get.snackbar(
      "Success",
      "Order marked as completed",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  markIsDidNotArrive(String docid) async {
    for (int i = 0; i < upcomingOrdersIds.length; i++) {
      await firebase
          .collection("CustomerUsers")
          .doc(upcomingOrdersIds[i])
          .collection("selectedServices")
          .doc(docid)
          .update({
        "arrived": true,
      });
    }
    log("docid $docid");
    Get.snackbar(
      "Success",
      "Order marked as did not arrive",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  //>>>>>>>>>>get business upcoming orders
  // getBusinessUpcomingOrders() async {
  //   businessUpcomingOrders.clear();

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var uid = prefs.getString('buid');
  //   for (int i = 0; i < upcomingOrdersIds.length; i++) {
  //     await firebase
  //         .collection("CustomerUsers")
  //         .doc(upcomingOrdersIds[i])
  //         .collection("selectedServices")
  //         .where("businessId", isEqualTo: uid)
  //         .where("status", isEqualTo: "pending")
  //         .snapshots()
  //         .listen((event) {
  //       businessUpcomingOrders.clear();
  //       if (event.docs.isNotEmpty) {
  //         for (int i = 0; i < event.docs.length; i++) {
  //           businessUpcomingOrders.add(SelectedServiceModel.fromFirebase(
  //               firebase: event.docs[i].data()));
  //           notifyListeners();
  //         }
  //       }
  //     });
  //   }
  // }

}
