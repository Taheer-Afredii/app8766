import 'dart:developer';
import 'dart:io';

import 'package:app_876/Model/business_user_model.dart';
import 'package:app_876/service/firebase/firebase_services.dart';
import 'package:app_876/service/localDatabase/local_db.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/BusineesOTPVerificationScreen/BusinessOTPVerificationScreen.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/ServicesAdditionScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/HomeScreen/HomeScreenModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessSignUpViewModel extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseServices firebase = FirebaseServices();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? coverImageUrl;
  String? profileImageUrl;
  BusinessUserModel businessUserModel = BusinessUserModel();
  bool isLoading = false;
  bool loading = false;
  bool otpLoading = false;
  String? busineesUid;
  ServiceImages? selectedDropdownItem;

  getServiceCategory(value) {
    selectedDropdownItem = value;
    notifyListeners();
  }

  String? serviceCategoryBool;
  getServiceCategoryBool(String? value) {
    serviceCategoryBool = value;
    notifyListeners();
  }

  BusinessSignUpViewModel() {
    checkEmail();
  }

  final List<String> serviceCategoryList = [
    'Adult Bars Entertainment',
    'Architect',
    'Auto Mechanic',
    'Barbers',
    'Beautician',
    'Boutiques',
    'Construction',
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
  String? genderCategoryBool;
  getGenderBool(String? value) {
    genderCategoryBool = value;
    notifyListeners();
  }

  final List<String> genderList = [
    'Male',
    'Female',
  ];
  String? numberOfEmployeesBool;
  getNumberOfEmployeesBool(String? value) {
    numberOfEmployeesBool = value;
    notifyListeners();
  }

  final List<String> numberofEmployeesList = [
    '3-5',
    '6-10',
    '11-15',
    '16-20',
    '20-24',
  ];

  TextEditingController businessnameController = TextEditingController();
  TextEditingController businessNoController = TextEditingController();
  TextEditingController businessPhoneNumberController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessWebsiteController = TextEditingController();
  TextEditingController businessDetailsController = TextEditingController();
  TextEditingController businessPasswordController = TextEditingController();

//cover image picker
  File? coverImage;
  ImagePicker imagePicker = ImagePicker();
  coverImagepickImage(ImageSource imageSource) async {
    final img = await imagePicker.pickImage(source: imageSource);
    if (img != null) {
      coverImage = File(img.path);
      notifyListeners();
    }
  }

  //profile image picker
  File? profileImage;
  pickImage(ImageSource imageSource) async {
    final img = await imagePicker.pickImage(source: imageSource);
    if (img != null) {
      profileImage = File(img.path);
      notifyListeners();
    }
  }

//check if email is already in use
  List emailList = [];
  List phoneList = [];
  checkEmail() async {
    await FirebaseFirestore.instance
        .collection("BusinessUsers")
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
  phoneAuthentication() async {
    loading = true;
    notifyListeners();
    log("start loading $loading");
    log("in phoneAuthentication() ${businessPhoneNumberController.text}");
    busineesUid = DateTime.now().microsecondsSinceEpoch.toString();
    notifyListeners();
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: businessPhoneNumberController.text,
          timeout: const Duration(seconds: 120),
          verificationCompleted: (PhoneAuthCredential credential) async {
            loading = true;
            notifyListeners();
            //  await _auth
            //       .signInWithCredential(credential)
            //       .then((UserCredential credential) async {});
          },
          verificationFailed: (FirebaseAuthException exception) {
            loading = false;
            notifyListeners();
            Get.snackbar('Verification Failed', '${exception.message}',
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: const Duration(seconds: 60),
                snackPosition: SnackPosition.BOTTOM);
          },
          codeSent: (String verificationId, int) {
            Get.to(() => BusinessOTPVerificationScreen(
                  phoneNumber: businessPhoneNumberController.text,
                  verificationId: verificationId,
                ));
          },
          codeAutoRetrievalTimeout: (String ver) {});
    } catch (e) {
      loading = false;
      notifyListeners();
      Get.snackbar('Error', 'OTP Verification Failed',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 30),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }

    log("stop loading $loading");

    // return widget;
  }

//verify Otp Method>>>>>>>>>>>>>>>>
  Future<void> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      otpLoading = true;
      notifyListeners();
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp.trim());

      await auth
          .signInWithCredential(credential)
          .then((UserCredential credential) async {
        businessUserModel.uid = busineesUid;

        notifyListeners();

        // log("in phone auth Screen${businessUserModel.uid} ${credential.user!.uid} ");

        FirebaseFirestore.instance
            .collection("BusinessUsers")
            .doc(busineesUid)
            .set({"date": DateTime.now().toString()});
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("buid", busineesUid.toString());
        var uid = pref.getString("buid");
        log("in otp $uid");

        otpLoading = false;
        // Get.to(LocationScreen());
        await Get.to(() => BusinessAddServicesScreen());

        notifyListeners();
        //add first screen data to firebase
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

  //intilize Collection
  String serviceImageUrl = "";

  uploadServiceImage() async {
    final storage = FirebaseStorage.instance;

    try {
      final name = selectedDropdownItem!.imageName != null
          ? selectedDropdownItem!.imageName
          : serviceImage[0].imageName;
      final path = selectedDropdownItem!.image != null
          ? selectedDropdownItem!.image
          : serviceImage[0].image;
      final ref = storage.ref().child('images/$name');
      final byteData = await rootBundle.load(path.toString());
      final imageData = byteData.buffer.asUint8List();
      await ref.putData(imageData);

      serviceImageUrl = await ref.getDownloadURL();
      businessUserModel.serviceCategoryImage = serviceImageUrl;
      log("service url $serviceImageUrl");
      notifyListeners();
    } catch (e) {
      dataLoading = false;
      notifyListeners();
      print(e.toString());
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error uploading images')),
      );
    }
  }

  //Image to firebase
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

  //businessUserDetail Method>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  businessUserDetail() async {
    businessUserModel.businessName = businessnameController.text;
    businessUserModel.phoneNumber = businessPhoneNumberController.text;
    businessUserModel.email = businessEmailController.text;
    businessUserModel.website = businessWebsiteController.text;
    businessUserModel.registrationNumber = businessNoController.text;
    businessUserModel.gender = genderCategoryBool;
    businessUserModel.numberOfEmployees = numberOfEmployeesBool;
    businessUserModel.serviceCategory = selectedDropdownItem!.imageName != null
        ? selectedDropdownItem!.imageName!
        : serviceImage[0].imageName;
    businessUserModel.uid = busineesUid;
    businessUserModel.password = businessPasswordController.text;
    businessUserModel.serviceDetails = businessDetailsController.text;
    businessUserModel.image = profileImageUrl;
    businessUserModel.coverImage = coverImageUrl;
    log("in last function business uid ${businessUserModel.uid}");

    await LocalDB.setBusinessUserRecord(
      email: businessUserModel.email!,
      password: businessUserModel.password!,
      uid: busineesUid,
      name: businessUserModel.businessName,
    );
    notifyListeners();
    try {
      // await imageUrlToFirebase();
      await firebase.businessUserToFirebase(businessUserModel);
    } catch (e) {
      dataLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  bool dataLoading = false;
  userAllDataToFirebase() async {
    dataLoading = true;
    notifyListeners();
    try {
      log("1");
      await uploadServiceImage();
      log("2");
      await imageToFirebaseStorage();
      log("3");
      await businessUserDetail();
      log("4");
      dataLoading = false;
      notifyListeners();
    } catch (e) {
      notifyListeners();
      dataLoading = false;
      log(e.toString());
    }
  }
}
