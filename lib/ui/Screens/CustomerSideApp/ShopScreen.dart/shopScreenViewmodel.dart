import 'dart:developer';

import 'package:app_876/ui/Screens/CustomerSideApp/ServiceSearchScreen/SearviceSearchScreenViewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopScreenViewModel extends ChangeNotifier {
  phoneLaunch(String phone) async {
    String url = "tel:$phone";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  ShopScreenViewModel() {
    getFavouriteListInStraem();
    getWorkRoutine();
  }

  // addToList(value) {
  //   serviceLocalList.add(value);
  //   notifyListeners();
  // }

  // removeFromList(value) {
  //   serviceLocalList.removeAt(value);
  //   notifyListeners();
  // }

  mapLaunch(String lat, String long) async {
    String url = "https://www.google.com/maps/search/?api=1&query=$lat,$long";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  launchWeb() async {
    String url = "https://www.google.com";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  //favoutite button pressed
  addToFavourite(busineesUid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('cuid').toString();
    await FirebaseFirestore.instance
        .collection("CustomerUsers")
        .doc(uid)
        .update({
      "favorite": FieldValue.arrayUnion([busineesUid]),

      // "favorite": FieldValue.arrayRemove([searchModel.uid]),
    });
    favouriteList.add(busineesUid);
    notifyListeners();
  }

  // remove favourite button pressed
  removefromFavourite(busineesUid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('cuid').toString();
    await FirebaseFirestore.instance
        .collection("CustomerUsers")
        .doc(uid)
        .update({
      // "favorite": FieldValue.arrayUnion([searchModel.uid]),
      "favorite": FieldValue.arrayRemove([busineesUid]),
    });
    favouriteList.remove(busineesUid);
    notifyListeners();

    //get favourite lis
  }

  List favouriteList = [];
  getFavouriteListInStraem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('cuid').toString();
    await FirebaseFirestore.instance
        .collection("CustomerUsers")
        .doc(uid)
        .snapshots()
        .listen((event) {
      log("favourite>>>>>>>>in shop sscreen list is empty");
      if (event.data()!['favorite'] != null) {
        favouriteList = event.data()!['favorite'];
        notifyListeners();
      } else {
        favouriteList = [];
        log("favourite list is empty");
      }
      notifyListeners();
      print(favouriteList);
    });
  }

  //add selected service to Firebase
  bool addserviceLoading = false;
  addSelectedServices(List servicelocalList) async {
    addserviceLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('cuid');
    for (int i = 0; i < servicelocalList.length; i++) {
      await FirebaseFirestore.instance
          .collection('CustomerUsers')
          .doc(uid)
          .collection('selectedServices')
          .add({
        'selectedServices': servicelocalList[i],
      }).then((value) async {
        //add document id to list
        await FirebaseFirestore.instance
            .collection('CustomerUsers')
            .doc(uid)
            .collection('selectedServices')
            .doc(value.id)
            .update({
          'currentDocId': value.id,
          "uid": uid,
        });
      });
    }
    addserviceLoading = false;
    notifyListeners();
  }

  //get workroutine hours
  List workRoutineList = [];
  getWorkRoutine() async {
    var uid =
        Provider.of<ServiceSearchScreenViewmodel>(Get.context!, listen: false)
            .buid;
    await FirebaseFirestore.instance
        .collection("BusinessUsers")
        .doc(uid)
        .collection("workRoutine")
        .doc(uid)
        .snapshots()
        .listen((event) {
      if (event.data()!['duty_days'] != null) {
        workRoutineList = event.data()!['duty_days'];
        notifyListeners();
      } else {
        workRoutineList = [];
      }
      notifyListeners();
    });
  }
}
