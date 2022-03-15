import 'package:flutter/material.dart';
import 'global/routers.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

GetIt locator = GetIt.instance;

void main() {
  locator.registerSingleton(TelAndSmsService());
  runApp(Demo());
}

class TelAndSmsService {
  void callPhone(String number) => launch("tel:$number");
  void sendSms(String number) => launch("sms:$number");
  void sendEmail(String email) => launch("mailto:$email");
}

class Demo extends StatelessWidget {
  Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
    );
  }
}