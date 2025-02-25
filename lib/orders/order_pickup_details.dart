import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class OrderPickupDetails extends StatelessWidget {
   OrderPickupDetails({super.key});

  TextEditingController totalItemsController = TextEditingController();
  TextEditingController totalWeightController = TextEditingController();
  TextEditingController bagCodeController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        title: Text(
          '${Dd_Strings.order_pickup_details}',
          style: AppFonts.header
              .copyWith(color: AppColors.appPrimaryColor, fontSize: 22),
        ),
        leading: IconButton(
          icon: SvgPicture.asset('images/ic_back.svg'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Dd_Strings.total_items}',
                    style: AppFonts.title
                        .copyWith(color: AppColors.intro_subtitle_color),
                  ),
                  Gap(10),
                  TextFieldCurvedEdges(
                      controller: totalItemsController,
                      backgroundColor: AppColors.white,
                      keyboardType: TextInputType.number,
                      borderColor: AppColors.text_border_color,borderRadius: 10,),
                  Gap(20),
                  Text(
                    '${Dd_Strings.total_weight}',
                    style: AppFonts.title
                        .copyWith(color: AppColors.intro_subtitle_color),
                  ),
                  Gap(10),
                  TextFieldCurvedEdges(
                      controller: totalWeightController,
                      backgroundColor: AppColors.white,
                      keyboardType: TextInputType.number,
                      borderColor: AppColors.text_border_color,borderRadius: 10,),
                  Gap(20),
                  Text(
                    '${Dd_Strings.bag_code}',
                    style: AppFonts.title
                        .copyWith(color: AppColors.intro_subtitle_color),
                  ),
                  Gap(10),
                  TextFieldCurvedEdges(
                      controller: bagCodeController,
                      backgroundColor: AppColors.white,
                      keyboardType: TextInputType.number,
                      borderColor: AppColors.text_border_color,borderRadius: 10,),
                  Gap(20),
                  Text(
                    '${Dd_Strings.comments}',
                    style: AppFonts.title
                        .copyWith(color: AppColors.intro_subtitle_color),
                  ),
                  Gap(10),
                  TextFieldCurvedEdges(
                      controller: commentsController,
                      backgroundColor: AppColors.white,
                      keyboardType: TextInputType.number,
                      borderColor: AppColors.text_border_color,
                  borderRadius: 10,),
                  Gap(20),
                  Row(

                    children: [
                      Text(
                        '${Dd_Strings.pricing_type}',
                        style: AppFonts.title
                            .copyWith(color: AppColors.intro_subtitle_color),
                      ),
                      Gap(MediaQuery.of(context).size.width*0.1),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: DropdownButton<String>(
                          hint: Text('Select',style: AppFonts.title,),
                          alignment: Alignment.center,

                          underline: Container(),
                          items: <String>['${Dd_Strings.weight_type}', '${Dd_Strings.piece_type}'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style: AppFonts.title,),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      )
                    ],
                  ),
                  Gap(20),


                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
            child: RoundedElevatedButton(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.05,
                text: Dd_Strings.order_pickup,
                onPressed: () {
                  // _otpBloc.add(OnOtpGenerate(number: phoneController.text));
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => HomeScreen()));
                },
                cornerRadius: 6.0,
                buttonColor: AppColors.appSecondaryColor,
                textStyle: AppFonts.title
                    .copyWith(color: AppColors.white,fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
