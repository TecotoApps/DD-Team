import 'package:dd_shop/hr/create_new_role.dart';
import 'package:dd_shop/hr/model/role_list_model.dart';
import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/utils/components/alertDialogue.dart';
import 'package:flutter/material.dart';

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
    print("this is role $role, this is description $description");
    bool res = await apiService.editRole(roleId,role, description);
    if(res){
      showAlertDialog(context, "Success", "Role Created successfullyy");
      Navigator.pop(context);
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
}

HRController hrController = HRController();