import 'package:dd_shop/mpin/create_mpin.dart';
import 'package:dd_shop/mpin/verify_mpin.dart';
import 'package:dd_shop/otp_generate/otp_generate_controller.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../otp_verify/otp_validation_screen.dart';
import 'otp_modal.dart';

class OtpGenerate extends StatefulWidget {
  @override
  _OtpGenerateState createState() => _OtpGenerateState();
}

class _OtpGenerateState extends State<OtpGenerate> {
  TextEditingController phoneController = TextEditingController(text: '');
  final formKey = GlobalKey<FormState>();
  String verifymsg = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(MediaQuery.of(context).size.height*0.15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: SvgPicture.asset(
                        'images/splash_logo.svg',fit: BoxFit.fill,
                      ),
                    ),
                    Gap(24),
                    Center(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 36.0),
                          color: Colors.white,
                          child: Text(Dd_Strings.generate_otp_text,textAlign: TextAlign.center,
                            style: AppFonts.smallText.copyWith(color: AppColors.textColor,fontWeight: FontWeight.w400),
                          )),
                    ),
                    Padding(padding: EdgeInsets.only(top: 40.0)),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.2,
                        width: MediaQuery.of(context).size.width*0.5,
                        color: Colors.white,
                        child: SvgPicture.asset(
                          'images/mobile_number.svg',fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Gap(18),
                
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(Dd_Strings.enter_mobile_number,textAlign: TextAlign.start,
                        style: AppFonts.title.copyWith(color: AppColors.appPrimaryColor,fontWeight: FontWeight.w700),
                      ),
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFieldCurvedEdges(
                          controller: phoneController,
                          backgroundColor: AppColors.white,
                          keyboardType: TextInputType.number,
                          borderColor: AppColors.text_border_color,
                          length: 13,
                          borderRadius: 10,
                          inputFormatter: "number",
                          validatorType: 'phone'
                      ),
                    ),
                
                    Spacer(),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
                      child: RoundedElevatedButton(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.05,
                          text: Dd_Strings.continue_button_text,
                          onPressed: () async{
                            UserInfoModal empDetails = await otp_controller.getEmployeeDetailsByPhoneNumber(phoneController.text,context);
                            print("this si status code ${empDetails.statusCode}");
                            if(empDetails.statusCode == 200) {
                              if (empDetails.payload!.mpin != null) {
                                //naviagte to enter mpin
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EnterMpin()));
                              } else {
                                //navigate to create mpin flow
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateMpin()),);
                              }
                            }
                            else if(empDetails.statusCode == 203){
                              //error dialogue
                            }
                          },
                          cornerRadius: 6.0,
                          buttonColor: AppColors.appSecondaryColor,
                          textStyle: AppFonts.header
                              .copyWith(color: AppColors.white)),
                    ),
                
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 24.0),
                    //   width:MediaQuery.of(context).size.width * 0.86,
                    //     color: Colors.white,
                    //     child: Form(
                    //       key: formKey,
                    //       child: TextFormField(
                    //         keyboardType: TextInputType.phone,
                    //         decoration: InputDecoration(
                    //           labelText: '',
                    //           border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    //         ),
                    //         controller: phoneController,
                    //         validator: (value) {
                    //           if (value == null||value.isEmpty||RegExp(r'^(0/91)?[6-9]\d{1}[0-9]\d{9}$').hasMatch(value)) {
                    //             return 'Please enter valid number';
                    //           }
                    //           return null;
                    //         },
                    //       )
                    //     ),
                    //   ),
                
                    /* Center(
                      child: Container(
                          color: Colors.white,
                          child: DD_ElevatedButton(
                              hintText: 'GET OTP',
                              onPressed: () async {
                                if(formKey.currentState!.validate()){
                
                                  // _otpBloc.add(OnOtpGenerate(number: phoneController.text));
                                  var result = await otp_controller
                                      .generateOTP(phoneController.text);
                                  verifymsg = result["message"];
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OtpValidation(
                                              phoneNumber:phoneController.text)));
                                  }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please Enter Valid Number')),
                                  );
                                }
                              })),
                    ),*/
                  ],),
              ),
            ),
          )
          );
  }
}
