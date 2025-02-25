import 'package:dd_shop/utils/components/order_list_item.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderPickup extends StatelessWidget {
  const OrderPickup({super.key});

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
        title: Text('${Dd_Strings.order_pickup}',style: AppFonts.appBarText.copyWith(color: AppColors.appPrimaryColor),),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context,int index){
        return OrderListItem(buttonOneText: '${Dd_Strings.order_pickup}',buttontwoText: '${Dd_Strings.cancel_order}',);
      }),
    );
  }
}
