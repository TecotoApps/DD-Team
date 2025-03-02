import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ShopExeDashboard extends StatefulWidget {
  const ShopExeDashboard({super.key});

  @override
  State<ShopExeDashboard> createState() => _ShopExeDashboardState();
}

class _ShopExeDashboardState extends State<ShopExeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
        leading: Container(),
        title: Text('SHOP'),
      ),
    );
  }
}
