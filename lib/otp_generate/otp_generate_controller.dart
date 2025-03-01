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
    EmployeePayload? employee = await apiService.generateMPIN(empcode, mpin);
    if (employee != null) {
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
    if (validateMpinModel != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }
}
OTP_Controller otp_controller = OTP_Controller();
