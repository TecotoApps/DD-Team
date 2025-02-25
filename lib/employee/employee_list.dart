import 'package:dd_shop/utils/components/order_list_item.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: SvgPicture.asset('images/ic_back.svg'),
          onPressed: (){Navigator.pop(context);},
        ),
        title: Text('${Dd_Strings.order_details}',style: AppFonts.appBarText.copyWith(color: AppColors.appPrimaryColor),),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context,int index){
            return employeeListItem(context);
          }),
    );
  }

  Widget employeeListItem(BuildContext context)=>Container(
    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4.0),
    width: MediaQuery.of(context).size.width,
    child: Card(
      elevation: 2.0,
      shadowColor: AppColors.grey_dots,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.grey_dots, width: 1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employee Name',
                      style: AppFonts.title.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    Gap(10),
                    Text(
                      'Employee ID',
                      style: AppFonts.title.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    Gap(10),
                    Text(
                      'Employee Phone',
                      style: AppFonts.title.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ],
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('images/ic_edit.svg')),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('images/ic_delete.svg')),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
