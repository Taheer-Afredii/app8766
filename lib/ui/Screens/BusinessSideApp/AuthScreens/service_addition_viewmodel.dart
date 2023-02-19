import 'package:app_876/Model/business_user_addservice_model.dart';
import 'package:app_876/service/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceAdditionViewModel extends ChangeNotifier {
  FirebaseServices firebaseServices = FirebaseServices();
  BusinessUserAddserviceModel businessAddServiceModel =
      BusinessUserAddserviceModel();

  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceTimeController = TextEditingController();
  TextEditingController servicePriceController = TextEditingController();
  TextEditingController serviceDiscountController = TextEditingController();
  bool isChecked = false;
  bool isChecked2 = false;
  bool isLoading = false;

  paidAfterService(value) {
    isChecked = value;
    notifyListeners();
  }

  paidInAdvance(value) {
    isChecked2 = value;
    notifyListeners();
  }

  // addServiceData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var uid = prefs.getString('buid');
  //   await FirebaseFirestore.instance
  //       .collection("BusinessUsers")
  //       .doc(uid)
  //       .collection("addservice")
  //       .add({
  //     "serviceName": serviceNameController.text.trim(),
  //     "serviceTime": serviceTimeController.text.trim(),
  //     "servicePrice": servicePriceController.text.trim(),
  //     "serviceDescount": serviceDiscountController.text.trim(),
  //     "getPaidAfter": isChecked,
  //     "gePaidInAdvance": isChecked2,
  //     "date": DateTime.now(),
  //     "day": DateTime.now().day,
  //     "month": DateTime.now().month,
  //     "year": DateTime.now().year,
  //   }).then((value) {
  //     //add doc id
  //     FirebaseFirestore.instance
  //         .collection("BusinessUsers")
  //         .doc(uid)
  //         .collection("addservice")
  //         .doc(value.id)
  //         .update({
  //       "docId": value.id,
  //     });
  //   });
  // }

  addService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('buid');
    businessAddServiceModel.serviceName = serviceNameController.text.trim();
    businessAddServiceModel.serviceTime = serviceTimeController.text.trim();
    businessAddServiceModel.servicePrice = servicePriceController.text.trim();
    businessAddServiceModel.serviceDescount =
        serviceDiscountController.text.trim();
    businessAddServiceModel.getPaidAfter = isChecked;
    businessAddServiceModel.gePaidInAdvance = isChecked2;
    businessAddServiceModel.uid = uid;
    notifyListeners();

    isLoading = true;
    notifyListeners();

    await firebaseServices
        .businessUserAddserviceToFirebase(businessAddServiceModel);
    //snackbar
    Get.snackbar(
      "Service Added",
      "Service Added Successfully",
    );
    isLoading = false;
    notifyListeners();
  }
}
