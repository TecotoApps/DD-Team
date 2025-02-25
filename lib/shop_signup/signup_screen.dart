import 'package:dd_shop/shop_signup/signup_controller.dart';
import 'package:dd_shop/utils/components/dd_elevated_buttons.dart';
import 'package:dd_shop/utils/components/dd_text_field.dart';
import 'package:dd_shop/utils/components/home_screen.dart';
import 'package:flutter/material.dart';

class ShopRegistration extends StatefulWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  final String phNumber;
  ShopRegistration({required this.phNumber});
  @override
  _ShopRegistrationState createState() => _ShopRegistrationState();
}

class _ShopRegistrationState extends State<ShopRegistration> {
  String verifymsg = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 60.0)),
            Center(
              child: Container(
                  //padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(color: Colors.black, fontSize: 30.0),
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.white,
                  child: DD_TextField(
                    ddController: widget.nameController,
                    hintText: 'Enter Shop Name',
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.white,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: widget.phNumber,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        labelText: 'Your Phone Number'),
                    readOnly: true,
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.white,
                  child: DD_TextField(
                    ddController: widget.emailController,
                    hintText: 'Enter Shop email',
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.white,
                  child: DD_TextField(
                    ddController: widget.addressController,
                    hintText: 'Enter Shop Address',
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.white,
                  child: DD_TextField(
                    ddController: widget.cityController,
                    hintText: 'Enter Your City',
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.white,
                  child: DD_TextField(
                    ddController: widget.landmarkController,
                    hintText: 'Enter Shop Landmark',
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.white,
                  child: DD_TextField(
                    ddController: widget.stateController,
                    hintText: 'Enter State Name',
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.white,
                  child: DD_TextField(
                    ddController: widget.pincodeController,
                    hintText: 'Enter Pincode',
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.white,
                  child: DD_TextField(
                    ddController: widget.accountNoController,
                    hintText: 'Enter Account Number',
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.white,
                  child: DD_TextField(
                    ddController: widget.ifscController,
                    hintText: 'Enter Ifsc Code',
                  )),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Center(
              child: Container(
                  color: Colors.white,
                  child: DD_ElevatedButton(
                    hintText: 'SIGN UP',
                    onPressed: () async {
                      var result = await signUp_Contoller.signUp(1323,
                        widget.nameController.text,
                        widget.phNumber,
                        widget.emailController.text,
                        widget.addressController.text,
                        widget.cityController.text,
                        widget.stateController.text,
                        widget.landmarkController.text,
                        widget.pincodeController.text,
                        widget.accountNoController.text,
                        widget.ifscController.text,12345,15151
                      );
                      if (result.statusCode == 200) {
                        verifymsg = result.message;
                        /*Fluttertoast.showToast(
                            msg: verifymsg,
                            toastLength: Toast.LENGTH_LONG,
                            fontSize: 20,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.green);*/
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      } else {
                        /*Fluttertoast.showToast(
                            msg: "Please wait ...",
                            toastLength: Toast.LENGTH_LONG,
                            fontSize: 20,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.green);*/
                      }
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
