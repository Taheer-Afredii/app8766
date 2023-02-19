import 'dart:developer';

import 'package:app_876/Model/business_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteViewModel extends ChangeNotifier {
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  List favouriteList = [];
  List<BusinessUserModel> favouriteBusinessList = [];

  FavouriteViewModel() {
    log("favouriteList $favouriteList");
    getCustomerFavouriteList();

    print("favouriteList $favouriteList");
  }

  getCustomerFavouriteList() async {
    favouriteBusinessList.clear();
    favouriteList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cuid = prefs.getString('cuid');
    log("cuid $cuid");
    await firebase.collection("CustomerUsers").doc(cuid).get().then((value) {
      if (value.exists) {
        favouriteList = value.data()!['favorite'];
        notifyListeners();
      }
    });
    log("favouriteList $favouriteList");
    await getFavouriteBusinees();
  }

  //get favourite business in streamBuilder
  getFavouriteBusinessStreamBuilder() {
    final Stream<QuerySnapshot> snapshots = firebase
        .collection("BusinessUsers")
        .where("uid", whereIn: favouriteList)
        .snapshots();

    snapshots.listen((event) {
      //if waiting for data show circular progress indicator

      if (event.docs.isNotEmpty) {
        for (int i = 0; i < event.docs.length; i++) {
          favouriteBusinessList
              .add(BusinessUserModel.Fromfirebase(firebase: event.docs[i]));
        }
        notifyListeners();
      }
    });
  }

  getFavouriteBusinees() async {
    if (favouriteList.isNotEmpty) {
      await firebase
          .collection("BusinessUsers")
          .where("uid", whereIn: favouriteList)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          for (int i = 0; i < value.docs.length; i++) {
            favouriteBusinessList
                .add(BusinessUserModel.Fromfirebase(firebase: value.docs[i]));
          }
          notifyListeners();
        }
      });
    }
    log("favouriteBusinessList $favouriteBusinessList");
  }

  //remove From Favourite
  removeFromFavourite(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cuid = prefs.getString('cuid');
    await firebase.collection("CustomerUsers").doc(cuid).update({
      "favorite": FieldValue.arrayRemove([uid])
    }).then((value) {
      getCustomerFavouriteList();
    });
  }
}
