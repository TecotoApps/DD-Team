import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../utils/constants/app_fonts.dart';

class AddShop extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDates;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
        title: Text('Add Employee',style: TextStyle(
            color: AppColors.textColor,
            fontSize: 20,
            fontFamily: 'OpenSansSemiBold')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Employee Name',style: AppFonts.title.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 14),),
            Gap(8),
            TextFieldCurvedEdges(controller: nameController,
                backgroundColor: Colors.white,
                borderRadius: 8,
                keyboardType: TextInputType.name, borderColor: AppColors.card_border_color),
            Gap(8),
            Text('Phone Number',style: AppFonts.title.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 14),),
            Gap(8),
            TextFieldCurvedEdges(controller: phoneController,
                backgroundColor: Colors.white,
                borderRadius: 8,
                keyboardType: TextInputType.number, borderColor: AppColors.card_border_color),
            Gap(8),
            Text('Email',style: AppFonts.title.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 14),),
            Gap(8),
            TextFieldCurvedEdges(controller: emailController,
                backgroundColor: Colors.white,
                borderRadius: 8,
                keyboardType: TextInputType.emailAddress, borderColor: AppColors.card_border_color),
            Gap(8),
            Text('Description',style: AppFonts.title.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 14),),
            Gap(8),
            TextFieldCurvedEdges(controller: emailController,
                backgroundColor: Colors.white,
                borderRadius: 8,
                keyboardType: TextInputType.text, borderColor: AppColors.card_border_color),
            Gap(8),

            Text('Joining Date',style: AppFonts.title.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 14),),
            Gap(8),
            Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedDates != null ? DateFormat('yyyy-MM-dd').format(selectedDates!) : 'Select Date'),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.date_range,color: AppColors.appPrimaryColor,))
                  ],
                ),
              ),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.card_border_color, width: 1)),

            ),
            Gap(8),

            Spacer(),
            RoundedElevatedButton(
              width: MediaQuery.of(context).size.width, height: 40,
              cornerRadius: 10,buttonColor: AppColors.appSecondaryColor,
              onPressed: (){

              },
              text:Dd_Strings.submit_button_text,
              textStyle: AppFonts.title.copyWith(color: Colors.white),
            ),
            Gap(8),


          ],
        ),
      ),
    );
  }
}
