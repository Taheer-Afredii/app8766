// import 'package:app_876/core/constants/assets.dart';
// import 'package:app_876/core/constants/colors.dart';
// import 'package:app_876/core/constants/styles.dart';
// import 'package:app_876/ui/Screens/CustomerSideApp/OnBoardingScreens/OnBoardingScreens.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class UserAwaitingRequestTabWidget extends StatelessWidget {
//   // final String location;
//   // final String showUpPercentage;
//   // final List servicesList;
//   // final String serviceTypeIcon;

//   // BusinessAwaitingRequestTabWidget({
//   //   required this.location,
//   //   required this.serviceTypeIcon,
//   //   required this.servicesList,
//   //   required this.showUpPercentage,
//   // });
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           ListView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             padding: EdgeInsets.zero,
//             shrinkWrap: true,
//             itemCount: 5,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10.h),
//                 child: InkWell(
//                   onTap: () {
//                     //Add customer details Screen.
//                   },
//                   child: AwaitingResponseCardWidget(),
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 50.h),
//         ],
//       ),
//     );
//   }
// }

// class AwaitingResponseCardWidget extends StatelessWidget {
//   const AwaitingResponseCardWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         vertical: 10.h,
//         horizontal: 10.w,
//       ),
//       margin: EdgeInsets.symmetric(horizontal: 20.w),
//       decoration: BoxDecoration(
//         color: whiteColor,
//         borderRadius: BorderRadius.circular(15.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 30.r,
//                     backgroundImage: AssetImage(dummyPersonImage1),
//                     //  NetworkImage(
//                     //   model.businessUpcomingOrders[index].userPic!,
//                     // ),
//                   ),
//                   SizedBox(width: 10.w),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       avenir55RomanText(
//                         text: 'Dummy',
//                         // text: model.businessUpcomingOrders[index].userName!,
//                         fontSize: 18.sp,
//                       ),
//                       SizedBox(height: 5.h),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Image.asset(
//                             pinIcon2,
//                             width: 14.w,
//                             height: 14.h,
//                           ),
//                           SizedBox(width: 5.w),
//                           SizedBox(
//                             width: 150.w,
//                             child: avenir55RomanText(
//                               text: 'Dummy',
//                               // text: location,
//                               fontSize: 13.sp,
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               ),
//               Row(
//                 children: [
//                   avenir55RomanText(text: 'Status:'),
//                   SizedBox(width: 5.w),
//                   avenir55RomanText(
//                     text: 'Late',
//                     // text: showUpPercentage,
//                     color: redColor,
//                   ),
//                 ],
//               )
//             ],
//           ),
//           SizedBox(height: 5.h),
//           Divider(color: blackColor),
//           SizedBox(height: 5.h),
//           Row(
//             children: [
//               avenir55RomanText(
//                 text: 'Appointment date: ',
//                 fontSize: 16.sp,
//               ),
//               avenir55RomanText(
//                 text: '12/12/2023',
//                 color: redColor,
//                 fontSize: 16.sp,
//               ),
//             ],
//           ),
//           SizedBox(height: 5.h),
//           Divider(color: blackColor),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               avenir55RomanText(
//                 text: 'Services Requested',
//                 fontSize: 16.sp,
//               ),
//               SizedBox(height: 5.h),
//               SizedBox(
//                 height: 60.h,
//                 child: ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: 4,
//                   // servicesList.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Row(
//                       children: [
//                         Image.asset(
//                           // serviceTypeIcon,
//                           chairIcon,
//                           width: 16.w,
//                           height: 16.h,
//                         ),
//                         SizedBox(width: 10.w),
//                         avenir55RomanText(
//                           text: 'Dummy',
//                           // text: servicesList[index]['serviceName'],
//                           fontSize: 16.sp,
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               GestureDetector(
//                 onTap: () {},
//                 child: CustomGloballyUsedButtonWidget(
//                   width: 140.w,
//                   height: 40.h,
//                   centerTitle: 'Completed',
//                   centerFontSize: 16.sp,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   //TODO Add reject Function here
//                 },
//                 child: CustomGloballyUsedButtonWidget(
//                   width: 140.w,
//                   height: 40.h,
//                   centerTitle: 'Didn\'t Visit',
//                   centerFontSize: 16.sp,
//                   color: redColor,
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
