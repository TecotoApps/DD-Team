import 'package:dd_shop/mpin/mpin_controller.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../otp_generate/otp_generate_controller.dart';

class EnterMpin extends StatelessWidget {
  EnterMpin({super.key});

  final FocusNode focusNode_1 = FocusNode();
  final FocusNode focusNode_2 = FocusNode();
  final FocusNode focusNode_3 = FocusNode();
  final FocusNode focusNode_4 = FocusNode();
  final FocusNode focusNode_5 = FocusNode();
  final FocusNode focusNode_6 = FocusNode();

  final TextEditingController mpinController_1 = TextEditingController();
  final TextEditingController mpinController_2 = TextEditingController();
  final TextEditingController mpinController_3 = TextEditingController();
  final TextEditingController mpinController_4 = TextEditingController();
  final TextEditingController mpinController_5 = TextEditingController();
  final TextEditingController mpinController_6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(MediaQuery.of(context).size.height * 0.15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SvgPicture.asset(
                    'images/splash_logo.svg',
                    fit: BoxFit.fill,
                  ),
                ),
                Gap(24),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 36.0),
                    color: Colors.white,
                    child: Text(
                      Dd_Strings.generate_otp_text,
                      textAlign: TextAlign.center,
                      style: AppFonts.smallText.copyWith(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40.0)),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.5,
                    color: Colors.white,
                    child: SvgPicture.asset(
                      'images/create_mpin.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Gap(18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    Dd_Strings.enter_your_mpin,
                    textAlign: TextAlign.start,
                    style: AppFonts.title.copyWith(
                      color: AppColors.appPrimaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (mpinController_1.text.isEmpty) {
                        focusNode_1.requestFocus();
                      } else if (mpinController_2.text.isEmpty) {
                        focusNode_2.requestFocus();
                      } else if (mpinController_3.text.isEmpty) {
                        focusNode_3.requestFocus();
                      } else if (mpinController_4.text.isEmpty) {
                        focusNode_4.requestFocus();
                      } else if (mpinController_5.text.isEmpty) {
                        focusNode_5.requestFocus();
                      } else {
                        focusNode_6.requestFocus();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildOtpTextField(focusNode_1, focusNode_2, mpinController_1),
                        buildOtpTextField(focusNode_2, focusNode_3, mpinController_2),
                        buildOtpTextField(focusNode_3, focusNode_4, mpinController_3),
                        buildOtpTextField(focusNode_4, focusNode_5, mpinController_4),
                        buildOtpTextField(focusNode_5, focusNode_6, mpinController_5),
                        buildOtpTextField(focusNode_6, null, mpinController_6),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: RoundedElevatedButton(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.05,
                    text: Dd_Strings.submit_button_text,
                    onPressed: () async {
                      String mpin = mpinController_1.text +
                          mpinController_2.text +
                          mpinController_3.text +
                          mpinController_4.text +
                          mpinController_5.text +
                          mpinController_6.text;
                      print("this is mpin $mpin");
                      await mpinController.validateMpin(mpin, context);
                    },
                    cornerRadius: 6.0,
                    buttonColor: AppColors.appSecondaryColor,
                    textStyle: AppFonts.title.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOtpTextField(
      FocusNode focusNode,
      FocusNode? nextFocus,
      TextEditingController controller,
      ) {
    return SizedBox(
      height: 48.0,
      width: 48.0,
      child: TextFieldCurvedEdges(
        controller: controller,
        focusNode: focusNode,
        backgroundColor: AppColors.white,
        keyboardType: TextInputType.number,
        borderColor: AppColors.grey_dots,
        textAlign: TextAlign.center,
        length: 1,
        borderRadius: 8,
        onChanged: (value) {
          if (value.isNotEmpty && nextFocus != null) {
            FocusScope.of(focusNode.context!).requestFocus(nextFocus);
          }
        },
        onSubmitted: (_) {
          if (nextFocus == null) {
            FocusScope.of(focusNode.context!).unfocus();
          }
        },
      ),
    );
  }
}
