import 'package:dd_shop/dashboard/Dashboard.dart';
import 'package:dd_shop/dashboard/cluster_manager_dashboard.dart';
import 'package:dd_shop/dashboard/delivery_boy_dashboard.dart';
import 'package:dd_shop/dashboard/hr_dashboard.dart';
import 'package:dd_shop/dashboard/no_role_screen.dart';
import 'package:dd_shop/dashboard/shop_exe_dashboard.dart';
import 'package:dd_shop/mpin/model/validate_mpin_model.dart';
import 'package:dd_shop/otp_generate/otp_modal.dart';
import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/services/sharedPress.dart';
import 'package:dd_shop/utils/constants/enumss.dart';
import 'package:flutter/material.dart';

class MPINController {
  createMPIN(mpin, context) async {
    final empcode = await sharedPress.getData("EMPCODE");
    final empid = await sharedPress.getData("EMPID");
    print("this is empcode $empcode");
    print("this is mpin $mpin");
    UserInfoModal? employee = await apiService.generateMPIN(empcode, mpin);
    if(employee?.statusCode==200){
      await sharedPress.saveData("EMPLOGIN","LOGGEDIN");
    }
    if (employee?.payload != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }


    // const employeeCode = ;
// const employeeId =;

  }

  validateMpin(mpin, context) async {
    final empcode = await sharedPress.getData("EMPCODE");
    final empid = await sharedPress.getData("EMPID");
    print("this is empcode $empcode");
    print("this is mpin $mpin");
    ValidateMpinModel? validateMpinModel = await apiService.validateMpin(empcode, mpin);
    if(validateMpinModel?.statusCode == 200)
      {
        if (validateMpinModel?.payload != null) {
            switch (validateMpinModel?.payload?[0].roles){
              case UserRole.SHOPEXECUTIVE:
                navigate(ShopExeDashboard(),context);
                break;
              case UserRole.HR:
                navigate(HrDashboard(),context);
                break;
              case UserRole.CLUSTERMANAGER:
                navigate(ClusterManagerDashboard(),context);
                break;
              case UserRole.DELIVERBOY:
                navigate(DeliveryBoyDashboard(),context);
                break;
              case UserRole.ACCOUNTANT:
                //
                break;
              case null:
                navigate(NoRoleScreen(),context);
                break;
            }
        }
      }

  }

  void navigate(Widget screen,context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>screen));
  }
}

MPINController mpinController = MPINController();