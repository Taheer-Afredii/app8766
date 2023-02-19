import 'dart:developer';

import 'package:app_876/ui/Screens/CustomerSideApp/ServiceSearchScreen/SearviceSearchScreenViewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RatingToBusinessByCustomerViewModel extends ChangeNotifier {
  List<RatingModel> ratingList = [];
  double rating = 0.0;
  double sum = 0.0;

  RatingToBusinessByCustomerViewModel() {
    allFunction();
  }

  allFunction() async {
    await getRiderAverageRating();
  }

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final yesterday = DateTime.now().subtract(Duration(days: 1));

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Yesterday';
    } else {
      final formatter = DateFormat('dd MMMM yyyy');
      return formatter.format(date);
    }
  }

  getRiderAverageRating() async {
    var uid =
        Provider.of<ServiceSearchScreenViewmodel>(Get.context!, listen: false)
            .buid;
    log("buid $uid");

    uid == ""
        ? null
        : await FirebaseFirestore.instance
            .collection('BusinessUsers')
            .doc(uid)
            .snapshots()
            .listen(
            (event) {
              if (event.exists) {
                if (event.data()!['ratingByCustomers'] != null) {
                  sum = 0;
                  rating = 0.0;

                  ratingList.clear();
                  event.data()!['ratingByCustomers'].forEach((element) {
                    ratingList.add(RatingModel.fromFirebase(element));
                  });
                  log("ratingList ${ratingList.length}");

                  ratingList.forEach((element) {
                    sum = sum + element.rating!;
                  });
                  log("sum $sum");
                  rating = sum / ratingList.length;
                  notifyListeners();
                }
              } else {
                log("no data");
              }
            },
          );
  }
}

class RatingModel {
  String? orderId;
  double? rating;
  String? ratingBy;
  String? ratingByName;
  String? review;
  String? date;

  RatingModel({
    this.orderId,
    this.rating,
    this.ratingBy,
    this.ratingByName,
    this.review,
    this.date,
  });

  RatingModel.fromFirebase(firebase) {
    orderId = firebase['orderId'];
    rating = firebase['rating'];
    ratingBy = firebase['ratingBy'];
    ratingByName = firebase['ratingByName'];
    review = firebase['review'];
    date = firebase['date'];
  }
}
