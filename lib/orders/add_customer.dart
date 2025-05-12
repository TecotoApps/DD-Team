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

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {


  TextEditingController _numberController = TextEditingController();
  bool isUserRegistered = false;
  bool locationsListPresent = false;
  String userName = '';
  List<Payload>? payload;
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
                       getUserLocation(res.payload!.userId!);
                     });
                   }
                   else{
                     isUserRegistered = false;
                     userName = '';
                   }

                  }
                },
                borderColor: AppColors.text_border_color),
            Gap(MediaQuery.of(context).size.height * 0.01),
            isUserRegistered?Text(
              Dd_Strings.customer_name,
              style: AppFonts.smallText,
            ):Container(),
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
            ): Container(),
            Gap(MediaQuery.of(context).size.height * 0.01),
            locationsListPresent?showLocationsWidget(payload):
            RoundedElevatedButton(width: MediaQuery.of(context).size.width,
                height: 40, text: 'Add Address', onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>AddCustomerAddress()));

                },
                cornerRadius: 10, buttonColor: AppColors.appSecondaryColor,
                textStyle: AppFonts.title.copyWith(color: AppColors.white,fontWeight: FontWeight.bold))

            // Gap(10),
            // TextFieldCurvedEdges(
            //     controller: _addressController,
            //     backgroundColor: Colors.white,
            //     keyboardType: TextInputType.streetAddress,
            //     borderRadius: 10,
            //     borderColor: AppColors.text_border_color),
            // Gap(MediaQuery.of(context).size.height * 0.01),
            // Text(
            //   Dd_Strings.city,
            //   style: AppFonts.smallText,
            // ),
            // Gap(10),
            // TextFieldCurvedEdges(
            //     controller: _cityController,
            //     backgroundColor: Colors.white,
            //     keyboardType: TextInputType.streetAddress,
            //     borderRadius: 10,
            //     borderColor: AppColors.text_border_color),
            // Gap(MediaQuery.of(context).size.height * 0.01),
            // Text(
            //   Dd_Strings.landmark,
            //   style: AppFonts.smallText,
            // ),
            // Gap(10),
            // TextFieldCurvedEdges(
            //     controller: _landmarkController,
            //     backgroundColor: Colors.white,
            //     keyboardType: TextInputType.streetAddress,
            //     borderRadius: 10,
            //     borderColor: AppColors.text_border_color),
            //
            // Gap(MediaQuery.of(context).size.height * 0.1),
            // RoundedElevatedButton(width: MediaQuery.of(context).size.width, height: 40,
            //     text: 'Create Order', onPressed: (){},
            //     cornerRadius: 10, buttonColor: AppColors.appPrimaryColor, textStyle: TextStyle(color: AppColors.white))

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
          return GestureDetector(
            onTap: (){
            },
            child:LocationsListItem(location: payload[index].address,landmark: payload[index].landmark,),
          );
        });
  }
}
