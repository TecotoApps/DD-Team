import 'dart:async';
import 'package:dd_shop/dashboard/Dashboard.dart';
import 'package:dd_shop/dashboard/hr_dashboard.dart';
import 'package:dd_shop/mpin/verify_mpin.dart';
import 'package:dd_shop/otp_generate/otp_generate_screen.dart';
import 'package:dd_shop/services/sharedPress.dart';
import 'package:dd_shop/utils/components/home_screen.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(DhobiDosthShop());
}

class DhobiDosthShop extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        primaryColorDark: Colors.blue,
        // backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: MySplashScreen(),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  @override
  MySplashScreenState createState() => MySplashScreenState();
}

class MySplashScreenState extends State<MySplashScreen> {
  void initState() {
    goScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: SvgPicture.asset(
          'images/splash_logo.svg',
          fit: BoxFit.fitWidth,
        ));
  }

  void goScreen() async {
    String? name1 = await sharedPress.getData("EMPLOGIN");
    if (name1 == 'LOGGEDIN') {
      Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => EnterMpin())));
    } else {
      Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => OtpGenerate())));
    }
  }
}
