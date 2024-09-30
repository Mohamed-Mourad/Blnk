import 'package:blnk_flutter/models/address_model.dart';

class UserModel {
  String firstName;
  String lastName;
  String mobile;
  String landline;
  String email;
  AddressModel address;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.landline,
    required this.email,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobile: json['mobile'],
      landline: json['landline'],
      email: json['email'],
      address: AddressModel.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'landline': landline,
      'email': email,
      'address': address.toJson(),
    };
  }
}
