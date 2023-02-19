import 'package:app_876/Model/business_user_model.dart';
import 'package:app_876/service/firebase/firebase_services.dart';
import 'package:flutter/material.dart';

class BusinessProfileViewModel extends ChangeNotifier {
  BusinessUserModel businessUser = BusinessUserModel();

  BusinessProfileViewModel() {
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
}
