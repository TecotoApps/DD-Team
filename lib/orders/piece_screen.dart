import 'package:dd_shop/orders/piece_model.dart';
import 'package:dd_shop/orders/price_controller.dart';
import 'package:dd_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class Pricing extends StatefulWidget {
  String? shopId;
  Pricing({required this.shopId});

  @override
  State<Pricing> createState() => _PricingState();
}

class _PricingState extends State<Pricing> {


  @override
  void initState() {
    getItemsPerPeice();
    super.initState();
  }

  Future<PieceModel> getItemsPerPeice() async {
    PieceModel itemsperpeiece = await priceController.getItemListPerPiece(widget.shopId);
    return itemsperpeiece;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth  = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 5),
        child: Container(
          height: screenHeight*0.70,
          width: screenWidth,
          decoration: BoxDecoration(border: Border.all(color: AppColors.text_border_color)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: AppColors.appSecondaryColor.withOpacity(0.3),
                height: screenHeight*0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: screenHeight*0.05,
                      width: screenWidth*0.30,
                       child: Center(child: Text('Type',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                    Container(
                      height: screenHeight*0.05,
                      width: screenWidth*0.16,
                       child: Center(child: Text('Only \nWash',style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    Container(
                      height: screenHeight*0.05,
                      width: screenWidth*0.16,
                      child: Center(child: Text('Wash & Fold',style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    Container(
                      height: screenHeight*0.05,
                      width: screenWidth*0.16,
                       child: Center(child: Text('Iron\nonly',style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    Container(
                      height: screenHeight*0.05,
                      width: screenWidth*0.16,
                      child: Center(child: Text('Wash &\nIron',style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                  ],
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height*0.55,
                child: FutureBuilder(
                  future: getItemsPerPeice(),
                  builder: (BuildContext context,
                      AsyncSnapshot<PieceModel?> snapshot){
                    return ListView.builder(
                        itemCount: snapshot.data?.payload?.length,
                        itemBuilder: (BuildContext context, int index){
                          return Container(
                              height: screenHeight*0.05,
                              child: Row(
                                children: [
                                  Container(
                                    height: screenHeight*0.05,
                                    width: screenWidth*0.30,
                                    child: Center(child: Text('${snapshot.data?.payload?[index].itemName}')),
                                  ),
                                  Container(
                                    height: screenHeight*0.05,
                                    width: screenWidth*0.16,
                                    child: Center(child: Text('${snapshot.data?.payload?[index].wash}')),
                                  ),
                                  Container(
                                    height: screenHeight*0.05,
                                    width: screenWidth*0.16,
                                    child: Center(child: Text('${snapshot.data?.payload?[index].dry}')),
                                  ),
                                  Container(
                                    height: screenHeight*0.05,
                                    width: screenWidth*0.16,
                                    child: Center(child: Text('${snapshot.data?.payload?[index].iron}')),
                                  ),
                                  Container(
                                    height: screenHeight*0.05,
                                    width: screenWidth*0.16,
                                    child: Center(child: Text('${snapshot.data?.payload?[index].washIron}')),
                                  ),
                                ],
                              ));
                         }
                         );
                  },

                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}


