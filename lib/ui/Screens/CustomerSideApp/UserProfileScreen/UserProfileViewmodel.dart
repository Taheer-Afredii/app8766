import 'dart:developer';
import 'dart:io';

import 'package:app_876/Model/CustomerUser/customer_user_model.dart';
import 'package:app_876/service/firebase/Customer/customer_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileViewModel extends ChangeNotifier {
  TextEditingController editNameTextController = TextEditingController();
  TextEditingController editEmailTextController = TextEditingController();
  TextEditingController editPhoneTextController = TextEditingController();
  TextEditingController editAddressTextController = TextEditingController();
  CustomerUserModel user = CustomerUserModel();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  CustomerFirebaseService customerFirebaseService = CustomerFirebaseService();
  bool deleteLoading = false;
  bool updateLoading = false;
  String imageURl = '';
  File? image;
  List userlist = [];

  UserProfileViewModel() {
    CustomerFirebaseService().customerFromFirebase(user).then((value) {
      user = value;
      notifyListeners();
    });
    getAlluser();
  }

  //get all user
  getAlluser() async {
    await FirebaseFirestore.instance
        .collection('CustomerUsers')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          userlist.add(element.data()['email']);
        });
      }
    });
    notifyListeners();
  }

//image picker
  ImagePicker imagePicker = ImagePicker();
  pickImage(ImageSource imageSource) async {
    final img = await imagePicker.pickImage(source: imageSource);
    if (img != null) {
      image = File(img.path);
      notifyListeners();
    }
  }

  deleteuser() async {
    deleteLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('cuid');
    await FirebaseFirestore.instance
        .collection('CustomerUsers')
        .doc(uid)
        .delete();
    deleteLoading = false;
    notifyListeners();
  }

  imageUrlToFirebase() async {
    try {
      final ref = _storage.ref().child(
          "UserSignUp/profileImages/${DateTime.now().microsecondsSinceEpoch}");
      //Upload the file to firebase
      final uploadTask1 = await ref.putFile(File(image!.path));
      //get url from firebase storage
      // Wait till the file is uploaded
      imageURl = await uploadTask1.ref.getDownloadURL();
      notifyListeners();
      //assign url to appUser model

      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  updateuser() async {
    updateLoading = true;
    notifyListeners();
    if (userlist.contains(editEmailTextController.text)) {
      Get.snackbar("Email already exist", "Please enter another email",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      log("email already exist");
      //snakbar
      updateLoading = false;
      notifyListeners();
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var uid = prefs.getString('cuid');
      imageUrlToFirebase();
      await FirebaseFirestore.instance
          .collection('CustomerUsers')
          .doc(uid)
          .update({
        'name': editNameTextController.text == ''
            ? user.name
            : editNameTextController.text,
        'email': editEmailTextController.text == ""
            ? user.email
            : editEmailTextController.text,
        'phoneNumber': editPhoneTextController.text == ""
            ? user.phoneNumber
            : editPhoneTextController.text,
        'address': editAddressTextController.text == ""
            ? ""
            : editAddressTextController.text,
        'image': imageURl == "" ? user.image : imageURl,
      });
      updateLoading = false;
    }
  }
}
