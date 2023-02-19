import 'dart:developer';

import 'package:app_876/Model/CustomerUser/customer_user_model.dart';
import 'package:app_876/service/firebase/Customer/customer_services.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDrawerViewModel extends ChangeNotifier {
  CustomerUserModel customerUserModel = CustomerUserModel();

  UserDrawerViewModel() {
    CustomerFirebaseService()
        .customerFromFirebase(customerUserModel)
        .then((value) {
      customerUserModel = value;
      notifyListeners();
    });
    log("drawer view model");
  }

  //share app function url launcher
  shareApp() async {
    String url =
        "https://play.google.com/store/apps/details?id=com.mxtech.videoplayer.ad&hl=en&gl=US&pli=1";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
