
import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/services/sharedPress.dart';
import 'package:flutter/material.dart';

import '../dashboard/Dashboard.dart';
import '../utils/components/alertDialogue.dart';
import 'otp_modal.dart';

class OTP_Controller {
getEmployeeDetailsByPhoneNumber(mobile,BuildContext context) async{
    UserInfoModal employee = await apiService.getEmployeeDetailsByPhone(mobile);
    print("this is the employee details by phone $employee");
    if(employee.statusCode==200){
      sharedPress.saveData("EMPCODE", employee.payload?.employCode);
      sharedPress.saveData("EMPID", employee.payload?.employId);
    }else{
      showAlertDialog(context,'Error','${employee.message}');
    }
    return employee;
  }

createMPIN(mpin,context) async{
  final empcode = await sharedPress.getData("EMPCODE");
  final empid = await sharedPress.getData("EMPID");
  print("this is empcode $empcode");
  print("this is mpin $mpin");
  EmployeePayload? employee = await apiService.generateMPIN(empcode,mpin);
 if(employee != null){
   Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard() ));
 }
  // const employeeCode = ;
// const employeeId =;

}
  // getUserDetails(mobile) async {
  //   var result = await apiService.getUserDetails(mobile);
  //   print("this is the result of getuserByDetails $result");
  //   return result;
  // }
}

OTP_Controller otp_controller = OTP_Controller();
