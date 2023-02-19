import 'package:app_876/service/localDatabase/local_db.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BottomNavScreen/MainBusinessBottomNavigationBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessSignInViewModel extends ChangeNotifier {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool isLoading = false;

  signIn() async {
    isLoading = true;
    notifyListeners();
    await FirebaseFirestore.instance
        .collection("BusinessUsers")
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        if (element.data()['email'] == emailTextController.text &&
            element.data()['password'] == passwordTextController.text) {
          LocalDB.setBusinessUserRecord(
              uid: element.data()["uid"],
              email: emailTextController.text,
              password: passwordTextController.text);
          Get.to(() => MainBusinessBottomNavigationBar());

          print("success");
        } else {
          print("failed");
        }
      });
    });
    isLoading = false;
    notifyListeners();
  }
}
