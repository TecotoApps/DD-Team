import 'dart:async';
import 'package:dd_shop/utils/components/elevated_rounded_button.dart';
import 'package:dd_shop/utils/components/text_field_curved_edges.dart';
import 'package:dd_shop/utils/constants/app_fonts.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class AddCustomerAddress extends StatefulWidget {
  const AddCustomerAddress({super.key});

  @override
  State<AddCustomerAddress> createState() => _AddCustomerAddressState();
}

class _AddCustomerAddressState extends State<AddCustomerAddress> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  Set<Marker> _markers = {};
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();
  double? lat;
  double? lng;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _markers.add(
          Marker(
            markerId: MarkerId("current_location"),
            position: _currentPosition!,
            infoWindow: InfoWindow(title: "Your Location"),
          ),
        );
      });

      print("Current Location: ${position.latitude}, ${position.longitude}");
    } else if(status.isDenied){
      _showPermissionDialog("Location permission is denied. Please enable it to use this feature.");
    }
    else{
      _showPermissionDialog(
        "Location permission is permanently denied. Please enable it from app settings.",
        openSettings: true,
      );
    }
  }
  void _showPermissionDialog(String message, {bool openSettings = true}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Permission Required"),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          if (openSettings)
            TextButton(
              child: Text("Open Settings"),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            )
        ],
      ),
    );
  }

  void _onMapTapped(LatLng tappedPoint) {
    print("Tapped Location: ${tappedPoint.latitude}, ${tappedPoint.longitude}");

    setState(() {
      lat = tappedPoint.latitude;
      lng = tappedPoint.longitude;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId("selected_location"),
          position: tappedPoint,
          infoWindow: InfoWindow(title: "Selected Location"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.white),
        ),
        title: Text(
          'Add Address',
          style: AppFonts.subHeader.copyWith(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.3,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  onMapCreated: (controller) => _controller.complete(controller),
                  markers: _markers,
                  onTap: _onMapTapped,
                ),
              ),
              Gap(MediaQuery.of(context).size.height * 0.05),
              Text(
                Dd_Strings.enter_customer_address,
                style: AppFonts.smallText,
              ),
              Gap(MediaQuery.of(context).size.height * 0.01),
              TextFieldCurvedEdges(
            controller: _addressController,
            backgroundColor: Colors.white,
            keyboardType: TextInputType.streetAddress,
            borderRadius: 10,
            borderColor: AppColors.text_border_color),
              Gap(MediaQuery.of(context).size.height * 0.01),
              Text(
          Dd_Strings.city,
          style: AppFonts.smallText,
              ),
              Gap(10),
              TextFieldCurvedEdges(
            controller: _cityController,
            backgroundColor: Colors.white,
            keyboardType: TextInputType.streetAddress,
            borderRadius: 10,
            borderColor: AppColors.text_border_color),
              Gap(MediaQuery.of(context).size.height * 0.01),
              Gap(MediaQuery.of(context).size.height * 0.01),
              Text(
                Dd_Strings.landmark,
                style: AppFonts.smallText,
              ),
              Gap(10),
              TextFieldCurvedEdges(
                  controller: _landmarkController,
                  backgroundColor: Colors.white,
                  keyboardType: TextInputType.streetAddress,
                  borderRadius: 10,
                  borderColor: AppColors.text_border_color),
              Gap(MediaQuery.of(context).size.height * 0.03),
              RoundedElevatedButton(width: MediaQuery.of(context).size.width,
                  height: 40, text: 'Add Address', onPressed: (){
                  },
                  cornerRadius: 10, buttonColor: AppColors.appSecondaryColor,
                  textStyle: AppFonts.title.copyWith(color: AppColors.white,fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
