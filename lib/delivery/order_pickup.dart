import 'package:dd_shop/dashboard/model/order_list_model.dart';
import 'package:dd_shop/delivery/delivery_controller.dart';
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

  String selectedOption = 'Weight'; // Default selected radio button

  final List<String> itemTypes = [
    "pant", "shirt", "jacket", "t shirt", "saree",
    "track pant", "baby shirt", "baby pant", "trousers"
  ];
  String? selectedItem;

  Map<String, int> selectedItems = {};

  // List to hold itemName and quantity
  List<Map<String, dynamic>> orderItems = [];

  void incrementItem(String item) {
    setState(() {
      selectedItems[item] = (selectedItems[item] ?? 0) + 1;

      int index = orderItems.indexWhere((element) => element['itemName'] == item);
      if (index >= 0) {
        orderItems[index]['nos'] = selectedItems[item];
      } else {
        orderItems.add({'itemName': item, 'nos': 0});
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
              Gap(20),
              Text("${Dd_Strings.bag_number}"),
              TextFieldCurvedEdges(
                controller: bagNoController,
                backgroundColor: AppColors.white,
                keyboardType: TextInputType.number,
                borderColor: AppColors.text_border_color,
                borderRadius: 10,
              ),
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
              Row(
                children: [
                  Expanded(
                    child: TextFieldCurvedEdges(
                      controller: pickupDateController,
                      backgroundColor: AppColors.white,
                      keyboardType: TextInputType.none,
                      borderColor: AppColors.text_border_color,
                      borderRadius: 10,
                      readOnly: true,
                      hintText: "Select date",
                      suffixIcon: Icon(Icons.calendar_today, color: AppColors.appPrimaryColor),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          pickupDateController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextFieldCurvedEdges(
                      controller: pickupTimeController,
                      backgroundColor: AppColors.white,
                      keyboardType: TextInputType.none,
                      borderColor: AppColors.text_border_color,
                      borderRadius: 10,
                      readOnly: true,
                      hintText: "Select time",
                      suffixIcon: Icon(Icons.access_time, color: AppColors.appPrimaryColor),
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          pickupTimeController.text = pickedTime.format(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
              Gap(20),
              Text("Select Unit Type"),
              Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Weight'),
                    value: 'WEIGHT',
                    groupValue: selectedOption,
                    activeColor: AppColors.appPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Piece'),
                    value: 'PIECE',
                    groupValue: selectedOption,
                    activeColor: AppColors.appPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Package'),
                    value: 'PACKAGE',
                    groupValue: selectedOption,
                    activeColor: AppColors.appPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                ],
              ),
              Gap(10),
              RoundedElevatedButton(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.05,
                text: "Pickup",
                onPressed: () async {
                  print(orderItems); // <- To verify structure before API use

                  var orderRes = await apiService.confirmPickup(
                    widget.orderPayload.orderId,
                    bagNoController.text,
                    itemsController.text,
                    weightController.text,
                    commentsController.text,
                    selectedOption,orderItems
                  );
                  if(orderRes.statusCode==200){
                    Navigator.pop(context);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${orderRes.message}',style: AppFonts.title.copyWith(color: AppColors.white),)),
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
}

String _formatDate(DateTime date) {
  return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
}

enum PICKUP_ENUMS { WEIGHT, PIECE, PACKAGE }
