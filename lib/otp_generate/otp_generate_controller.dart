import 'package:dd_shop/dashboard/no_role_screen.dart';
import 'package:dd_shop/mpin/model/validate_mpin_model.dart';
import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/services/sharedPress.dart';
import 'package:flutter/material.dart';
import '../dashboard/Dashboard.dart';
import '../utils/components/alertDialogue.dart';
import 'otp_modal.dart';

class OTP_Controller {
  getEmployeeDetailsByPhoneNumber(mobile, BuildContext context) async {
    UserInfoModal employee = await apiService.getEmployeeDetailsByPhone(mobile);
    print("this is the employee details by phone $employee");
    if (employee.statusCode == 200) {
      sharedPress.saveData("EMPCODE", employee.payload?.employCode);
      sharedPress.saveData("EMPID", employee.payload?.employId);
    } else {
      showAlertDialog(context, 'Error', '${employee.message}');
    }
    return employee;
  }

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
    if (validateMpinModel?.payload != null) {
      if(validateMpinModel?.payload?.roles!=null){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
      else{
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NoRoleScreen()));
      }

    }
  }
}
OTP_Controller otp_controller = OTP_Controller();
