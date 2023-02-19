import 'dart:developer';

import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/customer_sign_up_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/GenderSelectionScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetCustomerLocationViewModel extends ChangeNotifier {
  String country = '';
  String state = '';
  String city = '';
  String street = '';
  String postalCode = '';
  String latitude = '';
  String longitude = '';
  String address = '';
  bool loading = false;

  late Position position;
  late List<Placemark> placemark;

  bool serviceEnabled = false;
  getLocation(BuildContext context) async {
    LocationPermission locationPermission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      log("Location services are not enabled");
      return Future.error('Location services are disabled.');
    }
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    //after getting location permission disable location again

    loading = true;
    notifyListeners();

    // ignore: unused_local_variable
    Position newposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // setState(() {
    position = newposition;
    print("position is $position");
    placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    log("position of latitude and langitude ${position.latitude}, ${position.longitude}");
    Placemark place = placemark[0];
    String completeAddress =
        "${place.street} ${place.thoroughfare} ${place.subLocality} ${place.locality} ${place.subAdministrativeArea} ${place.administrativeArea} ${place.postalCode.toString()} ${place.country}";
    String street = "${place.street} ${place.thoroughfare}";
    String city = "${place.locality}";
    String state = "${place.administrativeArea}";
    String country = "${place.country}";
    String postalCode = place.postalCode.toString();
    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();

    this.street = street;
    this.city = city;
    this.state = state;
    this.country = country;
    this.postalCode = postalCode;
    this.latitude = latitude;
    this.longitude = longitude;
    address = completeAddress;

    // LocalDbServices.setLongAndLat(latitude: latitude, longitude: longitude);

    print(address);
// });
  }

  //stop location permission
  disableLocation() async {
    log("location permission is denied");
    LocationPermission? locationPermission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      LocationPermission.denied;
    }

    //if service is enabled then stop location permission
  }

  CustomerSignUpViewModel signUpModel =
      Provider.of<CustomerSignUpViewModel>(Get.context!);

//customer  location update
  updateLocation({context, gender, phone}) async {
    await signUpModel.customerDataToFirebase(gender: gender, finalphone: phone);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString("cuid");
    await FirebaseFirestore.instance
        .collection("CustomerUsers")
        .doc(uid)
        .update({
      "latitude": latitude,
      "longitude": longitude,
      "street": street,
      "address": address,
      "city": city,
      "country": country
    }).then((value) async {
      signUpModel.image == null;
      signUpModel.emailTextController.clear();
      signUpModel.nameTextController.clear();
      signUpModel.passwordTextController.clear();
      signUpModel.phoneTextController.clear();
    });
    await Get.to(() => GenderSelectionScreen());
    loading = false;
    notifyListeners();
  }
}
