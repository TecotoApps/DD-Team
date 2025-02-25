import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class OrderListItem extends StatelessWidget {
  final String buttonOneText;
  final String buttontwoText;
  OrderListItem({super.key,required this.buttonOneText,required this.buttontwoText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        elevation: 2.0,
        shadowColor: AppColors.grey_dots,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.grey_dots, width: 1)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address',
                          style: AppFonts.title.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        Gap(10),
                        Text(
                          'Address',
                          style: AppFonts.title.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        Gap(10),
                        Text(
                          'Address',
                          style: AppFonts.title.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        Gap(10),
                        Row(
                          children: [
                            SvgPicture.asset('images/ic_call.svg'),
                            Gap(10),
                            Text(
                              '1234567899',
                              style: AppFonts.title.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('images/ic_directions.svg'))
                ],
              ),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedElevatedButton(
                      width: MediaQuery.of(context).size.width*0.4,
                      height: MediaQuery.of(context).size.height*0.05,
                      text: '${buttonOneText}',
                      onPressed: (){},
                      cornerRadius: 50,
                      buttonColor: AppColors.appSecondaryColor,
                      textStyle: AppFonts.title.copyWith(color: AppColors.white,fontWeight: FontWeight.w600,fontSize: 14)),
                  RoundedElevatedButton(
                      width: MediaQuery.of(context).size.width*0.4,
                      height: MediaQuery.of(context).size.height*0.05,
                      text: '${buttontwoText}',
                      onPressed: (){},
                      cornerRadius: 50,
                      buttonColor: AppColors.white,
                      textStyle: AppFonts.title.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w600,fontSize: 14))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
