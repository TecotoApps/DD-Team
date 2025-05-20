import 'package:dd_shop/dashboard/Dashboard.dart';
import 'package:dd_shop/dashboard/cluster_manager_dashboard.dart';
import 'package:dd_shop/dashboard/delivery_boy_dashboard.dart';
import 'package:dd_shop/dashboard/hr_dashboard.dart';
import 'package:dd_shop/dashboard/no_role_screen.dart';
import 'package:dd_shop/dashboard/shop_exe_dashboard.dart';
import 'package:dd_shop/mpin/model/validate_mpin_model.dart';
import 'package:dd_shop/mpin/verify_mpin.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${employee?.message}')),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EnterMpin()));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${employee?.message}')),
      );
    }
    // if (employee?.payload != null) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => Dashboard()));
    // }


    // const employeeCode = ;
// const employeeId =;

  }

  validateMpin(mpin, context) async {
    final empcode = await sharedPress.getData("EMPCODE");
    final empid = await sharedPress.getData("EMPID");
    await sharedPress.saveData("EMPLOGIN","LOGGEDIN");
    print("this is empcode $empcode");
    print("this is mpin $mpin");
    ValidateMpinModel? validateMpinModel = await apiService.validateMpin(empcode, mpin);
    if(validateMpinModel?.statusCode == 200)
      {
        final payload = validateMpinModel?.payload;
        List<UserRole> roles = [];
        String? shopId;
        if (payload != null && payload.isNotEmpty) {
          for(int i=0;i<payload.length;i++){
            roles.add(payload[i].roles!);
            if(payload[i].shopId!=null){
              shopId = payload[i].shopId;
            }
          }

            print('this is roles added : $roles');
            switch (validateMpinModel?.payload?[0].roles){
              case UserRole.SHOPEXECUTIVE:
                navigate(ShopExeDashboard(roles: roles,shopId: shopId,),context);
                break;
              case UserRole.HR:
                navigate(HrDashboard(),context);
                break;
              case UserRole.CLUSTERMANAGER:
                navigate(ClusterManagerDashboard(),context);
                break;
              case UserRole.DELIVERBOY:
                navigate(DeliveryBoyDashboard(roles: roles,shopId: shopId),context);
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


}

MPINController mpinController = MPINController();
void navigate(Widget screen,context,{bool pushReplacement = false}){
  if(pushReplacement){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>screen), (Route<dynamic> route) => false,);

  }
  else{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>screen));

  }
}