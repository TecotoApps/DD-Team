import 'package:dd_shop/dashboard/dashboard_controller.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopExeDashboard extends StatelessWidget {
  final DashboardController _dashboardController = Get.put(DashboardController());

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
        future: _dashboardController.getOrdersList('ab71de3f-51c4-4e29-b956-81947dd65d94', context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data?["payload"] == null) {
              return Center(child: Text('Something Went Wrong'));
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: ListView.builder(
                  itemCount: snapshot.data?["payload"].length,
                  itemBuilder: (context, int index) {
                    final order = snapshot.data!["payload"][index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Card(
                        color: AppColors.white,
                        elevation: 2,
                        child: ExpansionTile(

                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bag No. ${order['bagNo']}',
                                style: AppFonts.title.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Gap(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Items ${order['totalItems']}',
                                    style: AppFonts.title.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                                  ),
                                  Text(
                                    'Weight ${order['totalWeight']}',
                                    style: AppFonts.title.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${order['orderStatus']}',
                                    style: AppFonts.title.copyWith(
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ordered on ${order['orderDate']}',
                                      style: AppFonts.title.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                                    ),
                                    Gap(10),
                                    Text(
                                      'Pickup Date: ${order['pickupDate']}',
                                      style: AppFonts.title.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                                    ),
                                    Gap(10),
                                    Text(
                                      'Delivery Date: ${order['deliveryDate']}',
                                      style: AppFonts.title.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                                    ),
                                    Gap(10),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}