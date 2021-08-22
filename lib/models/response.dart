import 'dart:convert';

import 'package:base_caller/models/address.dart';
import 'package:base_caller/models/email.dart';
import 'package:base_caller/models/phone.dart';

class TrueCallerResponse {

  late bool isBusiness;
  late String name;
  late bool isVerified;
  late String? image;
  late String number;
  late Address? address;
  late Phone? phone;
  late Email? email;


  TrueCallerResponse.fromJson(Map<String, dynamic> json) {
    this.isBusiness =json['isBusiness'];
    this.name =json['name'];
    this.isVerified =json['isVerified'];
    this.image =json['image'];
    this.address = Address.fromJson(json['addresses'][0]);
    this.phone = Phone.fromJson(json['phones'][0]);
    this.email = Email.fromJson(json['email']);
  }
}