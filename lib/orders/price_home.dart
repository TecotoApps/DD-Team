import 'package:dd_shop/orders/piece_screen.dart';
import 'package:dd_shop/orders/weight_screen.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../utils/constants/app_fonts.dart';

class PriceScreen extends StatefulWidget {
  String? shopId;
  PriceScreen({required this.shopId});
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.appPrimaryColor,
          centerTitle: true,
          title: Text(
            'Price List',
            style: AppFonts.title.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.white),
          ),
          bottom: TabBar(
            labelColor: AppColors.white,
            dividerColor: AppColors.white,
            unselectedLabelColor: AppColors.textColor,
            indicatorColor: AppColors.appSecondaryColor,
            tabs: [
              Tab(
                text: "Per Kg",
              ),
              Tab(
                text: "Per Piece",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [WeightScreen(shopId: widget.shopId,),Pricing(shopId:widget.shopId)],
        ),
      ),
    );
  }
}
