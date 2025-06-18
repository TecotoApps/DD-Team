import 'package:dd_shop/dashboard/shop_exe_dashboard.dart';
import 'package:dd_shop/orders/bag_list_by_orderid_model.dart';
import 'package:dd_shop/orders/order_process_bag_details.dart';
import 'package:dd_shop/orders/order_screen.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:dd_shop/services/api_services.dart';
import 'package:gap/gap.dart';

class ProcessOrderByBags extends StatefulWidget {
  final String? orderId;
  const ProcessOrderByBags({super.key, required this.orderId});

  @override
  State<ProcessOrderByBags> createState() => _ProcessOrderByBagsState();
}

class _ProcessOrderByBagsState extends State<ProcessOrderByBags> with WidgetsBindingObserver{
  List<BagListPayload> bagList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getOrderDetails(widget.orderId);

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 🔁 Remove observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // 🔄 Refresh screen when app comes to foreground
      getOrderDetails(widget.orderId);
    }
  }

  Future<void> getOrderDetails(String? orderId) async {
    print('fetching.....');
    try {
      await apiService.updateOrderStatus(orderId, OrderStatus.PROCESS);
      BagListByOrderIdModel res = await apiService.getBagListsByOrderId(orderId);
      if (res.statusCode == 200 && res.payload != null) {
        setState(() {
          bagList = res.payload!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh:()=> getOrderDetails(widget.orderId),
            color: AppColors.appPrimaryColor,
            child: Stack(
              children: [
                ListView.builder(
                        itemCount: bagList.length,
                        itemBuilder: (context, index) {
                final bag = bagList[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>OrderProcessBagDetails(
                          bagListPayload: bag,
                        )));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.text_border_color, // 🔵 Your custom border color here
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${bag.orderProcess ?? ""}",
                                  style: AppFonts.title.copyWith(fontWeight: FontWeight.bold)
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child:  getOrderStatusText(
                                  getOrderStatusFromString(bag.orderStatus),
                                  style: AppFonts.smallText.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),
                          Text("Total Items: ${bag.totalItems ?? '-'}"),
                          Text("Total Weight: ${bag.totalWeight ?? '-'} kg"),
                          Gap(10),
                          Row(
                            children: [
                              Text("Comments: ",style: AppFonts.smallText.copyWith(color: AppColors.appPrimaryColor,fontWeight: FontWeight.bold),),
                              Text("${bag.comments ?? 'None'}",style: AppFonts.smallText.copyWith(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          // if (bag.orderItems != null && bag.orderItems!.isNotEmpty)
                          //   Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       const Text(
                          //         "Order Items:",
                          //         style: TextStyle(fontWeight: FontWeight.bold),
                          //       ),
                          //       ...bag.orderItems!.map((item) => Padding(
                          //         padding: const EdgeInsets.symmetric(vertical: 2),
                          //         child: Text(
                          //             "- ${item.itemName} (x${item.nos}) ₹${item.price}"),
                          //       )),
                          //     ],
                          //   ),
                        ],
                      ),
                    ),
                  ),
                );
                        },
                      ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundedElevatedButton(width: MediaQuery.of(context).size.width, height: 40,
                        text: 'Completed', onPressed: ()async{
                      var updateOrderStatus = await apiService.updateOrderStatus(widget.orderId, OrderStatus.READYTODELIVER.name);
                      if(updateOrderStatus){
                        Navigator.pop(context);
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Unable to Complete ...Try again Later')),
                        );
                      }
                        }, cornerRadius: 10,
                        buttonColor: AppColors.appPrimaryColor, textStyle: AppFonts.title.copyWith(color: AppColors.white)),
                  ),
                )
              ],
            ),
          ),
    );
  }
}
