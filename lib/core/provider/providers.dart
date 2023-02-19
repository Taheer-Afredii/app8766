import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/BusinessSignInScreen/business_signin_viewmodel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/BusinessSignUPScreen/AddNewEmployModel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/BusinessSignUPScreen/business_signup_viewmodel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/GetBusinessLocationScreen/BusinessLocationViewModel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/UploadBusinessFilesScreen/UploadBusinessFilesScreenModel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/auth_viewModel.dart';
import 'package:app_876/ui/Screens/BusinessSideApp/AuthScreens/service_addition_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/customer_authscreens_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignINScreen/customer_signin_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/AuthScreens/CustomerSignUPScreen/customer_sign_up_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/FavoriteScreen/favorite_ViewModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/HomeScreen/HomeScreenModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/HomeScreen/mapScreenViewModel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ServiceSearchScreen/SearviceSearchScreenViewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ConfirmAppointmentScreen/confirmAppointmentViewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/ShopScreen.dart/shopScreenViewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserDrawer/userDrawer_viewmodel.dart';
import 'package:app_876/ui/Screens/CustomerSideApp/UserProfileScreen/UserProfileViewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  // Add your providers her
  // e

  ChangeNotifierProvider<BusinessSignUpViewModel>(
      create: (_) => BusinessSignUpViewModel()),
  ChangeNotifierProvider<BusinessAddEmployProvider>(
      create: (_) => BusinessAddEmployProvider()),

  //signin

  // ChangeNotifierProvider<BusinessHomeScreenViewModel>(
  //     create: (_) => BusinessHomeScreenViewModel()),
  ChangeNotifierProvider<BusinessSignInViewModel>(
      create: (_) => BusinessSignInViewModel()),

  ChangeNotifierProvider<ServiceAdditionViewModel>(
      create: (_) => ServiceAdditionViewModel()),
  ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
  ChangeNotifierProvider<UploadBusinessFileViewModel>(
      create: (_) => UploadBusinessFileViewModel()),

  ChangeNotifierProvider<BusinessLocationViewModel>(
      create: (_) => BusinessLocationViewModel()),
  //Customer Providers>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ChangeNotifierProvider<CustomerSignUpViewModel>(
      create: (_) => CustomerSignUpViewModel()),
  ChangeNotifierProvider<CustomerSignInViewModel>(
      create: (_) => CustomerSignInViewModel()),
  ChangeNotifierProvider<CustomerAuthScreenViewModel>(
      create: (_) => CustomerAuthScreenViewModel()),

  ChangeNotifierProvider<UserProfileViewModel>(
      create: (_) => UserProfileViewModel()),
  // ChangeNotifierProvider<HomeScreenViewModel>(
  //     create: (_) => HomeScreenViewModel()),
  ChangeNotifierProvider<MapScreenViewModel>(
      create: (_) => MapScreenViewModel()),
  ChangeNotifierProvider<ServiceSearchScreenViewmodel>(
      create: (_) => ServiceSearchScreenViewmodel()),
  ChangeNotifierProvider<ShopScreenViewModel>(
      create: (_) => ShopScreenViewModel()),
  ChangeNotifierProvider<UserDrawerViewModel>(
      create: (_) => UserDrawerViewModel()),
  ChangeNotifierProvider<ConfirmAppointmentViewModel>(
      create: (_) => ConfirmAppointmentViewModel()),
  ChangeNotifierProvider<FavouriteViewModel>(
      create: (_) => FavouriteViewModel()),
];
