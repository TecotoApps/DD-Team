import 'package:dd_shop/orders/add_customer_address.dart';
import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/shop/model/location_model.dart';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/components/locations_list_item.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AddCustomer extends StatefulWidget {
  final String? shopId;
  const AddCustomer({super.key, this.shopId});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {


  TextEditingController _numberController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  bool isUserRegistered = false;
  bool locationsListPresent = false;
  bool pickUpFromStore = true;
  String userName = '';
  String customerId = '';
  String locationId = '';
  String customerAddress = '';
  String timeSlot = '';
  List<Payload>? payload;
  int? _selectedLocationIndex;
  DeliveryOption _selectedOption = DeliveryOption.pickup;


  @override
  void initState() {
    super.initState();
    timeSlot = getCurrentTimeSlot(); // Automatically set based on current time
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
      backgroundColor: AppColors.appPrimaryColor,
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_rounded,color: AppColors.white,)),
      title: Text('Add Customer',style: AppFonts.subHeader.copyWith(color: AppColors.white),),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(MediaQuery.of(context).size.height * 0.03),
            Text(
              Dd_Strings.enter_customer_number,
              style: AppFonts.smallText,
            ),
            Gap(10),
            TextFieldCurvedEdges(
                controller: _numberController,
                backgroundColor: Colors.white,
                keyboardType: TextInputType.number,
                borderRadius: 10,
                length: 10,
                onChanged: (value)async{
                  if (value.length == 10) {
                   var res = await apiService.getUserDetailsByPhone('$value');
                   if(res.statusCode==200){
                     setState(() {
                       isUserRegistered = true;
                       userName = res.payload!.name!;
                       customerId = res.payload!.userId!;
                       getUserLocation(res.payload!.userId!);
                     });
                   }
                   else{
                     setState(() {
                       isUserRegistered = false;
                       locationsListPresent = false;
                       userName = '';
                       customerId = '';
                     });
                   }

                  }
                },
                borderColor: AppColors.text_border_color),
            Gap(MediaQuery.of(context).size.height * 0.01),
            Text(
              Dd_Strings.customer_name,
              style: AppFonts.smallText,
            ),
            Gap(10),
            isUserRegistered?Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.text_border_color), // You can change the color
                borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
              ),
              child:  Align(alignment: Alignment.centerLeft,
                  child: Text('$userName',style: AppFonts.title,)),
            ): TextFieldCurvedEdges(
              controller: _userNameController,
              backgroundColor: Colors.white,
              keyboardType: TextInputType.name,
              borderRadius: 10, borderColor: AppColors.text_border_color,
            ),
            Gap(MediaQuery.of(context).size.height * 0.01),

            Row(
              children: [
                Expanded(
                  child: RadioListTile<DeliveryOption>(
                    title: Text('${Dd_Strings.pick_from_store}', style: AppFonts.smallText),
                    value: DeliveryOption.pickup,
                    groupValue: _selectedOption,
                    activeColor: AppColors.appPrimaryColor,
                    onChanged: (DeliveryOption? value) {
                      setState(() {
                        _selectedOption = value!;
                        pickUpFromStore = true;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<DeliveryOption>(
                    title: Text('${Dd_Strings.deliver_to_home}', style: AppFonts.smallText),
                    value: DeliveryOption.home,
                    groupValue: _selectedOption,
                    activeColor: AppColors.appPrimaryColor,

                    onChanged: (DeliveryOption? value) {
                      setState(() {
                        _selectedOption = value!;
                        pickUpFromStore = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Gap(MediaQuery.of(context).size.height * 0.01),
            pickUpFromStore?Container():locationsListPresent?showLocationsWidget(payload):
            isUserRegistered?RoundedElevatedButton(width: MediaQuery.of(context).size.width,
                height: 40, text: 'Add Address', onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>AddCustomerAddress(customerId: customerId)));

                },
                cornerRadius: 10, buttonColor: AppColors.appSecondaryColor,
                textStyle: AppFonts.title.copyWith(color: AppColors.white,
                    fontWeight: FontWeight.bold)):RoundedElevatedButton(width: MediaQuery.of(context).size.width,
                height: 40, text: 'Add Customer', onPressed: ()async{
                      var userRegister = await apiService.registerCustomer(_numberController.text,_userNameController.text);
                      if(userRegister.statusCode ==201){
                        print('this is registered userId : ${userRegister.payload!.userId!}');
                        setState(() {
                          isUserRegistered = true;
                          locationsListPresent = false;
                        });
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Something went wrong...Try again Later')),
                        );
                      }

                },
                cornerRadius: 10, buttonColor: AppColors.appSecondaryColor,
                textStyle: AppFonts.title.copyWith(color: AppColors.white,
                    fontWeight: FontWeight.bold)),

            Gap(MediaQuery.of(context).size.height * 0.03),
            RoundedElevatedButton(width: MediaQuery.of(context).size.width,
                height: 40, text: 'Schedule Order', onPressed: ()async{
                  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
                  var result;
                  if(pickUpFromStore){
                     result = await apiService.createOrder(customerId,
                        '', widget.shopId,
                        '', '', timeSlot, formattedDate);
                  }
                  else{
                     result = await apiService.createOrder(customerId,
                        locationId, widget.shopId,
                        '', customerAddress, timeSlot, formattedDate);
                  }

              if(result.statusCode == 200){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order Created')),
                );
                Navigator.pop(context);
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Something went wrong...Try again Later')),
                );
              }
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context)=>AddCustomerAddress(customerId: customerId)));

                },
                cornerRadius: 10, buttonColor: AppColors.appSecondaryColor,
                textStyle: AppFonts.title.copyWith(color: AppColors.white,
                    fontWeight: FontWeight.bold))


          ],
        ),
      ),
    ),);
  }

  getUserLocation(String id)async{
    var locations = await apiService.getLocation(id);
    if(locations.statusCode ==201){
      setState(() {
        locationsListPresent = true;
        payload = locations.payload;
      });
    }
    else{
      locationsListPresent = false;
    }
  }
  Widget showLocationsWidget(List<Payload>? payload){
    print('inside location widget');
    return ListView.builder(

      shrinkWrap: true,
        itemCount: payload!.length,
        itemBuilder: (BuildContext context, int index) {
          bool isSelected = _selectedLocationIndex == index;
          return GestureDetector(
            onTap: (){
              print('this is location id : ${payload[index].address}');
              // apiService.createOrder(customerId,
              //     locationId,
              //     shopId, comments, address, timeSlot, orderDate)
              setState(() {
                _selectedLocationIndex = index;
                locationId = payload[index].locationId!;
                customerAddress = payload[index].address!;
              });
            },
            child:LocationsListItem(location: payload[index].address,
              landmark: payload[index].landmark,isSelected: isSelected,),
          );
        });
  }

  String getCurrentTimeSlot() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 8 && hour < 10) {
      return 'EIGHTTOTEN';
    } else if (hour >= 10 && hour < 12) {
      return 'TENTOTWELVE';
    } else if (hour >= 12 && hour < 14) {
      return 'TWELVETOTWO';
    } else if (hour >= 14 && hour < 16) {
      return 'TWOTOFOUR';
    } else if (hour >= 16 && hour < 18) {
      return 'FOURTOSIX';
    } else if (hour >= 18 && hour < 20) {
      return 'SIXTOEIGHT';
    } else {
      return 'OUT_OF_SLOT'; // Optional: you can handle this case as needed
    }
  }
}


enum DeliveryOption { pickup, home }