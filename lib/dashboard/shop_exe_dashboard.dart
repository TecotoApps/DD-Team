import 'package:dd_shop/dashboard/dashboard_controller.dart';
import 'package:dd_shop/dashboard/switch_roles.dart';
import 'package:dd_shop/delivery/delivery_controller.dart';
import 'package:dd_shop/orders/add_customer.dart';
import 'package:dd_shop/orders/order_process.dart';
import 'package:dd_shop/orders/order_screen.dart';
import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/enumss.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopExeDashboard extends StatefulWidget {
  final List<UserRole>? roles;
  final String? shopId;

  const ShopExeDashboard({super.key, this.roles, this.shopId});

  @override
  State<ShopExeDashboard> createState() => _ShopExeDashboardState();
}

class _ShopExeDashboardState extends State<ShopExeDashboard> {
  final DashboardController _dashboardController = Get.put(DashboardController());
  final DeliveryController deliveryController = Get.put(DeliveryController());

  late Future _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _fetchOrders();
    print('User Roles: ${widget.roles}');
    print('Shop ID: ${widget.shopId}');
  }

  Future _fetchOrders() {
    return _dashboardController.getOrdersList(
      '${widget.shopId}',
      context,
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _ordersFuture = _fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
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
        title: Text(''),
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
                'Shop Executive',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.compare_arrows_rounded),
              title: Text(
                'Switch Account',
                style: TextStyle(color: widget.roles!.length > 1 ? AppColors.textColor : AppColors.text_border_color),
              ),
              onTap: () {
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
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Add Customer'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCustomer(
                      shopId: '${widget.shopId}',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.appPrimaryColor,
        backgroundColor: AppColors.white,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: _ordersFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data?['payload'] == null) {
                return Center(child: Text('No Orders Received'));
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data?['payload'].length,
                    itemBuilder: (context, int index) {
                      final order = snapshot.data!['payload'][index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Card(
                          color: AppColors.white,
                          elevation: 2,
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Bag No. ${order['bagNo'] ?? 000}',
                                        style: AppFonts.title.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      getOrderStatusText(
                                        getOrderStatusFromString(order['orderStatus']),
                                        style: AppFonts.title.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Gap(10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Items ${order['totalItems'] ?? 0}',
                                        style: AppFonts.title.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Weight ${order['totalWeight']}',
                                        style: AppFonts.title.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
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
                                          'Ordered on ${order['orderDate'] ?? ''}',
                                          style: AppFonts.title.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Gap(10),
                                        Text(
                                          'Pickup Date: ${order['pickupDate'] ?? ''}',
                                          style: AppFonts.title.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Gap(10),
                                        Text(
                                          'Delivery Date: ${order['deliveryDate'] ?? ''}',
                                          style: AppFonts.title.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Gap(10),
                                        (
                                            getOrderStatusFromString(order['orderStatus']) == OrderStatus.PICKED ||
                                            getOrderStatusFromString(order['orderStatus']) == OrderStatus.PROCESS
                                        )
                                            ? Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: RoundedElevatedButton(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height * 0.05,
                                            text:getOrderStatusFromString(order['orderStatus']) == OrderStatus.PICKED? "Process Order":"Update Order",
                                            onPressed: () async {
                                              if(getOrderStatusFromString(order['orderStatus']) == OrderStatus.PICKED){
                                                await apiService.updateOrderStatus(order['orderId'], 'PROCESS');
                                              }
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context)=>OrderProcess(
                                                    index: index,
                                                    orderData: order,
                                                  )));

                                            },
                                            cornerRadius: 6.0,
                                            buttonColor: AppColors.appPrimaryColor,
                                            textStyle: AppFonts.title.copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
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
              return ListView(
                children: [Center(child: Text('No data'))],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.appPrimaryColor,
        child: Icon(Icons.directions_walk_rounded, color: AppColors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCustomer(
                shopId: '${widget.shopId}',
              ),
            ),
          );
        },
      ),
    );
  }
}

OrderStatus getOrderStatusFromString(String? status) {
  try {
    return OrderStatus.values.firstWhere(
          (e) => e.toString().split('.').last == status,
    );
  } catch (e) {
    return OrderStatus.CREATED; // Fallback/default value
  }
}