import 'package:flutter/cupertino.dart';

class UserInfo with ChangeNotifier {
  String? accountType;
  int? accountId;
  String? imagePath;
  String? password;
  String? realName;
  String? address;
  String? area;
  String? lastLoginTime;
  String? accountState;
  String? accountName;

  UserInfo({
    this.accountType,
    this.accountId,
    this.imagePath,
    this.password,
    this.realName,
    this.address,
    this.area,
    this.lastLoginTime,
    this.accountState,
    this.accountName});
}