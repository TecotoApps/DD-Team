import 'package:dd_shop/employee/employee_list.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class RolesList extends StatefulWidget {
  const RolesList({super.key});

  @override
  State<RolesList> createState() => _RolesListState();
}

class _RolesListState extends State<RolesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.appPrimaryColor,
        title: Text('Roles List'),
      ),
      body: ListView(
        children: [
          EmployeeList()
        ],
      ),
    );
  }
}
