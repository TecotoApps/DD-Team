import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:12.0,right: 12.0,left: 12.0),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, int index){
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: orderHistoryCard(context),
          );
        },
      ),
    );
  }
  Widget orderHistoryCard(BuildContext context)=>Card(
    elevation: 2.0,
    shadowColor: AppColors.grey_dots,
    shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.grey_dots, width: 1)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${Dd_Strings.order_id}',style: AppFonts.smallText.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w600,fontSize: 14),),
              Text('15 jul,2024',style: AppFonts.smallText.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w500,fontSize: 14),)

            ],
          ),
          Gap(MediaQuery.of(context).size.height*0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${Dd_Strings.laundry}',style: AppFonts.smallText.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w600,fontSize: 14),),
              Text('15 jul,2024',style: AppFonts.smallText.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w500,fontSize: 14),)

            ],
          ),
          Gap(MediaQuery.of(context).size.height*0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${Dd_Strings.total_weight}',style: AppFonts.smallText.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w600,fontSize: 14),),
              Text('15 jul,2024',style: AppFonts.smallText.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w500,fontSize: 14),)

            ],
          ),
          Gap(MediaQuery.of(context).size.height*0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${Dd_Strings.total_amount}',style: AppFonts.smallText.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w600,fontSize: 14),),
              Text('15 jul,2024',style: AppFonts.smallText.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w500,fontSize: 14),)

            ],
          ),
          Gap(MediaQuery.of(context).size.height*0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle_outline_rounded,color: Colors.green,size: 14,),
                  Gap(MediaQuery.of(context).size.width*0.01),
                  Text('${Dd_Strings.delivered}',style: AppFonts.smallText.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w500),)

                ],
              ),

            ],
          ),

        ],
      ),
    ),
  );
}
