import 'package:dd_shop/dashboard/dashboard_controller.dart';
import 'package:dd_shop/employee/add_employee.dart';
import 'package:dd_shop/employee/model/employee_list_model.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EmployeeList extends StatelessWidget {
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEmployee()));
        },
        backgroundColor: AppColors.appSecondaryColor,
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      body: FutureBuilder(
          future: _dashboardController.getEmployeeList(),
          builder: (BuildContext context,
              AsyncSnapshot<EmployeeListModel?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data?.payload == null) {
                return Center(child: Text('${snapshot.data?.message}'));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.payload?.length,
                    itemBuilder: (context, int index) {
                      final employee = snapshot.data!.payload![index];
                      return employeeListItem(context, employee);
                    });
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Text('no data');
            }
          }),
    );
  }

  Widget employeeListItem(BuildContext context, Payload payload) => Card(
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
                        '${payload.employName}',
                        style: AppFonts.title.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Gap(10),
                      Text(
                        '${payload.employCode}',
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
                          Gap(10),
                          InkWell(
                            onTap: (){
                              if(payload.roles==null){
                                print('assign roles');
                              }
                              else{
                                print('change role');
                              }
                            },
                            child: payload.roles==null?Text(
                              'Assign Role',
                              style: AppFonts.title.copyWith(
                                  color: AppColors.appSecondaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ):Text(
                              'Change Role',
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
