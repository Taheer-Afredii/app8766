import 'dart:developer';

import 'package:app_876/Model/business_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServicesViewModel extends ChangeNotifier {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  BusinessUserModel businessUser = BusinessUserModel();
  List<ServiceModel> services = [];
  MyServicesViewModel() {
    allFunctions();
  }
  bool serviceLoading = false;
  allFunctions() async {
    await getServices();
  }

  getServices() async {
    serviceLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('buid');
    await firebase
        .collection("BusinessUsers")
        .doc(uid)
        .collection("addService")
        .snapshots()
        .listen((event) {
      services.clear();
      if (event.docs.isNotEmpty) {
        for (int i = 0; i < event.docs.length; i++) {
          services.add(ServiceModel.fromfirebase(event.docs[i]));
          var docid = event.docs[i].id;
        }
        notifyListeners();
      }
      serviceLoading = false;
      notifyListeners();
    });
  }
  //remove service

  removeService({docid}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('buid');
    await firebase
        .collection("BusinessUsers")
        .doc(uid)
        .collection("addService")
        .doc(docid)
        .delete();
  }
}

class ServiceModel {
  String? date;
  String? day;
  String? docid;
  bool? getPaidInAdvance;
  bool? getPaidAfter;
  String? month;
  String? serviceDescount;
  String? serviceName;
  String? servicePrice;
  String? serviceTime;
  String? uid;
  String? name;
  String? year;

  ServiceModel({
    this.date,
    this.day,
    this.docid,
    this.getPaidAfter,
    this.getPaidInAdvance,
    this.month,
    this.serviceDescount,
    this.serviceName,
    this.servicePrice,
    this.serviceTime,
    this.uid,
    this.year,
  });

  ServiceModel.fromfirebase(firebase) {
    date = firebase['date'];
    day = firebase['day'];
    docid = firebase['docId'];
    getPaidAfter = firebase['getPaidAfter'];
    getPaidInAdvance = firebase['gePaidInAdvance'];
    month = firebase['month'];
    serviceDescount = firebase['serviceDescount'];
    serviceName = firebase['serviceName'];
    servicePrice = firebase['servicePrice'];
    serviceTime = firebase['serviceTime'];
    uid = firebase['uid'];
    year = firebase['year'];
  }
}
