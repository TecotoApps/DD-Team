import 'package:dd_shop/dashboard/cluster_manager_dashboard.dart';
import 'package:dd_shop/dashboard/delivery_boy_dashboard.dart';
import 'package:dd_shop/dashboard/hr_dashboard.dart';
import 'package:dd_shop/dashboard/no_role_screen.dart';
import 'package:dd_shop/mpin/mpin_controller.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/enumss.dart';
import 'package:flutter/material.dart';

import 'shop_exe_dashboard.dart';

class SwitchRoles extends StatefulWidget {
  final List<UserRole>? roles;
  final String? shopId;

  const SwitchRoles({super.key, this.roles, this.shopId});

  @override
  State<SwitchRoles> createState() => _SwitchRolesState();
}

class _SwitchRolesState extends State<SwitchRoles> {
  @override
  Widget build(BuildContext context) {
    final roleItems = widget.roles ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
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
        centerTitle: true,
        title: Text('Switch Account',style: AppFonts.title.copyWith(color: AppColors.white),),
      ),
      body: Center(
        child: roleItems.isEmpty
            ? Text('No roles available')
            : SizedBox(
          width: 300,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            children: roleItems.map((role) {
              return GestureDetector(
                onTap: () {
                  // TODO: Implement role switch navigation here
                  navigateToSelectedRole(role);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.appSecondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  child: Text(
                    userRoleToString(role),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  navigateToSelectedRole(UserRole role){
    switch (role){
      case UserRole.SHOPEXECUTIVE:
        navigate(ShopExeDashboard(roles: widget.roles,shopId: widget.shopId,),context,pushReplacement: true);
        break;
      case UserRole.HR:
        navigate(HrDashboard(),context,pushReplacement: true);
        break;
      case UserRole.CLUSTERMANAGER:
        navigate(ClusterManagerDashboard(),context,pushReplacement: true);
        break;
      case UserRole.DELIVERBOY:
        navigate(DeliveryBoyDashboard(roles: widget.roles,shopId: widget.shopId,),context,pushReplacement: true);
        break;
      case UserRole.ACCOUNTANT:
      //
        break;
    }
  }
  userRoleToString(UserRole role){
    switch (role){
      case UserRole.SHOPEXECUTIVE:
        return 'Shop Executive';
      case UserRole.HR:
        return 'HR';
      case UserRole.CLUSTERMANAGER:
        return 'Cluster Manager';
      case UserRole.DELIVERBOY:
        return 'Delivery Agent';
      case UserRole.ACCOUNTANT:
        return 'Accountant';
    }
  }
}
