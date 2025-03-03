import 'package:dd_shop/dashboard/model/assign_role_model.dart';
import 'package:dd_shop/employee/model/employee_list_model.dart';
import 'package:dd_shop/hr/assign_role.dart';
import 'package:dd_shop/hr/create_new_role.dart';
import 'package:dd_shop/hr/model/role_list_model.dart';
import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/utils/components/alertDialogue.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HRController {

  createNewRole(String role,String description, context) async {
    print("this is role $role, this is description $description");
    bool res = await apiService.createNewRole(role, description);
    if(res){
      showAlertDialog(context, "Success", "Role Created successfullyy");
      Navigator.pop(context);
    }
    else{
      showAlertDialog(context, "Error", "Something went wrong please try again later");
    }
  }

  editRole(String roleId,String role,String description, context) async {
    print("THIS IS roleid $roleId this is role $role, this is description $description");
    bool res = await apiService.editRole(roleId,role, description);
    print("this is res $res");
    if(res){
      showAlertDialog(context, "Success", "Role Created successfullyy");
      // Navigator.pop(context);
    }
    else{
      showAlertDialog(context, "Error", "Something went wrong please try again later");
    }
  }

   Future<RoleListModel> getAllRolesList(context) async{
    RoleListModel roleListModel = await apiService.getRolesList();
    print("this is roles res $roleListModel");
    return roleListModel;
  }

  goToEditRole(context,payload){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewRole(role:payload, comingFrom: COMINGFROM.EditRole,)));
  }

  goToAssignRole(context,payload){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AssignRole(employeePayload: payload)));

  }

  assignRoleByHR(context,EmployeePayload employeeData, roles) async {
    print("this is roles assigning. $roles");
    DateTime today = DateTime.now(); // Get today's date
    String date = DateFormat('yyyy-MM-dd').format(today);
    AssignRolesModel assignRolesres = await apiService.assignRoles(assignDate: date,clusterName: "",description: "",employCode: employeeData.employCode,roles: roles,shopId: "",stopDate: "");
  if(assignRolesres.statusCode==201){
    showAlertDialog(context, "Success", "Role Created successfullyy");
  }
  else{
    showAlertDialog(context, "Error", "Role assign failed");
  }
  }
}

HRController hrController = HRController();