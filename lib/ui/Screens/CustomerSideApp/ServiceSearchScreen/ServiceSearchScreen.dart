import 'package:app_876/Model/business_user_model.dart';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/GlobalBackButtonWidget.dart';
import 'package:app_876/ui/CustomWidgets/SearchBarWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/HomeScreen/mapScreenViewModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ServiceSearchScreen/SearviceSearchScreenViewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ShopScreen.dart/ShopScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

TextEditingController serviceSearchController = TextEditingController();

class ServiceSearchScreen extends StatelessWidget {
  String category;
  ServiceSearchScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer<MapScreenViewModel>(builder: (context, model, child) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                GlobalBackButtonWidget(backButtonColor: blackColor),
                SizedBox(height: 10.h),
                Center(
                  child: SearchBarWidget(
                    searchController: serviceSearchController,
                    hintText: "Events, restaurants, hairstylists",
                    onChanged: (value) {
                      model.onSearch(value);
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                avenir55RomanText(
                  text: category,
                  fontSize: 23,
                ),
                SizedBox(height: 10.h),
                Consumer<ServiceSearchScreenViewmodel>(
                    builder: (context, serviceSearchModel, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: model.businessUser.length,
                      itemBuilder: (context, index) {
                        if (model.search.isEmpty) {
                          return GestureDetector(
                            onTap: () {
                              serviceSearchModel.getBusinessDetails(
                                longitudeValue: model
                                    .businessUser[index].longitude
                                    .toString(),
                                latitudeValue: model
                                    .businessUser[index].latitude
                                    .toString(),
                                uidValue:
                                    model.businessUser[index].uid.toString(),
                                categoryValue: model
                                    .businessUser[index].serviceCategory
                                    .toString(),
                                nameValue: model
                                    .businessUser[index].businessName
                                    .toString(),
                                profileImageValue:
                                    model.businessUser[index].image!,
                                coverImageValue: model
                                    .businessUser[index].coverImage!
                                    .toString(),
                              );
                              Get.to(
                                () => ShopScreen(),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: ShopCardWidget(
                                serviceList: model.businessUser[index],
                                distance: model.nearByBusiness[index],
                              ),
                            ),
                          );
                        } else if (model.businessUser[index].businessName
                            .toString()
                            .toLowerCase()
                            .startsWith(model.search.toLowerCase())) {
                          return GestureDetector(
                            onTap: () {
                              serviceSearchModel.getBusinessDetails(
                                longitudeValue: model
                                    .businessUser[index].longitude
                                    .toString(),
                                latitudeValue: model
                                    .businessUser[index].latitude
                                    .toString(),
                                uidValue:
                                    model.businessUser[index].uid.toString(),
                                categoryValue: model
                                    .businessUser[index].serviceCategory
                                    .toString(),
                                nameValue: model
                                    .businessUser[index].businessName
                                    .toString(),
                                profileImageValue:
                                    model.businessUser[index].image!,
                                coverImageValue: model
                                    .businessUser[index].coverImage!
                                    .toString(),
                              );

                              Get.to(
                                () => ShopScreen(),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: ShopCardWidget(
                                serviceList: model.businessUser[index],
                                distance: model.nearByBusiness[index],
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      );
    });
  }
}

class ShopCardWidget extends StatelessWidget {
  final BusinessUserModel serviceList;
  double distance = 0.0;

  ShopCardWidget({required this.serviceList, required this.distance});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(17.r),
        boxShadow: [
          BoxShadow(
            color: greyColor,
            spreadRadius: 0.1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 30.r,
          backgroundImage: NetworkImage(serviceList.image!),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: avenir55RomanText(
            text: "${serviceList.businessName}",
            fontSize: 17.sp,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avenir55RomanText(
              text: "${serviceList.serviceCategory}",
              fontSize: 12.sp,
            ),
            Row(
              children: [
                Icon(Icons.pin_drop),
                Container(
                  child: avenir55RomanText(
                    text: "19 ST mile Tread, willow brook",
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: yelloColor,
                ),
                SizedBox(width: 5.w),
                avenir55RomanText(
                  text: "(4.5)",
                  fontSize: 12.sp,
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          alignment: Alignment.topCenter,
          width: 95.w,
          child: Row(
            children: [
              Image.asset(
                sendMessageFlyIcon,
                width: 40.w,
                height: 40.h,
              ),
              avenir55RomanText(
                text: "${distance.toStringAsFixed(2)} km",
                fontSize: 14.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
