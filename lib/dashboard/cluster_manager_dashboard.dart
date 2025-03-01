import 'package:dd_shop/shop/shop_list_screen.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ClusterManagerDashboard extends StatefulWidget {
  const ClusterManagerDashboard({super.key});

  @override
  State<ClusterManagerDashboard> createState() => _ClusterManagerDashboardState();
}

class _ClusterManagerDashboardState extends State<ClusterManagerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
        leading: Container(),
      ),
      body: ShopListScreen(),
    );
  }
}
