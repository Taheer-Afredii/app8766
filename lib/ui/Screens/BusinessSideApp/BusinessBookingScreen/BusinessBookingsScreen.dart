import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/BusinessHomeScreenAppBarWidget.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessBookingScreen/BusinessBookingScreenTabs/BusinessAwaitingRequestsTabScreen.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessBookingScreen/BusinessBookingScreenTabs/BusinessCompletedOrdersTabScreen.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessBookingScreen/BusinessBookingScreenTabs/BusinessUpcomingOrdersTabScreen.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/BusinessDrawer/BusinessDrawer.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserDrawer/UserDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessBookingScreenTab extends StatefulWidget {
  const BusinessBookingScreenTab({super.key});

  @override
  State<BusinessBookingScreenTab> createState() => _BusinessBookingScreenTab();
}

class _BusinessBookingScreenTab extends State<BusinessBookingScreenTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BusinessDrawar(),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: BusinessDrawar(),
          appBar: BusinessHomeScreenAppBarWidget(
            centerWidget: avenir55RomanText(
              text: 'Appointments',
              fontSize: 20.sp,
              color: whiteColor,
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: 30.h),
              SizedBox(
                height: 40.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: BusinessAppointmentTabBarButtonWidget(),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: TabBarView(
                  children: [
                    BusinessUpcomingOrdersTabScreen(),
                    BusinessAwaitingRequestTabWidget(),
                    BusinessCompletedOrdersTabScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessAppointmentTabBarButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black.withOpacity(0.5),
      labelStyle: avenir55RomanStyle(fontSize: 12.sp),
      unselectedLabelStyle: avenir55RomanStyle(fontSize: 12.sp),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(50), // Creates border
        color: greenColor,
      ),
      tabs: [
        Tab(
          height: 40.h,
          text: "Upcoming",
        ),
        Tab(
          height: 40.h,
          text: "Awaiting Response",
        ),
        Tab(
          height: 40.h,
          text: "Completed",
        ),
      ],
    );
  }
}


