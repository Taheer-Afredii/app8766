import 'package:flutter/material.dart';

class ServiceSearchScreenViewmodel extends ChangeNotifier {
  String buid = "";
  String category = "";
  String name = "";
  String profileImage = "";
  String coverImage = "";
  String longitude = "";
  String latitude = "";

  getBusinessDetails(
      {required String uidValue,
      required String categoryValue,
      required String nameValue,
      required String profileImageValue,
      required String coverImageValue,
      required String longitudeValue,
      required String latitudeValue}) {
    buid = uidValue;
    category = categoryValue;
    name = nameValue;
    profileImage = profileImageValue;
    coverImage = coverImageValue;
    longitude = longitudeValue;
    latitude = latitudeValue;
    notifyListeners();
  }

  //get serviceImage
  String? serviceImage;

  getServiceImage(serviceImageValue) {
    serviceImage = serviceImageValue;
    notifyListeners();
  }
}
