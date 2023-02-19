import 'package:app_876/Model/CustomerUser/customer_user_model.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/service/firebase/Customer/customer_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreenViewModel extends ChangeNotifier {
  String? customerImage;
  CustomerUserModel user = CustomerUserModel();

  HomeScreenViewModel() {
    CustomerFirebaseService().customerFromFirebase(user).then((value) {
      user = value;
      notifyListeners();
    });
  }

  Future<void> _uploadImages(context) async {
    final storage = FirebaseStorage.instance;
    final db = FirebaseFirestore.instance;

    try {
      for (var asset in serviceImage) {
        final name = asset.imageName;
        final path = asset.image;
        final ref = storage.ref().child('images/$name');
        final byteData = await rootBundle.load(path.toString());
        final imageData = byteData.buffer.asUint8List();
        await ref.putData(imageData);

        final url = await ref.getDownloadURL();
        await db.collection('images').doc(name).set({'name': name, 'url': url});
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Images uploaded successfully!')),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading images')),
      );
    }
  }

  //dispose will be called automatically

}

List<String> serviceImages = [
  serviceListImage1,
  serviceListImage2,
  serviceListImage3,
  serviceListImage4,
  serviceListImage5,
  serviceListImage6,
  serviceListImage7,
  serviceListImage8,
  serviceListImage9,
  serviceListImage10,
  serviceListImage11,
  serviceListImage12,
  serviceListImage13,
  serviceListImage14,
  serviceListImage15,
  serviceListImage16,
  serviceListImage17,
  serviceListImage18,
  // serviceListImage19,
  // serviceListImage20,
  // serviceListImage21,
];

final List<String> serviceTitles = [
  'Adult Bars Entertainment',
  'Architect',
  'Barbers',
  'Auto Mechanic',
  'Beautician',
  'Construction',
  'Boutiques',
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

class ServiceImages {
  String? image;
  String? imageName;

  ServiceImages({this.image, this.imageName});
}

List<ServiceImages> serviceImage = [
  ServiceImages(
      image: serviceListImage1, imageName: 'Adult Bars Entertainment'),
  ServiceImages(
    image: serviceListImage2,
    imageName: 'Architect',
  ),
  ServiceImages(
    image: serviceListImage3,
    imageName: 'Barbers',
  ),
  ServiceImages(
    image: serviceListImage4,
    imageName: 'Auto Mechanic',
  ),
  ServiceImages(
    image: serviceListImage5,
    imageName: 'Beautician',
  ),
  ServiceImages(
    image: serviceListImage6,
    imageName: 'Construction',
  ),
  ServiceImages(
    image: serviceListImage7,
    imageName: 'Boutiques',
  ),
  ServiceImages(
    image: serviceListImage8,
    imageName: 'Dentist',
  ),
  ServiceImages(
    image: serviceListImage9,
    imageName: 'Designer Stylist',
  ),
  ServiceImages(
    image: serviceListImage10,
    imageName: 'Doctors',
  ),
  ServiceImages(
    image: serviceListImage11,
    imageName: 'Gym',
  ),
  ServiceImages(
    image: serviceListImage12,
    imageName: 'Hair Stylist',
  ),
  ServiceImages(
    image: serviceListImage13,
    imageName: 'Hardware',
  ),
  ServiceImages(
    image: serviceListImage14,
    imageName: 'Hotels',
  ),
  ServiceImages(
    image: serviceListImage15,
    imageName: 'Message Therapist',
  ),
  ServiceImages(
    image: serviceListImage16,
    imageName: 'Night Club',
  ),
  ServiceImages(
    image: serviceListImage17,
    imageName: 'Personal Trainer',
  ),
  ServiceImages(image: serviceListImage18, imageName: 'Realtors'),
  ServiceImages(image: serviceListImage19, imageName: '19'),
  ServiceImages(image: serviceListImage20, imageName: '20'),
  ServiceImages(image: serviceListImage21, imageName: '21'),
];
