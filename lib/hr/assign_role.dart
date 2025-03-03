import 'dart:ui';

import 'package:dd_shop/employee/model/employee_list_model.dart';
import 'package:dd_shop/hr/hr_controller.dart';
import 'package:dd_shop/hr/model/role_list_model.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AssignRole extends StatefulWidget {
  EmployeePayload employeePayload;
  AssignRole({super.key, required this.employeePayload});
  @override
  State<AssignRole> createState() => _AssignRoleState();
}

class _AssignRoleState extends State<AssignRole> {
  List<RolePayload>? rolesList;
  String? selectedRoleId;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    // Fetch the roles data
    RoleListModel roles = await hrController.getAllRolesList(context);
    setState(() {
      // Update the class-level rolesList directly
      rolesList = roles.payload;
      print("this is rolesList $rolesList");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.appPrimaryColor,
        title: Text('Assign New Role'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(50),
          Text('Assign role to the employee ${widget.employeePayload.employCode}',style: TextStyle(fontSize: 18),),
          Gap(20),
          Text("Name :  ${widget.employeePayload.employName}",style: TextStyle(fontSize: 18)),
          Gap(20),
          Row(
            children: [
              Text('Select Role :',style: TextStyle(fontSize: 18)),
              Gap(40),
              DropdownButton(
                value: selectedRoleId,
                hint: Text("Select Role"),
                onTap: (){
                  print("tapping");
                },
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRoleId = newValue;
                  });
                },
                items: rolesList?.map((RolePayload role) {
                  return DropdownMenuItem<String>(
                    value: role.roles,  // Set the roleId as the value
                    child: Text(role.roles ?? 'No Role'),  // Display the role name
                  );
                }).toList(),
              ),
            ],
          ),
          Gap(20),
          Gap(20),
          RoundedElevatedButton(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.05,
              text: 'Assign Role',
              onPressed: () async{
                hrController.assignRoleByHR(context,widget.employeePayload,selectedRoleId);
              },
              cornerRadius: 6.0,
              buttonColor: AppColors.appPrimaryColor,
              textStyle: AppFonts.subHeader
                  .copyWith(color: AppColors.white))
        ],
      ),
    );
  }
}
