import 'package:dd_shop/dashboard/dashboard_controller.dart';
import 'package:dd_shop/dashboard/switch_roles.dart';
import 'package:dd_shop/delivery/delivery_controller.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/enumss.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryBoyDashboard extends StatefulWidget {
  final List<UserRole>? roles;
  final String? shopId;
  const DeliveryBoyDashboard({super.key, this.roles, this.shopId});

  @override
  State<DeliveryBoyDashboard> createState() => _DeliveryBoyDashboardState();
}

class _DeliveryBoyDashboardState extends State<DeliveryBoyDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DashboardController _dashboardController = Get.put(DashboardController());
  final DeliveryController deliveryController = Get.put(DeliveryController());
  int _orderCount = 0;
  late Future _ordersFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _ordersFuture = _dashboardController.getDeliveryOrders(context);
  }

  Future<void> _refreshOrders() async {
    final refreshedFuture = _dashboardController.getDeliveryOrders(context);
    final refreshedData = await refreshedFuture;
    setState(() {
      _ordersFuture = Future.value(refreshedData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.appPrimaryColor,
        centerTitle: true,
        title: Text(
          'Orders Received ( $_orderCount )',
          style: AppFonts.title.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.appPrimaryColor,
              ),
              child: Text(
                'Delivery Agent',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.compare_arrows_rounded),
              title: Text(
                'Switch Account',
                style: TextStyle(
                  color: widget.roles!.length > 1 ? AppColors.textColor : AppColors.text_border_color,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                if (widget.roles!.length > 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SwitchRoles(roles: widget.roles, shopId: widget.shopId),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FutureBuilder(
            future: _ordersFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data?["payload"] == null) {
                  return Center(child: Text('Something Went Wrong'));
                } else {
                  final newCount = snapshot.data["payload"].length;
                  if (_orderCount != newCount) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _orderCount = newCount;
                      });
                    });
                  }
                  return RefreshIndicator(
                    onRefresh: _refreshOrders,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      child: ListView.builder(
                        itemCount: snapshot.data["payload"].length,
                        itemBuilder: (context, index) {
                          final order = snapshot.data["payload"][index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Card(
                              color: AppColors.white,
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Gap(20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Order - ${order['orderCode']}',
                                          style: AppFonts.title.copyWith(fontWeight: FontWeight.bold, color: AppColors.appSecondaryColor),
                                        ),
                                        Text(
                                          getSlotText(order['timeSlot']),
                                          style: AppFonts.smallText.copyWith(color: AppColors.appPrimaryColor),
                                        ),
                                      ],
                                    ),
                                    Gap(20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        order['orderStatus'] == "CREATED"?RoundedElevatedButton(
                                          width: MediaQuery.of(context).size.width * 0.4,
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          text: 'Pick up' ,
                                          onPressed: () async {
                                            if (order['orderStatus'] == "CREATED") {
                                              deliveryController.goToOrderPickUP(order, context);
                                            } else {
                                              deliveryController.changeOrderStatus(order, "COMPLETED", context);
                                            }
                                          },
                                          cornerRadius: 12.0,
                                          buttonColor: AppColors.appPrimaryColor,
                                          textStyle: AppFonts.title.copyWith(color: AppColors.white),
                                        ):order['orderStatus'] == "READYTODELIVER"?
                                        RoundedElevatedButton(
                                          width: MediaQuery.of(context).size.width * 0.4,
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          text: 'Delivery' ,
                                          onPressed: () async {

                                          },
                                          cornerRadius: 12.0,
                                          buttonColor: Colors.green,
                                          textStyle: AppFonts.title.copyWith(color: AppColors.white),
                                        ):Container(),
                                        IconButton(
                                          icon: Icon(Icons.directions, color: AppColors.appSecondaryColor),
                                          tooltip: 'Open in Google Maps',
                                          onPressed: () {
                                            print('this is lat : ${order['lat']}');
                                            print('this is lng : ${order['lng']}');
                                            // Replace with your launch URL logic
                                            final latitude = order['lat']; // example
                                            final longitude = order['lng']; // example
                                            final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                                            print('this is map url : $googleMapsUrl');
                                            launchUrl(Uri.parse(googleMapsUrl));
                                          },
                                        )
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

String getSlotText(String enumValue) {
  switch (enumValue) {
    case "EIGHTTOTEN":
      return "8am - 10am";
    case "TENTOTWELVE":
      return "10am - 12pm";
    case "TWELVETOTWO":
      return "12pm - 2pm";
    case "TWOTOFOUR":
      return "2pm - 4pm";
    case "FOURTOSIX":
      return "4pm - 6pm";
    case "SIXTOEIGHT":
      return "6pm - 8pm";
    default:
      return "Unknown Slot";
  }
}
