import 'package:flutter/cupertino.dart';

class UserInfo with ChangeNotifier {
  late String userType;
  // late int? userId;

  UserInfo({this.userType = 'USER'});
}