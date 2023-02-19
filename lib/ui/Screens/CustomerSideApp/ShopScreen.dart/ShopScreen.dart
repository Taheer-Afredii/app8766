import 'dart:developer';
import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ConfirmAppointmentScreen/ConfirmAppointmentScreen.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ServiceScreen.dart/ServiceScreenModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ServiceSearchScreen/SearviceSearchScreenViewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ConfirmAppointmentScreen/confirmAppointmentViewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ShopScreen.dart/shopScreenViewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ShopScreen.dart/shop_screen_ServiceRating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  @override
  State<ShopScreen> createState() => _ShopScreen();
}

// bool isChecked = false;

class _ShopScreen extends State<ShopScreen> {
  disbleLocationServices() async {}

  @override
  void initState() {
    super.initState();
    disbleLocationServices();
  }

  @override
  Widget build(BuildContext context) {
    ServiceSearchScreenViewmodel searchModel =
        Provider.of<ServiceSearchScreenViewmodel>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            ShopScreenAppBarWidget(),
            SizedBox(height: 80.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  avenir55RomanText(
                    text: '${searchModel.name} ' +
                        '${searchModel.category}' '\'s Shop',
                    fontSize: 23.sp,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 50.h,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: ShopTabBarButtonWidget(),
              ),
            ),
            Expanded(
              flex: 9,
              child: TabBarView(
                children: [
                  ServicesTabViewScreen(uid: searchModel.buid),
                  RatingsTabViewScreen(),
                  AboutTabViewScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//
//
//ScreenSpecificWidgets
//
//

//>>>>>>>>>>>>>>>>>>>>>//

//>>>>>>>>>>>>>>>>>>>>>//

class ShopScreenAppBarWidget extends StatefulWidget {
  @override
  State<ShopScreenAppBarWidget> createState() => _ShopScreenAppBarWidgetState();
}

class _ShopScreenAppBarWidgetState extends State<ShopScreenAppBarWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var searchModel = Provider.of<ServiceSearchScreenViewmodel>(context);
    ShopScreenViewModel shopModel = Provider.of<ShopScreenViewModel>(context);
    return SizedBox(
      width: 1.sw,
      height: 220.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 1.sw,
            height: 230.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
              image: DecorationImage(
                image: AssetImage(
                  servicesList[0].coverImage,
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: whiteColor,
                        child: Icon(
                          Icons.arrow_back,
                          color: blackColor,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: shopModel.favouriteList.contains(searchModel.buid)
                          ? () async {
                              shopModel.removefromFavourite(searchModel.buid);
                            }
                          : () async {
                              shopModel.addToFavourite(searchModel.buid);
                            },
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: whiteColor,
                        child: Icon(
                          shopModel.favouriteList.contains(searchModel.buid)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: blackColor,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50.h,
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 140.w,
                height: 140.h,
                padding: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                  image: searchModel.profileImage != ""
                      ? DecorationImage(
                          image: NetworkImage(searchModel.profileImage),
                          fit: BoxFit.fitWidth)
                      : DecorationImage(
                          image: AssetImage(dummyPersonImage1),
                        ),
                  color: whiteColor,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    //TODO: Put condition here according to condition of premium
                    Positioned(
                      bottom: -15.h,
                      child: Image.asset(
                        premiumIcon,
                        width: 40.w,
                        height: 40.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//>>>>>>>>>>>>>>>>>>>>>//

class ServicesTabViewScreen extends StatefulWidget {
  String uid;
  ServicesTabViewScreen({required this.uid});

  @override
  State<ServicesTabViewScreen> createState() => _ServicesTabViewScreenState();
}

class _ServicesTabViewScreenState extends State<ServicesTabViewScreen> {
  List selectedServicesLocal = [];
  List selectedServices = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getService();
  }

  getService() async {
    setState(() {
      loading = true;
    });

    await FirebaseFirestore.instance
        .collection('BusinessUsers')
        .doc(widget.uid)
        .collection('addService')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          selectedServices.add(element.data());
        });
      });
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ShopScreenViewModel shopScreen = Provider.of<ShopScreenViewModel>(context);
    ConfirmAppointmentViewModel model =
        Provider.of<ConfirmAppointmentViewModel>(context);
    return loading
        ? kCircularProgress()
        : SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15.h),
                avenir55RomanText(
                  text: 'Select Services & Get 10% off for first appointment',
                  color: blackColor.withOpacity(0.5),
                  fontSize: 14.sp,
                ),
                SizedBox(height: 15.h),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: selectedServices.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Container(
                        width: 388.w,
                        height: 70.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: lightGreyColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200.w,
                                  child: avenir55RomanText(
                                    text: selectedServices[index]
                                        ['serviceName'],
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                avenir55RomanText(
                                  text:
                                      "${selectedServices[index]['serviceTime']} min",
                                  fontSize: 12.sp,
                                ),
                              ],
                            ),
                            avenir55RomanText(
                                text:
                                    '\$${selectedServices[index]["servicePrice"]}',
                                fontSize: 18.sp),
                            Checkbox(
                              value: selectedServicesLocal
                                  .contains(selectedServices[index]),
                              shape: CircleBorder(),
                              fillColor: MaterialStateProperty.all(blackColor),
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    selectedServicesLocal
                                        .add(selectedServices[index]);
                                  } else {
                                    selectedServicesLocal
                                        .remove(selectedServices[index]);
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.h),
                loading
                    ? kCircularProgress()
                    : GestureDetector(
                        onTap: () async {
                          model.totalAmount = 0;
                          setState(() {
                            loading = true;
                          });
                          if (selectedServicesLocal.isNotEmpty) {
                            for (int i = 0;
                                i < selectedServicesLocal.length;
                                i++) {
                              model.totalAmount = model.totalAmount +
                                  double.parse(
                                      selectedServicesLocal[i]['servicePrice']);
                            }
                            log("model.totalAmount ${model.totalAmount}");
                            // await shopScreen.addSelectedServices(servicelocalList);
                            await Get.to(() => ConfirmAppointmentScreen(
                                  buid: widget.uid,
                                  selectedServices: selectedServicesLocal,
                                  totAmount: model.totalAmount,
                                  serviceName: selectedServices[0]
                                      ['serviceName'],
                                ));
                            setState(() {
                              loading = false;
                            });
                          } else {
                            setState(() {
                              loading = false;
                            });
                            Get.snackbar(
                                'Error', 'Please select at least one service',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: whiteColor);
                          }
                        },
                        child: CustomGloballyUsedButtonWidget(
                            centerTitle: 'CONTINUE')),
                SizedBox(height: 50.h),
              ],
            ),
          );
  }
}

//>>>>>>>>>>>>>>>>>>>>>//

// class OfferedServicesCardWidget extends StatefulWidget {
//   String docId;
//   int index;
//   List<QueryDocumentSnapshot> service;

//   OfferedServicesCardWidget({
//     super.key,
//     required this.service,
//     required this.docId,
//     required this.index,
//   });

//   @override
//   State<OfferedServicesCardWidget> createState() =>
//       _OfferedServicesCardWidgetState();
// }

// class _OfferedServicesCardWidgetState extends State<OfferedServicesCardWidget> {
//   bool serviceCheckBoxBool = false;

//   @override
//   Widget build(BuildContext context) {
//     ShopScreenViewModel shopModel = Provider.of<ShopScreenViewModel>(context);
//     ConfirmAppointmentViewModel model =
//         Provider.of<ConfirmAppointmentViewModel>(context);
//     return Container(
//       width: 388.w,
//       height: 70.h,
//       padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.r),
//         color: lightGreyColor,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: 200.w,
//                 child: avenir55RomanText(
//                   text: widget.service[widget.index]['serviceName'],
//                   fontSize: 18.sp,
//                 ),
//               ),
//               SizedBox(height: 5.h),
//               avenir55RomanText(
//                 text: "${widget.service[widget.index]['serviceTime']} min",
//                 fontSize: 12.sp,
//               ),
//             ],
//           ),
//           avenir55RomanText(
//               text: '\$${widget.service[widget.index]["servicePrice"]}',
//               fontSize: 18.sp),
//           Checkbox(
//             value: serviceLocalList.contains(widget.service[widget.index]),
//             shape: CircleBorder(),
//             fillColor: MaterialStateProperty.all(blackColor),
//             onChanged: (value) {
//               if (serviceLocalList.contains(widget.service[widget.index])) {
//                 log("remove");
//                 serviceLocalList.remove(widget.service[widget.index]);
//               } else {
//                 serviceLocalList.add(widget.service[widget.index]);
//                 log("add");
//               }
//               setState(() {});
//               log("shopModel.serviceLocalList ${serviceLocalList}");
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

//>>>>>>>>>>>>>>>>>>>>>//

class RatingsTabViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RatingToBusinessByCustomerViewModel(),
      child: Consumer<RatingToBusinessByCustomerViewModel>(
          builder: (context, model, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    avenir55RomanText(
                      text: 'Reviews & Ratings',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_purple500_sharp,
                          color: yelloColor,
                        ),
                        avenir55RomanText(
                          text:
                              '${model.rating.toStringAsFixed(1)} (${model.ratingList.length}) ',
                          fontSize: 18.sp,
                        ),
                      ],
                    )
                  ],
                ),
                Divider(color: blackColor),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: model.ratingList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ReviewAndRatingsCardWidget(
                      name: model.ratingList[index].ratingByName!,
                      rating: model.ratingList[index].rating!,
                      //show date time in yesterday function
                      timeAgo: model.formatDate(
                          DateTime.parse(model.ratingList[index].date!)),

                      reviewComments: model.ratingList[index].review!,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

//>>>>>>>>>>>>>>>>>>>>>//

class ReviewAndRatingsCardWidget extends StatelessWidget {
  final String name;
  final double rating;
  final String timeAgo;
  final String reviewComments;

  ReviewAndRatingsCardWidget({
    required this.name,
    required this.rating,
    required this.reviewComments,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 488.w,
      height: 120.h,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                child: Image.asset(dummyPersonImage1),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  avenir55RomanText(text: name),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBarIndicator(
                        rating: rating,
                        itemCount: 5,
                        itemSize: 24.sp,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      avenir55RomanText(
                        text: '$rating',
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              avenir55RomanText(text: timeAgo)
            ],
          ),
          SizedBox(height: 5.h),
          SizedBox(
            width: 1.sw,
            child: avenir55RomanText(
              text: reviewComments,
              maxLines: 3,
            ),
          ),
          SizedBox(height: 10.h),
          Divider(
            color: blackColor,
            indent: 50.w,
            endIndent: 50.w,
          ),
        ],
      ),
    );
  }
}

