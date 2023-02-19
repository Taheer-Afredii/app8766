import 'package:app_876/Model/selecte_service_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBookingViewModel extends ChangeNotifier {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  UserBookingViewModel({required int index}) {
    allFunctions(index: index);
  }

  //>>>>>>>>>>all Functions  <<<<<<<<<<<<<<<<<<<<<<
  allFunctions({index}) async {
    if (index == 1) {
      upcomingLoading = true;
      notifyListeners();
      await getUpcomingOrders();
    }
    if (index == 3) {
      completedLoading = true;
      notifyListeners();
      await getCompletedOrders();
    }
  }

  //>>>>>>>>>>upcoming orders <<<<<<<<<<<<<<<<<<<<<<

  List<SelectedServiceModel> upcomingOrders = [];
  bool upcomingLoading = false;

  getUpcomingOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('cuid');
    await firebase
        .collection("CustomerUsers")
        .doc(uid)
        .collection("selectedServices")
        .where("status", isEqualTo: "accepted")
        .where("date", isGreaterThan: DateTime.now())
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        upcomingOrders.clear();
        for (int i = 0; i < event.docs.length; i++) {
          upcomingOrders.add(SelectedServiceModel.fromFirebase(
              firebase: event.docs[i].data()));
        }
      }
      upcomingLoading = false;
      notifyListeners();
    });
  }

  //>>>>>>>>>>>>>>>>>>>   Completed Orders <<<<<<<<<<<<<<<

  List<SelectedServiceModel> completedOrders = [];
  bool completedLoading = false;

  getCompletedOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('cuid');
    await firebase
        .collection("CustomerUsers")
        .doc(uid)
        .collection("selectedServices")
        .where("completed", isEqualTo: true)
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        completedOrders.clear();
        for (int i = 0; i < event.docs.length; i++) {
          completedOrders.add(SelectedServiceModel.fromFirebase(
              firebase: event.docs[i].data()));
        }
      }
      completedLoading = false;
      notifyListeners();
    });
  }
}
