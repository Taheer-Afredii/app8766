import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/styles.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final String hintText;
  Function(String)? onChanged;

  SearchBarWidget(
      {required this.searchController, required this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: 388.w,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: lightGreyColor,
        borderRadius: BorderRadius.circular(52.r),
      ),
      child: TextField(
        onChanged: onChanged,
        controller: searchController,
        cursorColor: greyColor,
        decoration: InputDecoration(
          prefixIcon: Icon(color: greenColor, Icons.search),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: avenir55RomanStyle(),
        ),
      ),
    );
  }
}
