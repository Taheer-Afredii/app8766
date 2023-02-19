import 'package:app_876/ui/CustomWidgets/SearchBarWidget.dart';
import 'package:app_876/ui/CustomWidgets/UserHomeScreenAppBar.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/HomeScreen/HomeScreenModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserDrawer/UserDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/assets.dart';
import '../ServiceScreen.dart/ServiceMapListScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController homeScreenSearchController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenViewModel(),
      child: Consumer<HomeScreenViewModel>(builder: (context, model, child) {
        return Scaffold(
          drawer: UserDrawar(),
          appBar: UserHomeScreenAppBarWidget(
            centerWidget: Image.asset(
              whiteLogo,
              width: 28.w,
              height: 48.h,
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: 15.h),
              SearchBarWidget(
                searchController: homeScreenSearchController,
                hintText: 'Events, restaurants, hairstylists',
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: GridView.builder(
                  itemCount: serviceImages.length,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 14.0,
                    mainAxisSpacing: 14.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => ServicesMapScreen(
                              latitude: model.user.latitude,
                              longitude: model.user.longitude,
                              serviceTitle: serviceTitles[index],
                            ));
                      },
                      child: Image.asset(serviceImages[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
