import 'package:app_876/Model/business_user_model.dart';
import 'package:app_876/service/firebase/firebase_services.dart';
import 'package:flutter/material.dart';

class BusinessUserDetails extends ChangeNotifier {
  BusinessUserModel businessUser = BusinessUserModel();

  BusinessUserDetails() {
    function();
  }

  function() async {
    await FirebaseServices()
        .businessUserFromFirebase(businessUser)
        .then((value) {
      businessUser = value;
      notifyListeners();
    });
  }
}
