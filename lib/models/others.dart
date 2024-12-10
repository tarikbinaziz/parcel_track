import 'package:parcel_track/models/store_model/address.dart';

class ServiceArg {
  final int serviceID;
  final int storeID;
  const ServiceArg({required this.serviceID, required this.storeID});
}

// class StoreArg {
//   final int? storeID;
//   final StoreModel storeModel;
//   const StoreArg({required this.storeID, required this.storeModel});
// }

class AddressArg {
  final bool? isEditAddress;
  final Address? address;
  AddressArg({this.isEditAddress, this.address});
}
