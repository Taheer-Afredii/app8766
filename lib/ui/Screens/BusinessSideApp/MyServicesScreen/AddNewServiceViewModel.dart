import 'package:app_876/Model/business_user_addservice_model.dart';
import 'package:app_876/service/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewServiceViewModelDrawer extends ChangeNotifier {
  FirebaseServices firebaseServices = FirebaseServices();
  BusinessUserAddserviceModel businessAddServiceModel =
      BusinessUserAddserviceModel();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceTimeController = TextEditingController();
  TextEditingController servicePriceController = TextEditingController();
  TextEditingController serviceDiscountController = TextEditingController();
  bool isChecked = false;
  bool isChecked2 = false;
  bool loading = false;

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

    loading = true;
    notifyListeners();

    await firebaseServices
        .businessUserAddserviceToFirebase(businessAddServiceModel);
    //snackbar
    Get.snackbar(
      "Service Added",
      "Service Added Successfully",
    );
    serviceNameController.clear();
    serviceTimeController.clear();
    servicePriceController.clear();

    loading = false;
    notifyListeners();
  }

  //edit service >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.>>>>>>>>
  bool editLoading = false;
  editService({docid}) async {
    editLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('buid');
    await FirebaseFirestore.instance
        .collection("BusinessUsers")
        .doc(uid)
        .collection("addService")
        .doc(docid)
        .update({
      "serviceName": serviceNameController.text.trim(),
      "serviceTime": serviceTimeController.text.trim(),
      "servicePrice": servicePriceController.text.trim(),
    });

    editLoading = false;

    notifyListeners();
    serviceNameController.clear();
    serviceTimeController.clear();
    servicePriceController.clear();
  }
}
