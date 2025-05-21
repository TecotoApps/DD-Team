import 'package:dd_shop/orders/order_model.dart';
import 'package:dd_shop/orders/orders_controller.dart';
import 'package:dd_shop/services/sharedPress.dart';
import 'package:dd_shop/utils/components/dd_elevated_buttons.dart';
import 'package:dd_shop/utils/components/home_screen.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  OrdersState createState() => OrdersState();
}

class OrdersState extends State<Orders> {
  String verifymsg = '';
  int? shopId;

  @override
  void initState() {
    getId();
    super.initState();
  }

  Future<int?> getId() async {
    int? shopid = await sharedPress.getId(Dd_Strings.SHOPID);
    setState(() {
      shopId = 1;
    });
    return shopId;
  }

  // Future<OrderModel> getOrders() async {
  //   // OrderModel orders = await orderController.getShopOrders(shopId);
  //   // return orders;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Container(
            child: Text('My Orders',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'OpenSansSemiBold'))),
      ),
      // body: Container(
      //   child: FutureBuilder(
      //       future: getOrders(),
      //       builder:
      //           (BuildContext context, AsyncSnapshot<OrderModel?> snapshot) {
      //         if (snapshot.connectionState == ConnectionState.done) {
      //           return ListView.builder(
      //               itemCount: snapshot.data?.payload.length,
      //               itemBuilder: (BuildContext context, int index) {
      //                 print('inside list view orders');
      //                 return Padding(
      //                   padding: const EdgeInsets.symmetric(horizontal: 4),
      //                   child: Container(
      //                     height: 290,
      //                     child: Card(
      //                       elevation: 4,
      //                       child: Padding(
      //                         padding: const EdgeInsets.symmetric(vertical: 28.0,horizontal: 20),
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           mainAxisAlignment:
      //                           MainAxisAlignment.start,
      //                           children: [
      //                             Row(
      //                               mainAxisAlignment: MainAxisAlignment.start,
      //                               children: [
      //                                 CircleAvatar(
      //                                   radius: 16,
      //                                   backgroundColor: Colors.pink.shade50,
      //                                   child: Text('${snapshot.data?.payload[index].orderId}',
      //                                     style: TextStyle(color: Colors.black),),
      //                                 ),
      //                                 SizedBox(width: 20,),
      //                                 Center(
      //                                   child: Text(
      //                                     '${snapshot.data?.payload[index].addressName}',
      //                                     style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                             SizedBox(height: 8,),
      //                             Padding(
      //                               padding: const EdgeInsets.only(left:48.0),
      //                               child: Text('Contact : ${snapshot.data?.payload[index].phoneNumber}',style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold),),
      //                             ),
      //                             SizedBox(height: 10,),
      //                             Container(
      //                               height: 50,
      //                               /*child: Row(
      //                                 mainAxisAlignment: MainAxisAlignment.center,
      //                                 children: [
      //                                   CircleAvatar(
      //                                     backgroundColor:snapshot.data!.payload[index]!.orderStatus!='CANCELED'
      //                                         ? Colors.greenAccent.shade100
      //                                         : Colors.grey.shade200,
      //                                     child: Icon(
      //                                       snapshot.data!.payload[index]!.orderStatus !='CANCELED'
      //                                           ?Icons.check
      //                                           :Icons.cancel_outlined,
      //                                       color: snapshot.data!.payload[index]!.orderStatus!='CANCELED'
      //                                           ? Colors.green.shade900
      //                                           : Colors.grey
      //                                       ,),),
      //                                   Container(width: MediaQuery.of(context).size.width*0.14,height:2 ,color: Colors.grey.shade500,),
      //
      //                                   CircleAvatar(
      //                                       backgroundColor:snapshot.data!.payload[index]!.orderStatus =='PICKED' || snapshot.data!.payload[index].orderStatus == 'PROCESSED'  || snapshot.data!.payload[index].orderStatus == 'DELIVERED'
      //                                           ? Colors.greenAccent.shade100
      //                                           :snapshot.data!.payload[index]!.orderStatus !='CANCELED'
      //                                           ?Colors.yellow.shade200
      //                                           :Colors.grey.shade200,
      //                                       child:snapshot.data!.payload[index].orderStatus =='PICKED' || snapshot.data!.payload[index].orderStatus == 'PROCESSED'  || snapshot.data!.payload[index].orderStatus== 'DELIVERED'
      //                                           ?Icon(Icons.check, color: Colors.green.shade900,)
      //                                           :snapshot.data!.payload[index].orderStatus !='CANCELED'
      //                                           ?Icon(Icons.cached,color: Colors.grey.shade500,)
      //                                           :Icon(Icons.cancel_outlined,color: Colors.grey,)
      //                                   ),
      //                                   Container(width:  MediaQuery.of(context).size.width*0.14,height:2 ,color: Colors.grey.shade500,),
      //
      //                                   CircleAvatar(backgroundColor:snapshot.data!.payload[index].orderStatus == 'PROCESSED'  || snapshot.data!.payload[index].orderStatus == 'DELIVERED'
      //                                       ?Colors.greenAccent.shade100
      //                                       :snapshot.data!.payload[index].orderStatus !='CANCELED'
      //                                       ? Colors.yellow.shade200
      //                                       : Colors.grey.shade200,
      //                                       child:snapshot.data!.payload[index].orderStatus == 'PROCESSED'  || snapshot.data!.payload[index].orderStatus== 'DELIVERED'
      //                                           ?Icon(Icons.check, color: Colors.green.shade900,)
      //                                           :snapshot.data!.payload[index].orderStatus !='CANCELED'
      //                                           ?Icon(Icons.cached,color: Colors.grey.shade500,)
      //                                           :Icon(Icons.cancel_outlined,color: Colors.grey,)
      //                                   ),
      //                                   Container(width: MediaQuery.of(context).size.width*0.14,height:2 ,color: Colors.grey.shade500,),
      //
      //                                   CircleAvatar(backgroundColor: snapshot.data!.payload[index].orderStatus== 'DELIVERED'
      //                                       ?Colors.greenAccent.shade100
      //                                       :snapshot.data!.payload[index].orderStatus !='CANCELED'
      //                                       ?Colors.yellow.shade200
      //                                       :Colors.grey.shade200,
      //                                       child:snapshot.data!.payload[index].orderStatus== 'DELIVERED'
      //                                           ?Icon(Icons.check, color: Colors.green.shade900,)
      //                                           :snapshot.data!.payload[index].orderStatus !='CANCELED'
      //                                           ?Icon(Icons.cached,color: Colors.grey.shade500,)
      //                                           :Icon(Icons.cancel_outlined,color: Colors.grey,)
      //                                   ),
      //                                 ],
      //                               ),*/
      //                             ),
      //                             Container(
      //                               height: 30,
      //                              /* child: Row(
      //                                 mainAxisAlignment: MainAxisAlignment.center,
      //                                 children: [
      //                                   snapshot.data!.payload[index].orderStatus !='CANCELED'
      //                                       ?Text('Created',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),)
      //                                       :Text('Canceled',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
      //                                   SizedBox(width:  MediaQuery.of(context).size.width*0.16,),
      //                                   snapshot.data!.payload[index].orderStatus !='CANCELED'
      //                                       ?Text('Picked',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold))
      //                                       :Text('Canceled',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
      //                                   SizedBox(width:  MediaQuery.of(context).size.width*0.16,),
      //                                   snapshot.data!.payload[index].orderStatus !='CANCELED'
      //                                       ?Text('Ready',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold))
      //                                       :Text('Canceled',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
      //                                   SizedBox(width:  MediaQuery.of(context).size.width*0.12,),
      //                                   snapshot.data!.payload[index].orderStatus !='CANCELED'
      //                                       ?Text('Completed',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold))
      //                                       :Text('Canceled',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
      //                                 ],
      //                               ),*/
      //                             ),
      //                             SizedBox(
      //                               height: 50,
      //                               width: 140,
      //                              /* child: ElevatedButton(
      //                                 onPressed: () async{
      //                                   if(snapshot.data?.payload[index].orderStatus != 'CANCELED'){
      //                                     var result =
      //                                     await orderController.updateOrder(
      //                                         snapshot.data!.payload[index]
      //                                             .orderId,
      //                                         'some Reason').then((value) {
      //                                       showDialog<String>(
      //                                           context: context,
      //                                           builder: (BuildContext context) =>
      //                                               AlertDialog(
      //                                                 title: Text('${value?.message!}'),
      //                                                 actions: <Widget>[
      //                                                   TextButton(
      //                                                     onPressed: () => Navigator.pop(context, 'OK'),
      //                                                     child: const Text(
      //                                                       'OK', style: TextStyle(color: Colors.pink),),
      //                                                   ),
      //                                                 ],
      //                                               ));
      //                                     });
      //                                     if (result.statusCode == 201) {
      //                                       verifymsg = result.message!;
      //
      //                                     }
      //                                   }
      //                                 },
      //                                 child: Text('Cancel Order',style: TextStyle(color:snapshot.data!.payload[index].orderStatus != 'CANCELED'?Colors.pink.shade600:Colors.grey),),
      //                                 style: ElevatedButton.styleFrom(
      //                                   backgroundColor: Colors.white,
      //                                   shape: RoundedRectangleBorder(
      //                                       borderRadius: BorderRadius.all(Radius.circular(50))
      //                                   ),
      //                                 ),
      //                               ),*/
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 );
      //               });
      //         } else if (snapshot.connectionState ==
      //             ConnectionState.waiting) {
      //           return Center(child: CircularProgressIndicator(color: Colors.pink.shade600,));
      //         } else {
      //           return Text('no data');
      //         }
      //       }),
      // )
    );
  }
}

enum OrderStatus {
  CREATED,
  PICKED,
  PROCESS,
  READYTODELIVER,
  COMPLETED,
  CANCELED
}

Text getOrderStatusText(OrderStatus status, {TextStyle? style}) {
  String statusText;
  Color statusColor;

  switch (status) {
    case OrderStatus.CREATED:
      statusText = "Created";
      statusColor = AppColors.textColor;
      break;
    case OrderStatus.PICKED:
      statusText = "Picked";
      statusColor = Colors.orange;
      break;
    case OrderStatus.PROCESS:
      statusText = "Processing";
      statusColor = AppColors.appSecondaryColor;
      break;
    case OrderStatus.READYTODELIVER:
      statusText = "Ready to Deliver";
      statusColor = Colors.teal;
      break;
    case OrderStatus.COMPLETED:
      statusText = "Completed";
      statusColor = Colors.green;
      break;
    case OrderStatus.CANCELED:
      statusText = "Canceled";
      statusColor = Colors.red;
      break;
  }

  return Text(
    statusText,
    style: style?.copyWith(color: statusColor) ??
        AppFonts.title
  );
}

