import 'package:cloud_firestore/cloud_firestore.dart';

class SelectedServiceModel {
  String? businessuid;
  List? Services;
  Timestamp? date;
  String? day;
  bool? mobilePay;
  String? month;
  String? year;
  bool? payonSite;
  String? status;
  String? stripeid;
  String? time;
  String? timeSlot;
  double? totalAmount;
  String? userName;
  String? userPic;
  String? address;
  String? latitude;
  String? longitude;
  String? docId;
  String? customeruid;
  bool? arrived;
  bool? completed;
  String? businessLongitude;
  String? businessLatitude;
  String? businessName;
  String? businessProfileImage;

  SelectedServiceModel({
    this.businessuid,
    this.Services,
    this.date,
    this.day,
    this.mobilePay,
    this.month,
    this.year,
    this.payonSite,
    this.status,
    this.stripeid,
    this.time,
    this.timeSlot,
    this.totalAmount,
    this.userName,
    this.userPic,
    this.address,
    this.latitude,
    this.longitude,
    this.docId,
    this.customeruid,
    this.arrived,
    this.completed,
    this.businessLongitude,
    this.businessLatitude,
    this.businessName,
    this.businessProfileImage,
  });

  SelectedServiceModel.fromFirebase({firebase}) {
    businessuid = firebase['businessuid'];
    Services = firebase['Services'];
    date = firebase['date'];
    day = firebase['day'];
    mobilePay = firebase['mobilePay'];
    month = firebase['month'];
    year = firebase['year'];
    payonSite = firebase['payonSite'];
    status = firebase['status'];
    stripeid = firebase['stripeid'];
    time = firebase['time'];
    timeSlot = firebase['timeSlot'];
    totalAmount = firebase['totalAmount'];
    userName = firebase['userName'];
    userPic = firebase['userPic'];
    address = firebase['address'];
    latitude = firebase['latitude'];
    longitude = firebase['longitude'];
    docId = firebase['docId'];
    customeruid = firebase['custimeruid'];
    arrived = firebase['arrived'];
    completed = firebase['completed'];
    businessLongitude = firebase['businessLongitude'];
    businessLatitude = firebase['businessLatitude'];
    businessName = firebase['businessName'];
    businessProfileImage = firebase['businessProfileImage'];
  }
}
