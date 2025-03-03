import 'package:dd_shop/hr/hr_controller.dart';
import 'package:dd_shop/hr/model/role_list_model.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum COMINGFROM{
  CreateRole,
  EditRole
}

class CreateNewRole extends StatefulWidget {
  RolePayload? role;
  COMINGFROM comingFrom;
  CreateNewRole({super.key,this.role,required this.comingFrom}) {

  }

  @override
  State<CreateNewRole> createState() => _CreateNewRoleState();
}

class _CreateNewRoleState extends State<CreateNewRole> {

  TextEditingController newRoleController = TextEditingController();
  TextEditingController descritpionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if(widget.comingFrom == COMINGFROM.EditRole){
      setState(() {
        newRoleController.text = widget.role!.roles!;
        descritpionController.text =  widget.role!.description!;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.appPrimaryColor,
        title: Text('Create New Role'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:50.0,left: 20,right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            Text('Enter Role name',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            Gap(10),
            TextFieldCurvedEdges(
            controller: newRoleController,
            backgroundColor: AppColors.white,
            keyboardType: TextInputType.number,
            borderColor: AppColors.text_border_color,
            length: 13,
            borderRadius: 10,
           ),
           Gap(30),
           Text('Enter Description',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
           Gap(10),
           TextFieldCurvedEdges(
             controller: descritpionController,
             backgroundColor: AppColors.white,
             keyboardType: TextInputType.number,
             borderColor: AppColors.text_border_color,
             length: 13,
             borderRadius: 10,
           ),
          Gap(30),
           RoundedElevatedButton(
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height*0.05,
               text: widget.comingFrom ==COMINGFROM.EditRole?'Edit Role':'Create Role',
               onPressed: () async{
                 if(widget.comingFrom == COMINGFROM.CreateRole){
                   hrController.createNewRole(newRoleController.text,descritpionController.text , context);
                 }
                 else{
                   hrController.editRole(widget.role!.roleId!,newRoleController.text,descritpionController.text,context);
                 }

               },
               cornerRadius: 6.0,
               buttonColor: AppColors.appPrimaryColor,
               textStyle: AppFonts.subHeader
                   .copyWith(color: AppColors.white))
         ],
        ),
      ),
    );
  }
}
