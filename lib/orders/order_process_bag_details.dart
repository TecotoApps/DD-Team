import 'dart:convert';

import 'package:dd_shop/delivery/order_pickup.dart';
import 'package:dd_shop/orders/bag_list_by_orderid_model.dart';
import 'package:dd_shop/orders/order_screen.dart';
import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderProcessBagDetails extends StatefulWidget {
  final BagListPayload bagListPayload;
  const OrderProcessBagDetails({super.key, required this.bagListPayload});

  @override
  State<OrderProcessBagDetails> createState() => _OrderProcessBagDetailsState();
}

class _OrderProcessBagDetailsState extends State<OrderProcessBagDetails> {

  TextEditingController weightController = TextEditingController();
  TextEditingController itemsController = TextEditingController();
  TextEditingController itemNumberController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController extraChargeController = TextEditingController();
  String selectedOption = '';
  String selectedServiceType = '';
  List<Map<String, dynamic>> processedOrderItems = [];
  bool addItems = false;
  String? selectedItem;
  bool isEdited = false;
  final List<String> itemTypes = [
    "pant", "shirt", "jacket", "t shirt", "saree",
    "track pant", "baby shirt", "baby pant", "trousers"
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('this is received bag payload : ${jsonEncode(widget.bagListPayload)}');
    setState(() {
      selectedOption = '${widget.bagListPayload.pricingType}';
      selectedServiceType = '${widget.bagListPayload.orderProcess}';
      weightController.text = '${widget.bagListPayload.totalWeight}'??'';
      itemsController.text = '${widget.bagListPayload.totalItems}'??'';
      processedOrderItems = widget.bagListPayload.orderItems?.map((item) {
        return {
          'itemName': item.itemName,
          'nos': item.nos,
          'price': item.price,
          // add any other fields you want here
        };
      }).toList() ?? [];
    });
    print('this is processed order items : ${processedOrderItems}');
    changeBagStatus(OrderStatus.PROCESS.name);

    // getItemsList();
  }
  changeBagStatus(String status)async{
    await apiService.updateBagStatus(widget.bagListPayload.bagId, status,
        extraChargeController.text, commentsController.text, '', '');
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.bagListPayload.orderCode}',
                    style: AppFonts.subHeader.copyWith(fontWeight: FontWeight.bold),),
                  Text('${widget.bagListPayload.orderProcess}',
                    style: AppFonts.title.copyWith(fontWeight: FontWeight.bold,color: AppColors.appPrimaryColor),),
                ],
              ),
              Gap(MediaQuery.of(context).size.height*0.02),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Comments : ',
                      style: AppFonts.smallText.copyWith(
                        color: AppColors.appPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '${widget.bagListPayload.comments ?? ''}',
                      style: AppFonts.smallText.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(MediaQuery.of(context).size.height*0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Items",
                    style: AppFonts.title,
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        addItems = true;
                      });
                    },
                    child: Text(" + Add New Item",
                      style: AppFonts.title.copyWith(color: AppColors.appPrimaryColor,fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Gap(MediaQuery.of(context).size.height*0.01),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.appSecondaryColor.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.text_border_color, // 🔵 Your custom border color here
                    width: 1,
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: processedOrderItems.length,
                    itemBuilder:(BuildContext context,int index){
                      final item = processedOrderItems[index];
                    return Container(


                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex:4,
                                child: Text('${item['itemName']}',style: AppFonts.title,)),
                            Expanded(flex:2,
                                child:TextFormField(
                                  initialValue: '${item['nos']}',
                                  style: AppFonts.title,

                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(color: AppColors.text_border_color),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(color: AppColors.text_border_color), // same as enabled
                                      ),
                                    fillColor: AppColors.white,
                                    filled: true
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      item['nos'] = int.tryParse(value) ?? 0; // Update value in list
                                    });
                                  },

                            ),),
                            SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                            Text('₹ ${item['price']}',style: AppFonts.title.copyWith(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    );
                    }),
              ),
              Gap(MediaQuery.of(context).size.height*0.02),
              addItems?DropdownButtonFormField<String>(
                // value: selectedItem,
                alignment: Alignment.bottomLeft,
                isExpanded: true,
                hint: Text("select an item"),
                dropdownColor: AppColors.white,
                menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.text_border_color),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.text_border_color),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
                items: itemTypes.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: AppFonts.title),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      if (value != null) {
                        setState(() {
                          selectedItem = value;

                          // Add the new item to processedOrderItems with default nos and price
                          processedOrderItems.add({
                            'itemName': value,
                            'nos': 1,        // default quantity 1, change as needed
                            'price': 0.0,    // default price 0, change as needed
                          });

                          // Optionally update itemsController text to reflect the new total items count
                          itemsController.text = processedOrderItems.length.toString();
                        });
                      }
                    });
                  }
                },
              ):SizedBox(),
              Gap(MediaQuery.of(context).size.height*0.02),
              Text('Total Weight',style: AppFonts.title,),
              Gap(MediaQuery.of(context).size.height*0.01),
              TextFieldCurvedEdges(
                  controller: weightController,
                  backgroundColor: AppColors.white,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  borderColor: AppColors.text_border_color,
                  length: 10,
                  borderRadius: 10
              ),
              Gap(MediaQuery.of(context).size.height*0.02),
              Text('Total Items',style: AppFonts.title,),
              Gap(MediaQuery.of(context).size.height*0.01),
              TextFieldCurvedEdges(
                  controller: itemsController,
                  backgroundColor: AppColors.white,
                  keyboardType: TextInputType.number,
                  borderColor: AppColors.text_border_color,
                  length: 2,
                  borderRadius: 10
              ),
              Gap(MediaQuery.of(context).size.height*0.02),
              Gap(20),
              Text("Select Unit Type"),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Weight'),
                      value: PICKUP_ENUMS.WEIGHT.name,
                      groupValue: selectedOption,
                      activeColor: AppColors.appPrimaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      onChanged: (value) => setState(() => selectedOption = value!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Piece'),
                      value: PICKUP_ENUMS.PIECE.name,
                      groupValue: selectedOption,
                      activeColor: AppColors.appPrimaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      onChanged: (value) => setState(() => selectedOption = value!),
                    ),
                  ),
                  // Expanded(
                  //   child: RadioListTile<String>(
                  //     title: const Text('Package'),
                  //     value:PICKUP_ENUMS.PACKAGE.name,
                  //     groupValue: selectedOption,
                  //     activeColor: AppColors.appPrimaryColor,
                  //     contentPadding: EdgeInsets.zero,
                  //     dense: true,
                  //     onChanged: (value) => setState(() => selectedOption = value!),
                  //   ),
                  // ),
                ],
              ),
              Gap(10),
              Text("Select Service Type"),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Wash Only"),
                      value:PRICING_TYPE_ENUMS.WASH.name,
                      groupValue: selectedServiceType,
                      activeColor: AppColors.appPrimaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      onChanged: (value) => setState(() => selectedServiceType = value!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Wash & Iron"),
                      value: PRICING_TYPE_ENUMS.WASHIRON.name,
                      groupValue: selectedServiceType,
                      activeColor: AppColors.appPrimaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      onChanged: (value) => setState(() => selectedServiceType = value!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Iron Only"),
                      value: PRICING_TYPE_ENUMS.IRON.name,
                      groupValue: selectedServiceType,
                      activeColor: AppColors.appPrimaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      onChanged: (value) => setState(() => selectedServiceType = value!),
                    ),
                  ),
                ],
              ),
              Row(
                children: [

                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Wash & Fold"),
                      value: PRICING_TYPE_ENUMS.WASHFOLD.name,
                      groupValue: selectedServiceType,
                      activeColor: AppColors.appPrimaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      onChanged: (value) => setState(() => selectedServiceType = value!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Dryclean"),
                      value: PRICING_TYPE_ENUMS.DRYCLEAN.name,
                      groupValue: selectedServiceType,
                      activeColor: AppColors.appPrimaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      onChanged: (value) => setState(() => selectedServiceType = value!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Stain Remove"),
                      value: PRICING_TYPE_ENUMS.STAIN.name,
                      groupValue: selectedServiceType,
                      activeColor: AppColors.appPrimaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      onChanged: (value) => setState(() => selectedServiceType = value!),
                    ),
                  ),
                ],
              ),
              Gap(MediaQuery.of(context).size.height*0.02),
              Text('Extra Charges',style: AppFonts.smallText,),
              Gap(MediaQuery.of(context).size.height*0.01),
              TextFieldCurvedEdges(
                controller: extraChargeController,
                backgroundColor: AppColors.white,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                borderColor: AppColors.text_border_color,
                borderRadius: 10,

              ),
              Gap(MediaQuery.of(context).size.height*0.03),

              Gap(MediaQuery.of(context).size.height*0.02),
              Text('Add More Comments',style: AppFonts.smallText,),
              Gap(MediaQuery.of(context).size.height*0.01),
              TextFieldCurvedEdges(
                controller: commentsController,
                backgroundColor: AppColors.white,
                keyboardType: TextInputType.text,
                borderColor: AppColors.text_border_color,
                borderRadius: 10,
                maxlines: 4,
                minlines: 3,

              ),
              Gap(MediaQuery.of(context).size.height*0.03),

              RoundedElevatedButton(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  text: Dd_Strings.update_and_submit,
                  onPressed: ()async{
                    var updateOrderRes = await apiService.updateBag(widget.bagListPayload.bagId, widget.bagListPayload.orderId,
                        widget.bagListPayload.orderCode, itemsController.text,weightController.text, selectedOption,
                        selectedServiceType, processedOrderItems,widget.bagListPayload.comments);
                    if(updateOrderRes.statusCode==200){
                      changeBagStatus(OrderStatus.READYTODELIVER.name);
                      Navigator.pop(context);
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${updateOrderRes?.message}')),
                      );
                    }


                  },
                  cornerRadius: 6.0,
                  buttonColor: AppColors.appPrimaryColor,
                  textStyle: AppFonts.title
                      .copyWith(color: AppColors.white)),


            ],
          ),
        ),
      ),

    );
  }

  getItemsList()async{
    var res = await apiService.getItemsList();
  }
}
