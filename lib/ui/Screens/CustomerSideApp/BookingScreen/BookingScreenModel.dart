import '../../../../core/constants/assets.dart';

class AppointmentCardModel {
  String name;
  DateTime appointmentDate;
  String profileImage;
  String serviceType;

  AppointmentCardModel({
    required this.appointmentDate,
    required this.name,
    required this.profileImage,
    required this.serviceType,
  });
}

List<AppointmentCardModel> appointmentCardList = [
  AppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
  AppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
  AppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
  AppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
  AppointmentCardModel(
    appointmentDate: DateTime.now(),
    name: 'Jason',
    profileImage: dummyPersonImage1,
    serviceType: 'Haircut + Shave & Facial',
  ),
];
