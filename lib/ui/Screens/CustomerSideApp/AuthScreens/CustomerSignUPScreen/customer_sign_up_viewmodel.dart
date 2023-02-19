import 'dart:developer';
import 'dart:io';

import 'package:app_876/Model/CustomerUser/customer_user_model.dart';
import 'package:app_876/service/firebase/Customer/customer_services.dart';
import 'package:app_876/service/localDatabase/customer_local_db.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerLocation/GetLocationScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../CustomerOTPVerificationScreen/CustomerOTPVerificationScreen.dart';

class CustomerSignUpViewModel extends ChangeNotifier {
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  CustomerUserModel customerUserModel = CustomerUserModel();
  CustomerFirebaseService firebaseDb = CustomerFirebaseService();

  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  String finalPhone = '';
  String? currentUserUid;
  bool loading = false;
  bool otpLoading = false;

  CustomerSignUpViewModel() {
    checkEmail();
  }

  //image picker
  File? image;
  ImagePicker imagePicker = ImagePicker();
  pickImage(ImageSource imageSource) async {
    final img = await imagePicker.pickImage(source: imageSource);
    if (img != null) {
      image = File(img.path);
      notifyListeners();
    }
  }

  // check if email is already in use
  List emailList = [];
  List phoneList = [];
  checkEmail() async {
    emailList.clear();
    phoneList.clear();
    await FirebaseFirestore.instance
        .collection("CustomerUsers")
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        phoneList.add(element.data()['phoneNumber']);
        emailList.add(element.data()['email']);

        notifyListeners();
      });
    });
    log("emailList $emailList");
  }

  //Otp Method>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Phone Authentication>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  phoneAuthentication({finalPhoneNumber, gender}) async {
    loading = true;
    notifyListeners();
    log("start loading $loading");
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: finalPhoneNumber,
          timeout: const Duration(seconds: 120),
          verificationCompleted: (PhoneAuthCredential credential) async {
            loading = true;
            log(" loading in complete $loading");
          },
          verificationFailed: (FirebaseAuthException exception) {
            loading = false;
            notifyListeners();
            Get.snackbar('Verification Failed', '${exception.message}',
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: const Duration(seconds: 10),
                snackPosition: SnackPosition.BOTTOM);
          },
          codeSent: (String verificationId, int) {
            loading = false;
            log(" loading in codesent $loading");

            notifyListeners();
            Get.to(
              () => CustomerOTPVerificationScreen(
                phoneNumber: finalPhoneNumber,
                verificationId: verificationId,
                gender: gender,
              ),
            );
          },
          codeAutoRetrievalTimeout: (String ver) {
            loading = false;
            notifyListeners();
          });
    } catch (e) {
      loading = false;
      notifyListeners();
      Get.snackbar('Error', 'OTP Verification Failed',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 30),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }

    // return widget;
  }

//verify Otp Method>>>>>>>>>>>>>>>>
  Future<void> verifyOtp({
    required String verificationId,
    required String otp,
    required gender,
    required finalphone,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    otpLoading = true;
    notifyListeners();
    currentUserUid = DateTime.now().microsecondsSinceEpoch.toString();

    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp.trim());

      await auth
          .signInWithCredential(credential)
          .then((UserCredential credential) async {
        customerUserModel.uid = currentUserUid;
        notifyListeners();

        await Get.to(() => GetLocationScreen(
              gender: gender,
              phone: finalPhone,
            ));
        otpLoading = false;
        notifyListeners();
      });
    } catch (e) {
      otpLoading = false;
      notifyListeners();
      log(e.toString());
      if (e ==
          "The sms code has expired. Please re-send the verification code to try again.") {
        Get.defaultDialog(
          title: "sms expired",
        );
      }
      Get.defaultDialog(
          title: "Worng OTP",
          content: const Text(
            "Your OTP is invaild.\n Please enter correct OTP",
            textAlign: TextAlign.center,
          ));
    }
  }
  //data to firebase >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  //Image to firebase
  String imageURl = '';
  imageUrlToFirebase() async {
    try {
      final ref = _storage.ref().child(
          "UserSignUp/profileImages/${DateTime.now().microsecondsSinceEpoch}");
      //Upload the file to firebase
      final uploadTask1 = await ref.putFile(File(image!.path));
      //get url from firebase storage
      // Wait till the file is uploaded
      imageURl = await uploadTask1.ref.getDownloadURL();
      customerUserModel.image = imageURl;
      //assign url to appUser model

      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  customerDataToFirebase({gender, finalphone}) async {
    customerUserModel.name = nameTextController.text;
    customerUserModel.email = emailTextController.text;
    customerUserModel.phoneNumber = finalphone;
    customerUserModel.password = passwordTextController.text;
    customerUserModel.gender = gender == true ? "Male" : "Female";
    CustomerLocalDB.setCustomerUserRecord(
        email: customerUserModel.email.toString(),
        uid: customerUserModel.uid.toString());
    isLoading = true;
    notifyListeners();
    await imageUrlToFirebase();
    await firebaseDb.customerToFirebase(customerUserModel);
    isLoading = false;
    notifyListeners();
  }
}
