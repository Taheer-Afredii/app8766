import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/CustomWidgets/SearchBarWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/FavoriteScreen/favorite_ViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

TextEditingController favoriteSearchController = TextEditingController();

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FavouriteViewModel model = Provider.of<FavouriteViewModel>(context);
    return ChangeNotifierProvider(
      create: (context) => FavouriteViewModel(),
      child: Consumer<FavouriteViewModel>(builder: ((context, model, child) {
        return Scaffold(
          appBar: GeneralAppBarWidget(title: 'My Favorite Services'),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: model.favouriteList.isEmpty
                ? Center(
                    child: Text("Nothing In favourite"),
                  )
                : Column(
                    children: [
                      SizedBox(height: 20.h),
                      SearchBarWidget(
                        searchController: favoriteSearchController,
                        hintText: 'Events, restaurants, hairstylists',
                      ),
                      SizedBox(height: 20.h),
                      Expanded(
                        child: SafeArea(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("BusinessUsers")
                                  .where("uid", whereIn: model.favouriteList)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.data == null) {
                                  return Center(
                                      child: Text("No Favorite Services"));
                                }
                                return ListView.builder(
                                    padding: EdgeInsets.only(bottom: 40.h),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5.h),
                                        child: FavoriteServiceCardWidget(
                                          name: snapshot.data!.docs[index]
                                              ['businessName'],
                                          serviceIcon: chairIcon,
                                          serviceName: snapshot.data!
                                              .docs[index]['serviceCategory'],
                                          location: snapshot.data!.docs[index]
                                                  ['state'] +
                                              snapshot.data!.docs[index]
                                                  ['country'],
                                          rating: '5.0',
                                          businessUid:
                                              snapshot.data!.docs[index]['uid'],
                                          model: model,
                                        ),
                                      );
                                    });
                              }),
                        ),
                      ),
                      // SizedBox(height: 20.h),
                    ],
                  ),
          ),
        );
      })),
    );
  }
}

class FavoriteServiceCardWidget extends StatelessWidget {
  String name;
  String serviceName;
  String serviceIcon;
  String rating;
  String location;
  String businessUid;
  FavouriteViewModel model;

  FavoriteServiceCardWidget({
    required this.model,
    required this.name,
    required this.rating,
    required this.serviceIcon,
    required this.serviceName,
    required this.location,
    required this.businessUid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 388.w,
      height: 124.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.3),
            spreadRadius: 0.1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30.r,
                child: Image.asset(dummyPersonImage1),
              ),
              SizedBox(width: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  avenir55RomanText(
                    text: name,
                    fontSize: 18.sp,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        serviceIcon,
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(width: 5.w),
                      avenir55RomanText(
                        text: serviceName,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        pinIcon2,
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(width: 5.w),
                      avenir55RomanText(
                        text: location,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        starIcon,
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(width: 5.w),
                      avenir55RomanText(
                        text: rating,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              model.removeFromFavourite(businessUid);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 15.r,
                backgroundColor: whiteColor,
                child: Icon(
                  Icons.favorite,
                  color: redColor,
                  size: 20.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
