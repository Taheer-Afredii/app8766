import 'dart:async';
import 'dart:developer';

import 'package:app_876/Model/business_user_model.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/HomeScreen/mapScreenViewModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ServiceSearchScreen/SearviceSearchScreenViewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ShopScreen.dart/ShopScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ServiceSearchScreen/ServiceSearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/assets.dart';

class ServicesMapScreen extends StatefulWidget {
  String? serviceTitle;
  String? latitude;
  String? longitude;
  ServicesMapScreen({this.serviceTitle, this.latitude, this.longitude});

  @override
  State<ServicesMapScreen> createState() => _ServicesMapScreenState();
}

class _ServicesMapScreenState extends State<ServicesMapScreen> {
  final TextEditingController serviceListScreenSearchController =
      TextEditingController();

  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vieModelFunction();
    });

    super.initState();
  }

  vieModelFunction() {
    Provider.of<MapScreenViewModel>(context, listen: false)
        .getAllFunctions(serviceCategory: widget.serviceTitle!);
  }

  updatelocation({lat, long}) {
    _controller.future.then((value) {
      log("enter in update location");
      value.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
                double.parse(lat.toString()), double.parse(long.toString())),
            zoom: 12,
          ),
        ),
      );
      log("exit from update location");
    });
  }
  // stop location permission

  @override
  Widget build(BuildContext context) {
    return Consumer<MapScreenViewModel>(builder: (context, model, child) {
      ServiceSearchScreenViewmodel serviceSearchModel =
          Provider.of<ServiceSearchScreenViewmodel>(context, listen: false);
      return Scaffold(
        body: model.isMapLoading
            ? kCircularProgress()
            : Stack(
                children: [
                  GoogleMap(
                      padding: EdgeInsets.only(top: 500.h),
                      mapType: MapType.normal,
                      buildingsEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              double.parse(widget.latitude.toString()),
                              double.parse(widget.longitude.toString())),
                          zoom: 12),
                      markers: model.markers,
                      onMapCreated: (GoogleMapController controller) {
                        if (!_controller.isCompleted) {
                          _controller.complete(controller);
                        }
                      }),
                  Container(
                    width: 428.w,
                    height: 280.h,
                    decoration: BoxDecoration(
                      color: darkGreyColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r),
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 26.sp,
                                color: whiteColor,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ServiceSearchScreen(
                                      category: widget.serviceTitle!,
                                    ));
                              },
                              child: Center(
                                child: Image.asset(dummySearchFieldImage),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            avenir55RomanText(
                              text: "Category",
                              fontSize: 13,
                              color: whiteColor,
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: 60.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: serviceImages.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            updatelocation(
                                              lat: double.parse(
                                                  model.latitude.toString()),
                                              long: double.parse(
                                                  model.longitude.toString()),
                                            );
                                            await model
                                                .getBusinessUserByCategory(
                                                    serviceTitles[index]);
                                            setState(() {
                                              widget.serviceTitle =
                                                  serviceTitles[index];
                                            });

                                            log("serviceTitle in tap: ${widget.serviceTitle}");
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 12.w),
                                            child: Image.asset(
                                              serviceImages[index],
                                              scale: 3.5,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
        bottomSheet: SizedBox(
          height: 250.h,
          width: 1.sw,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: model.businessUser.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Get.to(
                  //   ShopScreen(
                  //     singleService: model.categoryList,
                  //   ),
                  // );
                },
                child: GestureDetector(
                  onTap: () async {
                    await serviceSearchModel.getBusinessDetails(
                      longitudeValue:
                          model.businessUser[index].longitude.toString(),
                      latitudeValue:
                          model.businessUser[index].latitude.toString(),
                      uidValue: model.businessUser[index].uid.toString(),
                      categoryValue:
                          model.businessUser[index].serviceCategory.toString(),
                      nameValue:
                          model.businessUser[index].businessName.toString(),
                      profileImageValue: model.businessUser[index].image!,
                      coverImageValue: "",
                    );
                    await Get.to(ShopScreen());
                  },
                  child: BottomServiceListWidget(
                    data: model.businessUser[index],
                    model: model,
                    distance: model.nearByBusiness[index],
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

class BottomServiceListWidget extends StatelessWidget {
  BusinessUserModel data;
  MapScreenViewModel model;
  double distance = 0.0;

  BottomServiceListWidget(
      {required this.data, required this.model, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: SizedBox(
        width: 300.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 115.h,
              child: Row(
                children: [
                  Container(
                    height: 114.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),
                      image: DecorationImage(
                        image: NetworkImage(data.image.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.all(5.sp),
                        height: 30.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r),
                          ),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: yelloColor,
                                size: 20.sp,
                              ),
                              avenir55RomanText(
                                text: "4.5",
                                fontSize: 12.sp,
                              )
                            ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    avenir55RomanText(
                      text: data.businessName.toString(),
                      fontSize: 14,
                    ),
                    avenir55RomanText(
                      text: data.serviceCategory.toString(),
                      fontSize: 12,
                    ),
                  ],
                ),
                Image.asset(
                  sendMessageFlyIcon,
                  scale: 3.5,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                avenir55RomanText(
                  text: "${data.state}" + " ${data.city}" + " ${data.country}",
                  fontSize: 12.sp,
                ),
                avenir55RomanText(
                  //round to 2 decimal places
                  text: "${distance.toStringAsFixed(2)} KM",
                  fontSize: 12.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
