import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class DeliveryBoyDashboard extends StatefulWidget {
  const DeliveryBoyDashboard({super.key});

  @override
  State<DeliveryBoyDashboard> createState() => _DeliveryBoyDashboardState();
}

class _DeliveryBoyDashboardState extends State<DeliveryBoyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
        title: Text('DELIVERY',),
      ),
    );
  }
}
