import 'package:dd_shop/orders/current_order.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'order_history.dart';

class ShopOrderTab extends StatelessWidget {
  const ShopOrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: false,
          title: Text(
            '${Dd_Strings.shop_order}',
            style:
            AppFonts.subHeader.copyWith(color: AppColors.appPrimaryColor),
          ),
          leading: IconButton(
            icon: SvgPicture.asset('images/ic_back.svg'),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            labelStyle: AppFonts.title.copyWith(
                color: AppColors.appPrimaryColor,
                fontWeight: FontWeight.w600),
            unselectedLabelColor: AppColors.intro_subtitle_color,
            indicatorColor: AppColors.appPrimaryColor,
            unselectedLabelStyle: AppFonts.title.copyWith(
                color: AppColors.intro_subtitle_color,
                fontWeight: FontWeight.w600),
            labelColor: AppColors.appPrimaryColor,

            tabs: [
              Tab(text: '${Dd_Strings.current_order}'),
              Tab(text: '${Dd_Strings.order_histroy}'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CurrentOrder(),
            OrderHistory()
          ],
        ),
      ),
    );
  }
}