//>>>>>>>>>>>>>>>>>>>>>//

class AboutTabViewScreen extends StatelessWidget {
  final List<String> listOfStartingTime = [
    '10:30',
    '10:30',
    '10:30',
    '10:30',
    '10:30',
    '10:30',
    '10:30',
  ];
  final List<String> listOfEndingTime = [
    '6:30',
    '6:30',
    '6:30',
    '6:30',
    '6:30',
    '6:30',
    '6:30',
  ];

  @override
  Widget build(BuildContext context) {
    ServiceSearchScreenViewmodel searchModel =
        Provider.of<ServiceSearchScreenViewmodel>(context);
    ShopScreenViewModel shopModel = Provider.of<ShopScreenViewModel>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("BusinessUsers")
              .doc(searchModel.buid)
              .get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading...'));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: kCircularProgress());
            }
            return Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    avenir55RomanText(
                      text: '19 ST mile Tread, willow brook',
                      fontSize: 18.sp,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await shopModel.mapLaunch(snapshot.data!['latitude'],
                            snapshot.data!['longitude']);
                      },
                      child: Image.asset(
                        pinLocationIcon,
                        width: 30.w,
                        height: 30.h,
                      ),
                    ),
                  ],
                ),
                Divider(color: blackColor),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () async {
                    await shopModel.phoneLaunch(snapshot.data!['phoneNumber']);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      avenir55RomanText(
                        text: 'Call us for info',
                        fontSize: 18.sp,
                      ),
                      Image.asset(
                        contactUsLogo,
                        width: 30.w,
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
                Divider(color: blackColor),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () async {
                    await shopModel.launchWeb();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      avenir55RomanText(
                        text: snapshot.data!['website'],
                        fontSize: 18.sp,
                      ),
                      Image.asset(
                        globeIcon,
                        width: 30.w,
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
                Divider(color: blackColor),
                SizedBox(height: 10.h),
                avenir55RomanText(
                  text: snapshot.data!['serviceDetails'],
                  maxLines: 5,
                  fontSize: 16.sp,
                ),
                SizedBox(height: 10.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    avenir55RomanText(
                      text: 'Weekly Duties hours',
                      color: blackColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: shopModel.workRoutineList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return WeeklyDutyHoursCardWidget(
                          day: shopModel.workRoutineList[index]['day'],
                          startingTime: shopModel.workRoutineList[index]
                              ['starting_time'],
                          endingTime: shopModel.workRoutineList[index]
                              ['ending_time'],
                          isClosed: shopModel.workRoutineList[index]
                              ['is_closed'],
                        );
                      },
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}

class WeeklyDutyHoursCardWidget extends StatelessWidget {
  final String startingTime;
  final String endingTime;
  final bool isClosed;
  final String day;

  WeeklyDutyHoursCardWidget({
    required this.day,
    required this.endingTime,
    required this.isClosed,
    required this.startingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.circle,
              color: greenColor,
              size: 10.sp,
            ),
            SizedBox(width: 10.w),
            avenir55RomanText(
              text: day,
              fontSize: 18.sp,
            ),
          ],
        ),
        avenir55RomanText(
          text: isClosed ? 'Closed' : '$startingTime - $endingTime',
          color: isClosed ? redColor : blackColor,
        ),
      ],
    );
  }
}

class ShopTabBarButtonWidget extends StatelessWidget {
  const ShopTabBarButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelStyle: avenir55RomanStyle(fontSize: 18.sp),
      indicator: UnderlineTabIndicator(
        insets: EdgeInsets.symmetric(horizontal: 15.w),
        borderSide: BorderSide(
          color: greenColor,
          width: 2.w,
        ),
      ),
      labelColor: greenColor,
      unselectedLabelColor: Colors.black.withOpacity(0.5),
      padding: EdgeInsets.all(8.r),
      tabs: [
        Tab(
          height: 30.h,
          text: "Services",
        ),
        Tab(
          height: 30.h,
          text: "Ratings",
        ),
        Tab(
          height: 30.h,
          text: "About",
        ),
      ],
    );
  }
}
