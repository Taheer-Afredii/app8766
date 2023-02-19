import 'dart:developer';

import 'package:app_876/Model/business_user_addservice_model.dart';
import 'package:app_876/Model/business_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseServices {
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  BusinessUserModel businessUserModel = BusinessUserModel();

  businessUserToFirebase(BusinessUserModel businessUserModel1) async {
    log("business user to firebase ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('buid');
    log("uid in business firebase db $uid");
    await firebase
        .collection('BusinessUsers')
        .doc(uid)
        .update(businessUserModel1.toFirebase());
  }

  businessUserFromFirebase(BusinessUserModel businessUserModel1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('buid');
    final snapshot = await firebase.collection('BusinessUsers').doc(uid).get();
    if (snapshot.exists) {
      return BusinessUserModel.Fromfirebase(firebase: snapshot.data());
    } else {
      log("in businessUserFromFirebase() snapshot doesn't exist");
      return BusinessUserModel();
    }
  }

  //get all business users
  getAllBusinessUser(List<BusinessUserModel> businessUserModel) async {
    final snapshot = await firebase.collection('BusinessUsers').get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs
          .map((e) => BusinessUserModel.Fromfirebase(firebase: e.data()))
          .toList();
    } else {
      log("in businessUserAllFromFirebase() snapshot doesn't exist");
      return BusinessUserModel();
    }
  }
  //>>>>>>>>>>>>>>>Addservice<<<<<<<<<<<<<<<<<<<<<

  businessUserAddserviceToFirebase(
      BusinessUserAddserviceModel businessAddServiceModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('buid');
    // await FirebaseFirestore.instance
    //     .collection("arshad")
    //     .add(businessAddServiceModel.toFirebase());
    log("in businessUserAddserviceToFirebase()${businessAddServiceModel.toFirebase()}");
    await FirebaseFirestore.instance
        .collection('BusinessUsers')
        .doc(uid)
        .collection("addService")
        .add(businessAddServiceModel.toFirebase())
        .then((value) {
      //add doc id
      FirebaseFirestore.instance
          .collection('BusinessUsers')
          .doc(uid)
          .collection("addService")
          .doc(value.id)
          .update({
        "docId": value.id,
      });
    });
  }

  //from firebase
  businessUserAddserviceFromFirebase(
      BusinessUserAddserviceModel businessAddServiceModel) async {
    final snapshot = await firebase
        .collection('BusinessUsers')
        .doc(businessUserModel.uid)
        .collection('Addservice')
        .get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs
          .map((e) =>
              BusinessUserAddserviceModel.fromFirebase(firebase: e.data()))
          .toList();
    } else {
      log("in businessUserAddserviceFromFirebase() snapshot doesn't exist");
      return BusinessUserAddserviceModel();
    }
  }
}
