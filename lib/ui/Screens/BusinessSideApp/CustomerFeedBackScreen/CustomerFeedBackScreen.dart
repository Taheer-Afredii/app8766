import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/GeneralAppBarWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ShopScreen.dart/ShopScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerFeedBackScreen extends StatelessWidget {
  const CustomerFeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarWidget(title: 'Customers Feedback'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: avenir55RomanText(
                            text: 'Reviews & Ratings',
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            avenir55RomanText(
                              text: '5.0',
                              fontSize: 20.sp,
                            ),
                            SizedBox(width: 5.w),
                            Icon(
                              Icons.star_rounded,
                              color: yelloColor,
                            ),
                          ],
                        ),
                        avenir55RomanText(text: '32 (Clients)'),
                      ],
                    ),
                  )
                ],
              ),
              Divider(color: blackColor),
              SizedBox(height: 20.h),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 20,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ReviewAndRatingsCardWidget(
                    name: 'John',
                    rating: 4,
                    timeAgo: '3 days ago',
                    reviewComments: 'This is the dummy comment for review',
                  );
                },
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
