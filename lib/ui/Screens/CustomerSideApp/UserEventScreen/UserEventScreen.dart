import 'package:app_876/core/constants/assets.dart';
import 'package:app_876/core/constants/colors.dart';
import 'package:app_876/core/constants/styles.dart';
import 'package:app_876/ui/CustomWidgets/SearchBarWidget.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserDrawer/UserDrawer.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserProfileScreen/UserProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

TextEditingController eventScreenSearchController = TextEditingController();

class UserEventsScreen extends StatelessWidget {
  const UserEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserDrawar(),
      appBar: EventScreenAppBarWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    avenir55RomanText(text: 'Attending Event'),
                    avenir55RomanText(
                      text: 'View all',
                      color: greenColor,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EventScreenAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(140);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(150.h),
      child: Container(
        height: 180.h,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Image.asset(drawerIcon, width: 25.w, height: 25.h),
                    ),
                    avenir55RomanText(
                      text: 'Get Events',
                      fontSize: 22.sp,
                      color: whiteColor,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => UserProfileScreen());
                      },
                      child: CircleAvatar(
                        radius: 15.r,
                        child: Image.asset(dummyPersonImage1),
                      ),
                      // model.user.image == null
                      //     ? CircleAvatar(
                      //         radius: 15.r,
                      //         child: Icon(Icons.person),
                      //       )
                      //     : CircleAvatar(
                      //         radius: 15.r,
                      //         backgroundImage: NetworkImage(model.user.image!),
                      //       ),
                    ),
                  ],
                ),
                SearchBarWidget(
                  searchController: eventScreenSearchController,
                  hintText: 'Search by location or date',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
