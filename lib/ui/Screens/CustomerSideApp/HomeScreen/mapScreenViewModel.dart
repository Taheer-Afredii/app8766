import 'dart:developer';

import 'package:app_876/Model/business_user_model.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreenViewModel extends ChangeNotifier {
  FirebaseFirestore firbase = FirebaseFirestore.instance;

  List<BusinessUserModel> businessUser = [];
  BusinessUserModel businessUserModel = BusinessUserModel();
  String? latitude;
  String? longitude;
  bool isMapLoading = false;
  String search = "";

  //constructor

  //get search value on onchange function in textfield
  onSearch(String value) {
    search = value;
    notifyListeners();
  }

  getAllFunctions({serviceCategory}) async {
    isMapLoading = true;
    notifyListeners();
    businessUser.clear();
    nearByBusiness.clear();
    //get customer user
    await getCustomerUser();
    //get near by business
    await getBusinessUserByCategory(serviceCategory);
    isMapLoading = false;

    notifyListeners();
  }

  //get customer user
  getCustomerUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('cuid');
    await FirebaseFirestore.instance
        .collection("CustomerUsers")
        .doc(uid)
        .get()
        .then((value) {
      if (value.exists) {
        latitude = value.data()!['latitude'];
        longitude = value.data()!['longitude'];
        log("latitude in get cust $latitude");
        log("longitude in get cust $longitude");

        notifyListeners();
      }
    });
  }

//get business user by category
  getBusinessUserByCategory(String category) async {
    log("in getBusinessUserByCategory init $category");
    businessUser.clear();
    nearByBusiness.clear();
    if (latitude != null) {
      await firbase
          .collection("BusinessUsers")
          .where("serviceCategory", isEqualTo: category)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          for (var i = 0; i < value.docs.length; i++) {
            businessUser.add(
                BusinessUserModel.Fromfirebase(firebase: value.docs[i].data()));
          }
          // for (var i = 0; i < value.docs.length; i++) {
          //   businessUser.add(BusinessUserModel.Fromfirebase(
          //       firebase: value.docs[i].data()));
          // }
          notifyListeners();
          log("business user length ${businessUserModel.businessName}");
        }
      });
      await getNearByBusiness();
      await addMarker();
      notifyListeners();
    } else {
      log("latitude is null");
    }
  }

  //Google maps methods
  List nearByBusiness = [];
  double? distanceInKm;

  getNearByBusiness() async {
    for (var i = 0; i < businessUser.length; i++) {
      var distance = Geolocator.distanceBetween(
          double.parse(latitude!),
          double.parse(longitude!),
          double.parse(businessUser[i].latitude.toString()),
          double.parse(businessUser[i].longitude.toString()));

      distanceInKm = distance / 1000;
      log("kitchen distance $distanceInKm");
      nearByBusiness.add(distanceInKm);

      log("kitchen distance in km  >>>>>>>$distanceInKm");
    }

    notifyListeners();
  }

  final Set<Marker> markers = {};

  addMarker() async {
    markers.clear();
    log("enter in >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>i function addMarker");
    for (var i = 0; i < businessUser.length; i++) {
      for (var i = 0; i < nearByBusiness.length; i++) {
        log("image business ${businessUser[i].image}");
        if (nearByBusiness[i] <= 10) {
          markers.add(
            Marker(
              icon: await MarkerIcon.pictureAsset(
                assetPath: "assets/images/marker.png",
                width: 100.w,
                height: 100.h,
              ),
              markerId: MarkerId(businessUser[i].businessName!),
              position: LatLng(
                  double.parse(businessUser[i].latitude.toString()),
                  double.parse(businessUser[i].longitude.toString())),
              infoWindow: InfoWindow(
                  title: businessUser[i].businessName,
                  snippet: businessUser[i].serviceDetails,
                  onTap: () {}),
            ),
          );
          notifyListeners();
          //update marker

        }
      }
    }
  }

  //update marker
  updateMarker() async {
    markers.clear();
    await addMarker();
    notifyListeners();
  }
}

//serviceListScreenSearchController,
List<String> serviceImages = [
  serviceListImage1,
  serviceListImage2,
  serviceListImage3,
  serviceListImage4,
  serviceListImage5,
  serviceListImage6,
  serviceListImage7,
  serviceListImage8,
  serviceListImage9,
  serviceListImage10,
  serviceListImage11,
  serviceListImage12,
  serviceListImage13,
  serviceListImage14,
  serviceListImage15,
  serviceListImage16,
  serviceListImage17,
  serviceListImage18,
  // serviceListImage19,
  // serviceListImage20,
  // serviceListImage21,
];

final List<String> serviceTitles = [
  'Adult Bars Entertainment',
  'Architect',
  'Barbers',
  'Auto Mechanic',
  'Beautician',
  'Construction',
  'Boutiques',
  'Dentist',
  'Designer Stylist',
  'Doctors',
  'Gym',
  'Hair Stylist',
  'Hardware',
  'Hotels',
  'Message Therapist',
  'Night Club',
  'Personal Trainer',
  'Realtors',
];
