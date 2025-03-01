import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class NoRoleScreen extends StatefulWidget {
  const NoRoleScreen({super.key});

  @override
  State<NoRoleScreen> createState() => _NoRoleScreenState();
}

class _NoRoleScreenState extends State<NoRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(backgroundColor: AppColors.white,elevation: 0,),
      body: Center(child: Text('No Roles Found'),),
    );
  }
}
