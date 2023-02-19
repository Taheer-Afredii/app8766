import '../../../../core/constants/assets.dart';

class ServiceListModel {
  String coverImage;
  String name;
  String serviceType;
  String address;
  String rating;

  ServiceListModel({
    required this.address,
    required this.coverImage,
    required this.name,
    required this.rating,
    required this.serviceType,
  });
}

List<ServiceListModel> servicesList = [
  ServiceListModel(
    address: '19 ST mile Tread, willow brook',
    coverImage: serviceCoverImage,
    name: 'John Smith',
    rating: '5.0',
    serviceType: 'Hairdresser + Beautician',
  ),
  ServiceListModel(
    address: 'Shop# 30, ST downtown NY',
    coverImage: serviceCoverImage,
    name: 'Mathew Robert',
    rating: '4.0',
    serviceType: 'Hairdresser + Beautician',
  ),
  ServiceListModel(
    address: '19 ST mile Tread, willow brook',
    coverImage: serviceCoverImage,
    name: 'John Smith',
    rating: '4.7',
    serviceType: 'Hairdresser + Beautician',
  ),
  ServiceListModel(
    address: '19 ST mile Tread, willow brook',
    coverImage: serviceCoverImage,
    name: 'John Smith',
    rating: '5.0',
    serviceType: 'Hairdresser + Beautician',
  ),
];
