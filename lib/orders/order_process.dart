// Place your imports here
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/orders/price_home.dart';
import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/orders/orders_controller.dart';

class OrderProcess extends StatefulWidget {
  final int? index;
  final Map<String, dynamic>? orderData;
  final String? orderId;

  const OrderProcess({Key? key, this.index, this.orderData, this.orderId}) : super(key: key);

  @override
  State<OrderProcess> createState() => _OrderProcessState();
}

class _OrderProcessState extends State<OrderProcess> {
  List<Map<String, dynamic>> selectedExtras = [];
  bool isOthersSelected = false;
  String? selectedOtherService;
  List<String> otherServices = ["Strain Removal", "Extra Iron", "Fold"];
  Map<String, List<TextEditingController>> bagPriceControllers = {};
  Map<String, double> bagAmounts = {};
  double extraCharges = 0.0;

  @override
  void initState() {
    super.initState();
    for (var bag in widget.orderData!['orderBags']) {
      final bagNo = bag['bagNo'];
      final items = List<Map<String, dynamic>>.from(bag['orderItems']);
      bagPriceControllers[bagNo] = List.generate(items.length, (index) {
        final controller = TextEditingController();
        if (items[index]['price'] != null) {
          controller.text = items[index]['price'].toString();
        }
        return controller;
      });
      bagAmounts[bagNo] = orderController.addAmount(items);
    }
  }

  Widget _buildOrderItemRow(int index, Map<String, dynamic> item, TextEditingController controller, String bagNo) {
    final quantity = item['nos'] ?? 0;
    final price = item['price'] ?? 0.0;
    final total = (quantity is num && price is num) ? quantity * price : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: Text(item['itemName'], style: AppFonts.title)),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextFieldCurvedEdges(
              controller: controller,
              backgroundColor: AppColors.white,
              keyboardType: TextInputType.number,
              borderColor: AppColors.text_border_color,
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  item['price'] = double.tryParse(value);
                  final items = List<Map<String, dynamic>>.from(widget.orderData!['orderBags']
                      .firstWhere((bag) => bag['bagNo'] == bagNo)['orderItems']);
                  bagAmounts[bagNo] = orderController.addAmount(items);
                });
              },
            ),
          ),
          SizedBox(width: 8),
          Expanded(flex: 1, child: Text('x $quantity', textAlign: TextAlign.end, style: AppFonts.title)),
          SizedBox(width: 8),
          Expanded(flex: 2, child: Text('₹${total.toStringAsFixed(2)}', textAlign: TextAlign.end, style: AppFonts.title)),
        ],
      ),
    );
  }

  Widget _buildExtraItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...selectedExtras.map((extra) {
          final controller = TextEditingController(text: extra['price']?.toString() ?? '');
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(flex: 2, child: Text(extra['itemName'], style: AppFonts.title)),
                  SizedBox(width: 8),
                  Flexible(
                    flex: 1,
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() {
                          extra['price'] = double.tryParse(val);
                          extraCharges = orderController.addAmount(selectedExtras);
                        });
                      },
                      decoration: InputDecoration(hintText: "Price", isDense: true, border: OutlineInputBorder()),
                    ),
                  )
                ],
              ),
              Gap(10)
            ],
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    extraCharges = orderController.addAmount(selectedExtras);
    double totalAmount = bagAmounts.values.fold(0.0, (a, b) => a + b);
    double totalWithExtras = totalAmount + extraCharges;
    double gstAmount = orderController.getGSTAmount(selectedExtras); // GST only for extras
    double totalPayable = totalWithExtras + gstAmount;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.appPrimaryColor,
        centerTitle: true,
        title: Text('Process Order', style: AppFonts.title.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(12))),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ...widget.orderData!['orderBags'].map<Widget>((bag) {
              final bagNo = bag['bagNo'];
              final orderItems = List<Map<String, dynamic>>.from(bag['orderItems']);
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                color: AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.appSecondaryColor.withOpacity(0.4),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        child: Text("Bag No: $bagNo", style: AppFonts.title.copyWith(fontWeight: FontWeight.bold))),
                    Gap(8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        itemCount: orderItems.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => _buildOrderItemRow(index, orderItems[index], bagPriceControllers[bagNo]![index], bagNo),
                      ),
                    ),

                  ],
                ),
              );
            }).toList(),
            Gap(10),
            // Text('Subtotal: ₹${bagAmounts[bagNo]!.toStringAsFixed(2)}', style: AppFonts.title),
            Divider(),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: isOthersSelected,
              activeColor: AppColors.appPrimaryColor,
              title: Text('Other Extra Charges', style: AppFonts.title.copyWith(fontWeight: FontWeight.bold, color: AppColors.appPrimaryColor)),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (val) => setState(() => isOthersSelected = val ?? false),
            ),
            if (isOthersSelected) ...[
              DropdownButton<String>(
                value: selectedOtherService,
                hint: Text("Select Extra Service"),
                items: otherServices.map((item) => DropdownMenuItem<String>(value: item, child: Text(item))).toList(),
                onChanged: (value) {
                  if (value != null && !selectedExtras.any((e) => e['itemName'] == value)) {
                    setState(() {
                      selectedOtherService = value;
                      selectedExtras.add({"itemName": value, "price": 0.0, "nos": 1});
                    });
                  }
                },
              ),
              _buildExtraItems(),
            ],
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Total Amount:', style: AppFonts.title),
              Text('₹${totalAmount.toStringAsFixed(2)}', style: AppFonts.title),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Extra Charges:', style: AppFonts.title),
              Text('₹${extraCharges.toStringAsFixed(2)}', style: AppFonts.title),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('GST:', style: AppFonts.title),
              Text('₹${gstAmount.toStringAsFixed(2)}', style: AppFonts.title),
            ]),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Total Payable:', style: AppFonts.title.copyWith(fontWeight: FontWeight.bold)),
              Text('₹${totalPayable.toStringAsFixed(2)}', style: AppFonts.title.copyWith(fontWeight: FontWeight.bold)),
            ]),
            Gap(20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                child: RoundedElevatedButton(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: 40,
                  text: 'Update',
                  onPressed: () {},
                  cornerRadius: 10,
                  buttonColor: AppColors.appSecondaryColor,
                  textStyle: AppFonts.title.copyWith(color: AppColors.white),
                ),
              ),
              Gap(10),
              Expanded(
                child: RoundedElevatedButton(
                  text: 'Delivery',
                  onPressed: () async {
                    var res = await apiService.updateOrderStatus(widget.orderId, 'READYTODELIVER');
                    if (res) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please try again later')));
                    }
                  },
                  cornerRadius: 10,
                  buttonColor: Colors.green,
                  textStyle: AppFonts.title.copyWith(color: AppColors.white), width: MediaQuery.of(context).size.width*0.4,
                  height: 40,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
