import 'package:dd_shop/dashboard/model/order_list_model.dart';
 import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddOrderPickupDetails extends StatefulWidget {
  final OrderPayload orderPayload;
  AddOrderPickupDetails({super.key, required this.orderPayload});

  @override
  State<AddOrderPickupDetails> createState() => _AddOrderPickupDetailsState();
}

class _AddOrderPickupDetailsState extends State<AddOrderPickupDetails> {
  TextEditingController bagNoController = TextEditingController();
  TextEditingController pickupDateController = TextEditingController();
  TextEditingController pickupTimeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController itemsController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  String selectedOption = 'WEIGHT';
  String selectedServiceType = 'WASH_ONLY';

  final List<String> itemTypes = [
    "pant", "shirt", "jacket", "t shirt", "saree",
    "track pant", "baby shirt", "baby pant", "trousers"
  ];
  String? selectedItem;

  Map<String, int> selectedItems = {};
  List<Map<String, dynamic>> orderItems = [];

  void incrementItem(String item) {
    setState(() {
      selectedItems[item] = (selectedItems[item] ?? 0) + 1;

      int index = orderItems.indexWhere((element) => element['itemName'] == item);
      if (index >= 0) {
        orderItems[index]['nos'] = selectedItems[item];
      } else {
        orderItems.add({'itemName': item, 'nos': 1});
      }
    });
  }

  void decrementItem(String item) {
    setState(() {
      if (selectedItems.containsKey(item) && selectedItems[item]! > 0) {
        selectedItems[item] = selectedItems[item]! - 1;

        int index = orderItems.indexWhere((element) => element['itemName'] == item);
        if (selectedItems[item] == 0) {
          selectedItems.remove(item);
          if (index >= 0) orderItems.removeAt(index);
        } else {
          if (index >= 0) {
            orderItems[index]['nos'] = selectedItems[item].toString();
          }
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('this is order id : ${widget.orderPayload.orderId}');
    print('this is order id : ${widget.orderPayload.orderCode}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.appPrimaryColor,
        title: Text(
          '${Dd_Strings.order_pickup_details}',
          style: AppFonts.title.copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gap(20),
              // Text("${Dd_Strings.bag_number}"),
              // TextFieldCurvedEdges(
              //   controller: bagNoController,
              //   backgroundColor: AppColors.white,
              //   keyboardType: TextInputType.number,
              //   borderColor: AppColors.text_border_color,
              //   borderRadius: 10,
              // ),
              Gap(20),
              Text("Add Items"),
              DropdownButtonFormField<String>(
                value: selectedItem,
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
                      selectedItem = value;
                      incrementItem(value);
                    });
                  }
                },
              ),
              Gap(10),
              if (selectedItems.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.appPrimaryColor,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: selectedItems.entries.map((entry) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.key, style: AppFonts.title.copyWith(fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline, color: AppColors.text_border_color),
                                onPressed: () => decrementItem(entry.key),
                              ),
                              Text(entry.value.toString(), style: TextStyle(fontSize: 16)),
                              IconButton(
                                icon: Icon(Icons.add_circle_outline, color: AppColors.appPrimaryColor),
                                onPressed: () => incrementItem(entry.key),
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              Gap(20),
              Text("Enter weight (in Kgs)"),
              TextFieldCurvedEdges(
                controller: weightController,
                backgroundColor: AppColors.white,
                keyboardType: TextInputType.number,
                borderColor: AppColors.text_border_color,
                borderRadius: 10,
              ),
              Gap(20),
              Text("Enter number of pieces"),
              TextFieldCurvedEdges(
                controller: itemsController,
                backgroundColor: AppColors.white,
                keyboardType: TextInputType.number,
                borderColor: AppColors.text_border_color,
                borderRadius: 10,
              ),
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
              Gap(10),

              Text("${Dd_Strings.comments}"),
              TextFieldCurvedEdges(
                controller: commentsController,
                backgroundColor: AppColors.white,
                keyboardType: TextInputType.text,
                borderColor: AppColors.text_border_color,
                borderRadius: 10,
                maxlines: 4,
                minlines: 3,

              ),
              Gap(20),
              RoundedElevatedButton(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                text: Dd_Strings.submit_button_text,
                onPressed: () async {

                  var orderRes = await apiService.addBag(
                    widget.orderPayload.orderId,widget.orderPayload.orderCode,
                    itemsController.text,
                    weightController.text,selectedOption,selectedServiceType,
                    orderItems,'UPI',commentsController.text,
                  );
                  print('this is add bag response : $orderRes');
                  if(orderRes.statusCode == 200){
                    // Navigator.pop(context);
                    addBagDialog(orderRes.message);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${orderRes.message}',
                          style: AppFonts.title.copyWith(color: AppColors.white),
                        ),
                      ),
                    );
                  }
                },
                cornerRadius: 6.0,
                buttonColor: AppColors.appPrimaryColor,
                textStyle: AppFonts.title.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w600),
              ),
              Gap(10),
            ],
          ),
        ),
      ),
    );
  }

  void addBagDialog(String? message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Success",style: AppFonts.header.copyWith(color: Colors.green),textAlign: TextAlign.center,),
        content: Text(message!,style: AppFonts.title.copyWith(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text("Add Bag",
                      style: AppFonts.title.copyWith(color: AppColors.appSecondaryColor,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    clearEntries();
                    Navigator.pop(context);
                  }
                ),
                RoundedElevatedButton(
                  width: MediaQuery.of(context).size.width*0.3,
                  height: 40,
                  cornerRadius: 10,
                  buttonColor: AppColors.appPrimaryColor,
                  text: 'Pickup',
                  textStyle: AppFonts.title.copyWith(color: AppColors.white,fontWeight: FontWeight.bold),
                  onPressed: ()async{
                    var res = await apiService.updateOrderStatus(widget.orderPayload.orderId, 'PICKED');
                    if(res){
                      Navigator.pop(context);
                      await Future.delayed(Duration(milliseconds: 100));
                      Navigator.pop(context);
                    }
                  },


                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
  void clearEntries(){
    setState(() {
      weightController.clear();
      itemsController.clear();
      commentsController.clear();
      bagNoController.clear();
      pickupDateController.clear();
      pickupTimeController.clear();

      selectedItem = null;
      selectedItems.clear();
      orderItems.clear();

      selectedOption = 'WEIGHT';
      selectedServiceType = PRICING_TYPE_ENUMS.WASH.name;
    });
  }
}

String _formatDate(DateTime date) {
  return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
}

enum PICKUP_ENUMS { WEIGHT, PIECE, PACKAGE }
enum PRICING_TYPE_ENUMS { IRON, WASH, WASHIRON,WASHFOLD,DRYCLEAN,STAIN }
enum WEIGTH_PRICE_ENUMS { ZEROTOTHREE, THREETOFIVE, FIVETOEIGHT,EIGHTTOTEN,TENABOVE }