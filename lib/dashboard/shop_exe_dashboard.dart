import 'package:dd_shop/dashboard/dashboard_controller.dart';
import 'package:dd_shop/orders/model/shop_order_model.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopExeDashboard extends StatelessWidget {
  final DashboardController _dashboardController =
  Get.put(DashboardController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
        leading: Container(),
        title: Text('SHOP EXECUTIVE'),
      ),
      body: FutureBuilder(
          future: _dashboardController.getOrdersList('ab71de3f-51c4-4e29-b956-81947dd65d94',context),
          builder: (BuildContext context,
              AsyncSnapshot snapshot){
            print('this is snapshot : ${snapshot.data["payload"]}');
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data?["payload"] == null) {
                return Center(child: Text('the response is null'));
              } else {
                return Container(
                  height: 500,
                  child: ListView.builder(
                      itemCount: snapshot.data?["payload"].length,
                      itemBuilder: (context, int index) {
                        final employee = snapshot.data!["payload"]![index];
                        print("this is order employee $employee");
                        return employeeListItem(context, employee);
                      }),
                );
              }
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Text('no data');
            }
          }),
    );
  }

  Widget employeeListItem(BuildContext context, OrderPayload payload) => Card(
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
                    '${payload.amount}',
                    style: AppFonts.title.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Gap(10),
                  Text(
                    '${payload.orderStatus}',
                    style: AppFonts.title.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '${payload.totalWeight}',
                        style: AppFonts.title.copyWith(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      Gap(10),

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
}
