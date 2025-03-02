import 'package:dd_shop/hr/model/role_list_model.dart';
import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/utils/components/alertDialogue.dart';
import 'package:flutter/material.dart';

class HRController {

  createNewRole(String role,String description, context) async {
    bool res = await apiService.createNewRole(role, description);
    if(res){
      showAlertDialog(context, "Success", "Role Created successfullyy");
      Navigator.pop(context);
    }
    else{
      showAlertDialog(context, "Error", "Something went wrong please try again later");
    }
  }

   getAllRolesList(context) async{
    RoleListModel roleListModel = await apiService.getRolesList();
    return roleListModel;
  }

}

HRController hrController = HRController();