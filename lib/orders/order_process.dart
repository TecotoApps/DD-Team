import 'package:dd_shop/dashboard/shop_exe_dashboard.dart';
import 'package:dd_shop/orders/order_screen.dart';
import 'package:dd_shop/orders/orders_controller.dart';
import 'package:dd_shop/orders/price_home.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderProcess extends StatefulWidget {
  final int? index;
  final Map<String, dynamic>? orderData;

  const OrderProcess({Key? key, this.index, this.orderData}) : super(key: key);

  @override
  State<OrderProcess> createState() => _OrderProcessState();
}

class _OrderProcessState extends State<OrderProcess> {
  List<Map<String, dynamic>> orderItems = [];
  List<TextEditingController> priceControllers = [];
  TextEditingController totalItemsController = TextEditingController();
  TextEditingController totalWeightController = TextEditingController();
  double amount = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.orderData?['orderItems'] != null) {
      orderItems = List<Map<String, dynamic>>.from(widget.orderData!['orderItems']);
      priceControllers = List.generate(orderItems.length, (index) {
        final controller = TextEditingController();
        if (orderItems[index]['price'] != null) {
          controller.text = orderItems[index]['price'].toString();
        }
        return controller;
      });

      totalItemsController.text = widget.orderData!['totalItems'].toString();
      totalWeightController.text = widget.orderData!['totalWeight'].toString();
      amount = orderController.addAmount(orderItems);
    }
  }

  @override
  void dispose() {
    for (var controller in priceControllers) {
      controller.dispose();
    }
    totalItemsController.dispose();
    totalWeightController.dispose();
    super.dispose();
  }

  Widget _buildOrderItemRow(int index) {
    final item = orderItems[index];
    final quantity = item['nos'] ?? 0;
    final price = item['price'] ?? 0.0;
    final total = (quantity is num && price is num) ? quantity * price : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "${item['itemName']}",
              style: AppFonts.title,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextFieldCurvedEdges(
              controller: priceControllers[index],
              backgroundColor: AppColors.white,
              keyboardType: TextInputType.number,
              borderColor: AppColors.text_border_color,
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  item['price'] = double.tryParse(value);
                  amount = orderController.addAmount(orderItems);
                });
              },
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Text(
              'x$quantity',
              textAlign: TextAlign.end,
              style: AppFonts.title,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              '₹${total.toStringAsFixed(2)}',
              textAlign: TextAlign.end,
              style: AppFonts.title.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
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
          'Process Order',
          style: AppFonts.title.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.white),
        ),
      ),
      body: orderItems.isEmpty
          ? Center(child: Text("No items found", style: AppFonts.smallText))
          : Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${Dd_Strings.bag_number} : ${widget.orderData!['bagNo']}',
                    style: AppFonts.title.copyWith(fontWeight: FontWeight.bold)),
                getOrderStatusText(
                  getOrderStatusFromString(widget.orderData!['orderStatus']),
                  style: AppFonts.title.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PriceScreen(shopId: widget.orderData!['shopId']),
                      ),
                    );
                  },
                  child: Text(
                    'Pricing',
                    style: AppFonts.title.copyWith(
                      color: AppColors.appPrimaryColor,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${widget.orderData!['pricingType'].toString().toLowerCase().replaceFirstMapped(RegExp(r'^[a-z]'), (match) => match.group(0)!.toUpperCase())} Type',
                  style: AppFonts.title.copyWith(fontWeight: FontWeight.bold, color: AppColors.appPrimaryColor),
                ),
              ],
            ),
            Gap(20),
            Divider(color: AppColors.text_border_color, height: 1),
            Gap(10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                itemCount: orderItems.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => _buildOrderItemRow(index),
              ),
            ),
            Gap(10),
            Divider(color: AppColors.text_border_color, height: 1),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Items :', style: AppFonts.title),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: totalItemsController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                  ),
                )
              ],
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Weight (in Kgs) : ', style: AppFonts.title),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: totalWeightController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                  ),
                )
              ],
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Amount :', style: AppFonts.title),
                Text(amount.toStringAsFixed(2), style: AppFonts.title),

              ],
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('GST :', style: AppFonts.title),
                Text(orderController.getGSTAmount(orderItems).toStringAsFixed(2), style: AppFonts.title)
              ],
            ),
            Gap(10),
            Divider(color: AppColors.text_border_color),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payable Amount :', style: AppFonts.title),
                Text('${orderController.getTotalPayableAmount(orderItems).toStringAsFixed(2)}', style: AppFonts.title)
              ],
            ),
            Gap(10),
            Divider(color: AppColors.text_border_color),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: RoundedElevatedButton(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      text: 'Update',
                      onPressed: () {
                        // Optional: Save/update order using updated amount
                      },
                      cornerRadius: 10,
                      buttonColor: AppColors.appSecondaryColor,
                      textStyle: AppFonts.title.copyWith(color: AppColors.white),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: RoundedElevatedButton(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      text: 'Delivery',
                      onPressed: () {},
                      cornerRadius: 10,
                      buttonColor: Colors.green,
                      textStyle: AppFonts.title.copyWith(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}