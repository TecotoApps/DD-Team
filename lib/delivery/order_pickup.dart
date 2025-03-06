import 'package:dd_shop/dashboard/model/order_list_model.dart';
import 'package:dd_shop/delivery/delivery_controller.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddOrderPickupDetails extends StatefulWidget {
  final OrderPayload orderPayload;
  AddOrderPickupDetails({super.key,required this.orderPayload});

  @override
  State<AddOrderPickupDetails> createState() => _AddOrderPickupDetailsState();
}

class _AddOrderPickupDetailsState extends State<AddOrderPickupDetails> {
  TextEditingController bagNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.appPrimaryColor,
        title: Text('Add pickup details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20),
            Text("   Enter Bag Number"),
            TextFieldCurvedEdges(
              controller: bagNoController,
              backgroundColor: AppColors.white,
              keyboardType: TextInputType.text,
              borderColor: AppColors.appPrimaryColor,
            ),
            Gap(20),
            Text("   Enter weight"),
            TextFieldCurvedEdges(
              controller: bagNoController,
              backgroundColor: AppColors.white,
              keyboardType: TextInputType.text,
              borderColor: AppColors.appPrimaryColor,
            ),
            Gap(20),
            Text("   Enter number of peices"),
            TextFieldCurvedEdges(
              controller: bagNoController,
              backgroundColor: AppColors.white,
              keyboardType: TextInputType.text,
              borderColor: AppColors.appPrimaryColor,
            ),
            Gap(20),
            Text("   Enter pickup date"),
            TextFieldCurvedEdges(
              controller: bagNoController,
              backgroundColor: AppColors.white,
              keyboardType: TextInputType.text,
              borderColor: AppColors.appPrimaryColor,
            ),
            Gap(20),
            Text("   Pickup Time"),
            TextFieldCurvedEdges(
              controller: bagNoController,
              backgroundColor: AppColors.white,
              keyboardType: TextInputType.text,
              borderColor: AppColors.appPrimaryColor,
            ),
            Gap(20),
            RoundedElevatedButton(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                text:"Pickup" ,
                onPressed: () async {
                  deliveryController.changeOrderStatus(widget.orderPayload,'PICKED',context);
                },
                cornerRadius: 6.0,
                buttonColor: AppColors.appPrimaryColor,
                textStyle: AppFonts.title.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
