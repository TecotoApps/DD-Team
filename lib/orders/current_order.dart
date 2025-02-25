import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';


class CurrentOrder extends StatelessWidget {
  const CurrentOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset('images/ic_marker.svg'),
                Gap(MediaQuery.of(context).size.width * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'address',
                      style: AppFonts.title
                          .copyWith(color: AppColors.intro_subtitle_color),
                    ),
                    Gap(MediaQuery.of(context).size.height * 0.005),
                    Text(
                      'address',
                      style: AppFonts.title
                          .copyWith(color: AppColors.intro_subtitle_color),
                    ),
                    Gap(MediaQuery.of(context).size.height * 0.005),
                    Text(
                      '${Dd_Strings.estimated_pickup_time} - ',
                      style: AppFonts.title.copyWith(
                          color: AppColors.intro_subtitle_color,
                          fontWeight: FontWeight.w600),
                    ),
                    Gap(MediaQuery.of(context).size.height * 0.005),
                    Text(
                      '${Dd_Strings.order_id}',
                      style: AppFonts.title.copyWith(
                          color: AppColors.intro_subtitle_color,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
            Gap(MediaQuery.of(context).size.height * 0.02),
            Text(
              '${Dd_Strings.order_tracking}',
              style: AppFonts.title.copyWith(
                  color: AppColors.intro_subtitle_color,
                  fontWeight: FontWeight.w600),
            ),
            Gap(MediaQuery.of(context).size.height * 0.02),
            OrderTrackerZen(
              text_primary_color: AppColors.intro_subtitle_color,
              text_secondary_color: Colors.grey,
              animation_duration: 20,
              background_color: AppColors.grey_dots,
              // success_color: Colors.green,
              isShrinked: true,
              tracker_data: [
                TrackerData(
                  title: '${Dd_Strings.order_placed}',
                  date: "",
                  tracker_details: [],
                ),
                TrackerData(
                  title: '${Dd_Strings.pickup_partner}',
                  date: "",
                  tracker_details: [],
                ),
                TrackerData(
                  title: '${Dd_Strings.picked_up}',
                  date: "",
                  tracker_details: [],
                ),
                TrackerData(
                  title: '${Dd_Strings.laundry_processing}',
                  date: "",
                  tracker_details: [],
                ),
                TrackerData(
                  title: '${Dd_Strings.ready_for_delivery}',
                  date: "",
                  tracker_details: [],
                ),
                TrackerData(
                  title: '${Dd_Strings.delivered}',
                  date: "",
                  tracker_details: [],
                ),
                TrackerData(
                  title: '${Dd_Strings.completed}',
                  date: "",
                  tracker_details: [],
                ),
              ],
            ),
            Card(
              elevation: 2.0,
              shadowColor: AppColors.grey_dots,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.grey_dots, width: 1)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 60,
                            height: 60,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: AppColors.appPrimaryColor),
                            child: SvgPicture.asset(
                              'images/ic_person.svg',
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: AppFonts.title.copyWith(
                                  color: AppColors.intro_subtitle_color),
                            ),
                            Gap(MediaQuery.of(context).size.height * 0.005),
                            Text(
                              'Delivery Partner',
                              style: AppFonts.title.copyWith(
                                  color: AppColors.intro_subtitle_color),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: AppColors.grey_dots),
                        child: SvgPicture.asset(
                          'images/ic_call.svg',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(MediaQuery.of(context).size.height * 0.02),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 2.0,
                shadowColor: AppColors.grey_dots,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: AppColors.grey_dots, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${Dd_Strings.payment_mode}',
                        style: AppFonts.title.copyWith(
                            color: AppColors.intro_subtitle_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Gap(MediaQuery.of(context).size.height * 0.01),
                      Row(
                        children: [
                          Text(
                            '${Dd_Strings.amount}',
                            style: AppFonts.title.copyWith(
                                color: AppColors.intro_subtitle_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Gap(MediaQuery.of(context).size.width*0.02),
                          RoundedElevatedButton(
                              width: MediaQuery.of(context).size.width*0.6,
                              height: MediaQuery.of(context).size.height*0.01,
                              text: 'Total',
                              onPressed: (){},
                              cornerRadius: 10,
                              buttonColor: AppColors.appSecondaryColor,
                              textStyle: AppFonts.title.copyWith(color: AppColors.white,fontWeight: FontWeight.w600,fontSize: 14))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
