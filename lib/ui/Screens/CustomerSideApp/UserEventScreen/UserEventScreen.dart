import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserDrawer/UserDrawer.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserEventScreen/Widgets/AttendingEventsCardWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserEventScreen/Widgets/UpcomingEventsCardWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserEventScreen/Widgets/UserEventsScreenAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserEventsScreen extends StatelessWidget {
  const UserEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserDrawar(),
      appBar: UserEventScreenAppBarWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              AttendingEventsCardWigdet(),
              SizedBox(height: 20.h),
              UpcomingEventsCardWidget(),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
