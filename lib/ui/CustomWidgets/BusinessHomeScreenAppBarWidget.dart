import 'package:app_876/ui/Screens/BusinessSideApp/BusinessDrawer/BusnesUserDetails.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/MyBusinessProfileScreen/MyBusinessProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';

class BusinessHomeScreenAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget centerWidget;
  BusinessHomeScreenAppBarWidget({required this.centerWidget});

  @override
  Size get preferredSize => Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    return Consumer<BusinessUserDetails>(builder: (context, model, child) {
      return PreferredSize(
        preferredSize: Size.fromHeight(130.h),
        child: Container(
          height: 130.h,
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
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Image.asset(drawerIcon, width: 25.w, height: 25.h),
                  ),
                  centerWidget,
                  InkWell(
                      onTap: () {
                        Get.to(() => MyBusinessProfileScreen());
                      },
                      child: model.businessUser.image == null
                          ? CircleAvatar(
                              radius: 15.r,
                              child: Icon(Icons.person),
                            )
                          : CircleAvatar(
                              radius: 15.r,
                              backgroundImage:
                                  NetworkImage(model.businessUser.image!),
                            )),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
