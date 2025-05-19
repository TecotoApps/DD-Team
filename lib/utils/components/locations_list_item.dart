import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LocationsListItem extends StatelessWidget {
  final String? location;
  final String? landmark;
  final bool isSelected;
  LocationsListItem({super.key, this.location,this.landmark,this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 4, right: 0.0),
      child: Card(
        elevation: 2.0,
        shadowColor: AppColors.grey_dots,
        color: AppColors.white,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: isSelected?AppColors.appPrimaryColor:AppColors.grey_dots, width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Address : $location',
                                style: AppFonts.title.copyWith(fontSize: 14),
                              ),
                              Gap(10),
                              Text(
                                'Landmark : $landmark',
                                style: AppFonts.title.copyWith(fontSize: 14),
                              ),

                            ],
                          ),
                        ),
                        // Flexible(
                        //   flex: 1,
                        //   child: RoundedElevatedButton(
                        //     width: 120,
                        //     height: 40,
                        //     onPressed: () {},
                        //     buttonColor: AppColors.appSecondaryColor,
                        //     cornerRadius: 20,
                        //     textStyle:
                        //     AppFonts.smallText.copyWith(color: AppColors.white),
                        //     text: '${Dd_Strings.schedule_order}',
                        //   ),
                        // )
                      ],
                    ),
                    Gap(20),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Column(
                    //       children: [
                    //         // SvgPicture.asset('images/create_order.svg'),
                    //         // RoundedElevatedButton(
                    //         //     width: 100,
                    //         //     height: 40,
                    //         //     text: '${Dd_Strings.pricing}',
                    //         //     onPressed: (){},
                    //         //     cornerRadius: 20,
                    //         //     buttonColor: AppColors.white,
                    //         //     textStyle: AppFonts.smallText.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w600))
                    //       ],
                    //     ),
                    //     Gap(20),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             SvgPicture.asset('images/ic_marker.svg'),
                    //             Gap(10),
                    //             Text('address',style: AppFonts.smallText.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w500),)
                    //           ],
                    //         ),
                    //         Gap(10),
                    //         Row(
                    //           children: [
                    //             SvgPicture.asset('images/ic_call.svg'),
                    //             Gap(20),
                    //             Text('9876543210',style: AppFonts.smallText.copyWith(color: AppColors.intro_subtitle_color,fontWeight: FontWeight.w500),)
                    //           ],
                    //         ),
                    //
                    //       ],
                    //     )
                    //
                    //   ],
                    // )
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
