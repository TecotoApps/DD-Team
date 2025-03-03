import 'package:dd_shop/dashboard/dashboard_controller.dart';
import 'package:dd_shop/employee/add_employee.dart';
import 'package:dd_shop/employee/model/employee_list_model.dart';
import 'package:dd_shop/hr/hr_controller.dart';
import 'package:dd_shop/hr/model/role_list_model.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AllRolesList extends StatelessWidget {
  final HRController _hrController =
  Get.put(HRController());


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: _hrController.getAllRolesList(context),
          builder: (BuildContext context,
              AsyncSnapshot<RoleListModel?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data?.payload == null) {
                return Center(child: Text('${snapshot.data?.message}'));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.payload?.length,
                    itemBuilder: (context, int index) {
                      final roles = snapshot.data!.payload![index];
                      return employeeListItem(context, roles);
                    });
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Text('no data');
            }
          });
  }

  Widget employeeListItem(BuildContext context, RolePayload payload) => Card(
    color: AppColors.white,
    elevation: 1.0,
    shadowColor: AppColors.grey_dots,
    shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.grey_dots, width: 1)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${payload.roles}',
                    style: AppFonts.title.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Gap(10),
                  Text(
                    '${payload.description}',
                    style: AppFonts.title.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '${payload.roles}',
                        style: AppFonts.title.copyWith(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      Gap(40),
                      InkWell(
                        onTap: (){
                            print('Edit role');
                            _hrController.goToEditRole(context,payload);
                        },
                        child:Text(
                          'Edit Role',
                          style: AppFonts.title.copyWith(
                              color: AppColors.appSecondaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Flexible(
              //   flex: 1,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       IconButton(
              //           onPressed: () {},
              //           icon: SvgPicture.asset('images/ic_edit.svg')),
              //       IconButton(
              //           onPressed: () {},
              //           icon: SvgPicture.asset('images/ic_delete.svg')),
              //     ],
              //   ),
              // )
            ],
          ),
        ],
      ),
    ),
  );

  getEmployeeList() async {
    await dashboardController.getEmployeeList();
  }
}
