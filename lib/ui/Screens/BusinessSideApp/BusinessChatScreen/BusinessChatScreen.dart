import 'dart:developer';

import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/core/extensions/string_extension.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessChatScreen/ChatScreenViewModel.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BusinessChatScreen extends StatelessWidget {
  String name;
  String businessId;
  String customerId;
  String startlatituide;
  String startlongitude;
  String endlatitude;
  String endlongitude;
  String image;
  BusinessChatScreen(
      {super.key,
      required this.businessId,
      required this.customerId,
      required this.name,
      required this.image,
      required this.startlatituide,
      required this.startlongitude,
      required this.endlatitude,
      required this.endlongitude});
  TextEditingController chatController = TextEditingController();

  BubbleStyle styleSomebody = BubbleStyle(
    color: Colors.grey.shade200,
    padding: BubbleEdges.all(10),
    radius: Radius.circular(20.r),
    nip: BubbleNip.leftTop,
    margin: BubbleEdges.only(
      top: 10.h,
      right: 100.w,
    ),
    alignment: Alignment.topLeft,
  );

  BubbleStyle styleMe = BubbleStyle(
    color: greenColor,
    padding: BubbleEdges.all(10),
    radius: Radius.circular(20.r),
    nip: BubbleNip.rightTop,
    margin: BubbleEdges.only(
      top: 10.h,
      left: 100.w,
    ),
    alignment: Alignment.topRight,
  );
  final df = DateFormat('dd-MM- hh:mm a');
  final df1 = DateFormat('dd-MM- hh:mm a');
  final dateFormat = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessChatscreenViewModel(
        endLatitude: double.parse(endlatitude),
        endLongitude: double.parse(endlongitude),
      ),
      child: Consumer<BusinessChatscreenViewModel>(
          builder: ((context, model, child) {
        return Scaffold(
          appBar: BusinessChatScreenAppBar(
            distance: model.distanceInkm.toStringAsFixed(1),
            title: name,
            personProfileImage: image,
          ),
          body: Column(
            children: [
              SizedBox(height: 30.h),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Chats')
                        .where("businessId", isEqualTo: model.businessUser.uid)
                        .where("customerId", isEqualTo: customerId)
                        .orderBy('date', descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: avenir55RomanText(
                            text: 'No messages yet',
                            fontSize: 16.sp,
                          ),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.builder(
                        //auto scroll to bottom

                        reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var sendBy = snapshot.data!.docs[index]['sendBy'];
                          return Bubble(
                            style: sendBy == model.businessUid
                                ? styleMe
                                : styleSomebody,
                            child: avenir55RomanText(
                              textAlign: TextAlign.justify,
                              fontSize: 16.sp,
                              color: sendBy == model.businessUid
                                  ? whiteColor
                                  : blackColor,
                              text: snapshot.data!.docs[index]['message'],
                            ),
                          );
                        },
                      );
                    }),
              ),
              SizedBox(height: 10.h),
              ChatScreenTextFieldWidget(
                model: model,
                onPressed: () async {
                  log("businees id $businessId" +
                      "model businees uid ${model.businessUser.uid}");
                  await model.sendChat(
                    businessUid: businessId,
                    customerID: customerId,
                  );
                  chatController.clear();
                },
                controller: model.messageController,
              ),
              SizedBox(height: 10.h)
            ],
          ),
        );
      })),
    );
  }
}

class ChatScreenTextFieldWidget extends StatelessWidget {
  VoidCallback onPressed;
  TextEditingController controller;
  BusinessChatscreenViewModel model;

  ChatScreenTextFieldWidget({
    required this.model,
    required this.onPressed,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 310.w,
              height: 60.h,
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: TextField(
                controller: controller,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type a message',
                  hintStyle: avenir55RomanStyle(
                    fontSize: 16.sp,
                    color: blackColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            model.loading
                ? kCircularProgress()
                : GestureDetector(
                    onTap: onPressed,
                    child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: greenColor,
                      child: Icon(
                        Icons.send,
                        size: 30.sp,
                        color: whiteColor,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class BusinessChatScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String personProfileImage;
  String distance;

  BusinessChatScreenAppBar({
    required this.distance,
    required this.title,
    required this.personProfileImage,
  });

  @override
  Size get preferredSize => Size.fromHeight(140);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(130.h),
      child: Container(
        height: 140.h,
        width: 1.sw,
        decoration: BoxDecoration(
          color: darkGreyColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30.sp,
                        color: whiteColor,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundImage: NetworkImage(personProfileImage),
                        ),
                        SizedBox(width: 10.w),
                        avenir55RomanText(
                          text: title,
                          fontSize: 18.sp,
                          color: whiteColor,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      width: 25.w,
                      height: 25.h,
                      sendMessageFlyIcon,
                    ),
                    SizedBox(height: 5.h),
                    avenir55RomanText(
                      text: distance,
                      color: whiteColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
