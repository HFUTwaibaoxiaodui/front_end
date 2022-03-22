import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'back_end_interface_url.dart';

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
  String? phone;
  String? firstLetter;
  String? currentTime;

  Image buildImage(BuildContext context) {
    return Provider.of<UserInfo>(context, listen: false).imagePath != null ?
    Image.network(
      Provider.of<UserInfo>(context, listen: false).imagePath!,
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.width * 0.2,
    ) :
    Image.network(
      defaultImagePath,
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.width * 0.2,
    );
  }
}