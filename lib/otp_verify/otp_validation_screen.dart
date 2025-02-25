import 'dart:async';
import 'package:dd_shop/otp_verify/otp_verify_controller.dart';
import 'package:dd_shop/shop_signup/shop_model.dart';
import 'package:dd_shop/shop_signup/signup_screen.dart';
import 'package:dd_shop/utils/components/dd_elevated_buttons.dart';
import 'package:dd_shop/utils/components/dd_number_field.dart';
import 'package:dd_shop/utils/components/home_screen.dart';
import 'package:flutter/material.dart';

class OtpValidation extends StatefulWidget {
  TextEditingController otpController = TextEditingController();
  final String phoneNumber;
  OtpValidation({required this.phoneNumber});
  @override
  _OtpValidationState createState() => _OtpValidationState();
}

class _OtpValidationState extends State<OtpValidation> {
  String verifymsg = '';
  late ShopModel shopModel;
  late PayLoad payLoad;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 80.0)),
            Center(
              child: Container(
                //padding: EdgeInsets.all(10.0),
                color: Colors.white,
                child: Image.asset(
                  'images/mobile.png',
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 40.0)),
            Center(
              child: Container(
                  //padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  child: Text(
                    'OTP Verification',
                    style: TextStyle(color: Colors.black, fontSize: 30.0),
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  //padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  child: DD_NumberField(
                    ddController: widget.otpController,
                    hintText: 'Enter OTP',
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  //padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  child: DD_ElevatedButton(
                      hintText: 'VERIFY',
                      onPressed: () async {
                        var result = await otp_verify_controller.validateOTP(
                            widget.phoneNumber, widget.otpController.text);
                        if (result.isPayload == false) {
                          verifymsg = result.message;
                          /*Fluttertoast.showToast(
                              msg: verifymsg,
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: 20,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.blueAccent);*/
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopRegistration(
                                      phNumber: widget.phoneNumber)));
                        } else if (result.isPayload == true) {
                          verifymsg = result.message;
                          /*Fluttertoast.showToast(
                              msg: verifymsg,
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: 20,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.blueAccent);*/
                          print('going home');
                          Timer(
                              Duration(seconds: 3),
                              () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen())));
                        }
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
