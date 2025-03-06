import 'package:dd_shop/dashboard/dashboard_controller.dart';
import 'package:dd_shop/delivery/delivery_controller.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class DeliveryBoyDashboard extends StatefulWidget {
  const DeliveryBoyDashboard({super.key});

  @override
  State<DeliveryBoyDashboard> createState() => _DeliveryBoyDashboardState();
}

class _DeliveryBoyDashboardState extends State<DeliveryBoyDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DashboardController _dashboardController = Get.put(DashboardController());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.appPrimaryColor,
        title: Text('Delivery Boy'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FutureBuilder(
            future: _dashboardController.getDeliveryOrders(context),
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
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gap(20),
                                  Text(
                                    'OrderID. ${order['orderId']}',
                                    style: AppFonts.title.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Gap(20),
                                  Row(
                                    children: [
                                      RoundedElevatedButton(
                                          width: MediaQuery.of(context).size.width*0.4,
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          text:order['orderStatus'] == "CREATED"? 'Pick up': "Complete Order" ,
                                          onPressed: () async {
                                            if(order['orderStatus'] == "CREATED"){
                                              deliveryController.goToOrderPickUP(order,context);
                                            }
                                            else{
                                              deliveryController.changeOrderStatus(order, "COMPLETED", context);
                                            }

                                          },
                                          cornerRadius: 6.0,
                                          buttonColor: order['orderStatus'] == "CREATED"?AppColors.appPrimaryColor:Colors.green,
                                          textStyle: AppFonts.title.copyWith(
                                              color: AppColors.white, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  Gap(20),
                                ],
                              ),
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
          Container(),
        ],
      ),
    );
  }
}
