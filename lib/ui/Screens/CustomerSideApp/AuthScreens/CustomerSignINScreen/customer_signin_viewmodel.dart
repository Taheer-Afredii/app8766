import 'dart:developer';

import 'package:app_876/service/localDatabase/customer_local_db.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/BottomNavScreens/MainUserBottomNavigationBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerSignInViewModel extends ChangeNotifier {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool isLoading = false;

  signIn() async {
    isLoading = true;
    notifyListeners();
    await FirebaseFirestore.instance
        .collection("CustomerUsers")
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) async {
          if (element.data()['email'] == emailTextController.text &&
              element.data()['password'] == passwordTextController.text) {
            log("${element.data()["uid"]}");

            CustomerLocalDB.setCustomerUserRecord(
                uid: element.data()["uid"],
                email: emailTextController.text,
                password: passwordTextController.text);

            await Get.to(MainUserBottomNavigationBar());

            log("success");
          }
        });
      }
    });
    emailTextController.clear();
    passwordTextController.clear();
    isLoading = false;
    notifyListeners();
  }
}
