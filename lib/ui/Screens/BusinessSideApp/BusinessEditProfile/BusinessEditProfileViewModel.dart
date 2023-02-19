import 'dart:developer';
import 'dart:io';

import 'package:app_876/Model/business_user_model.dart';
import 'package:app_876/service/firebase/firebase_services.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyBusinessProfileScreen/MyBusinessProfileScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessEditProfileViewModel extends ChangeNotifier {
  BusinessUserModel businessUser = BusinessUserModel();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  TextEditingController businessProfileRegNoController =
      TextEditingController();
  TextEditingController businessProfilePhoneNoController =
      TextEditingController();
  TextEditingController businessProfileEmailController =
      TextEditingController();
  TextEditingController businessProfileWebsiteController =
      TextEditingController();
  TextEditingController businessProfileDetailsController =
      TextEditingController();
  String? coverImageUrl;
  String? profileImageUrl;

  BusinessEditProfileViewModel() {
    allFunctions();
  }

  bool loading = false;
  allFunctions() async {
    loading = true;
    notifyListeners();

    FirebaseServices().businessUserFromFirebase(businessUser).then((value) {
      businessUser = value;
      notifyListeners();
    });
    loading = false;
    notifyListeners();
  }

  //cover image picker
  File? coverImage;
  ImagePicker imagePicker = ImagePicker();
  coverPickImage(ImageSource imageSource) async {
    final img = await imagePicker.pickImage(source: imageSource);
    if (img != null) {
      coverImage = File(img.path);
      notifyListeners();
    }
  }

  // /cover image picker
  File? profileImage;

  profileImagePickImage(ImageSource imageSource) async {
    final img = await imagePicker.pickImage(source: imageSource);
    if (img != null) {
      profileImage = File(img.path);
      notifyListeners();
    }
  }
//>>>>>>>>>>>>>>>>>>>>>>>>> update profile >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  bool updateLoading = false;
  updateProfile() async {
    updateLoading = true;
    notifyListeners();
    await imageToFirebaseStorage();
    await updateData();
    Get.snackbar("Success", "Profile Updated Successfully",
        snackPosition: SnackPosition.BOTTOM);
    Get.off(() => MyBusinessProfileScreen());
    updateLoading = false;
    notifyListeners();
  }

  imageToFirebaseStorage() async {
    try {
      final ref1 = _storage.ref().child(
          "UserSignUp/profileImages/${DateTime.now().microsecondsSinceEpoch}");
      final ref2 = _storage.ref().child(
          "UserSignUp/profileImages/${DateTime.now().microsecondsSinceEpoch}");
      //Upload the file to firebase
      final uploadTask1 = await ref1.putFile(File(coverImage!.path));
      final uploadTask2 = await ref2.putFile(File(profileImage!.path));
      //get url from firebase storage
      // Wait till the file is uploaded
      coverImageUrl = await uploadTask1.ref.getDownloadURL();
      profileImageUrl = await uploadTask2.ref.getDownloadURL();
      //assign url to appUser model

      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  updateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString("buid");
    await FirebaseFirestore.instance
        .collection("BusinessUsers")
        .doc(uid)
        .update({
      "registrationNumber": businessProfileRegNoController.text.isEmpty
          ? businessUser.registrationNumber
          : businessProfileRegNoController.text,
      "email": businessProfileEmailController.text.isEmpty
          ? businessUser.email
          : businessProfileEmailController.text,
      "phone": businessProfilePhoneNoController.text.isEmpty
          ? businessUser.phoneNumber
          : businessProfilePhoneNoController.text,
      "website": businessProfileWebsiteController.text.isEmpty
          ? businessUser.website
          : businessProfileWebsiteController.text,
      "Details": businessProfileDetailsController.text.isEmpty
          ? businessUser.serviceDetails
          : businessProfileDetailsController.text,
      "image": profileImageUrl ?? businessUser.image,
      "coverImage": coverImageUrl,
    });
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>> update profile >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
}
