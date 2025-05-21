import 'package:dd_shop/orders/price_controller.dart';
import 'package:dd_shop/orders/weight_model.dart';
import 'package:dd_shop/utils/constants/colors.dart';

import 'package:flutter/material.dart';

class WeightScreen extends StatefulWidget {
  String? shopId;
  WeightScreen({required this.shopId});

  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {

  @override
  void initState() {
    getItemsPerWeight();
    super.initState();
  }

  Future<WeightModel> getItemsPerWeight() async {
    WeightModel itemsperpeiece = await priceController.getWeights(widget.shopId);
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
                        child: Center(child: Text('Weight',style: TextStyle(fontWeight: FontWeight.bold),)),

                      ),
                      Container(
                        height: screenHeight*0.05,
                        width: screenWidth*0.30,
                        child: Center(child: Text('Wash & Fold ',style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                      Container(
                        height: screenHeight*0.05,
                        width: screenWidth*0.30,
                        child: Center(child: Text('Wash & Iron',style: TextStyle(fontWeight: FontWeight.bold))),
                      )

                    ],
                  ),
                ),

                Container(
                  height: MediaQuery.of(context).size.height*0.55,
                  color: Colors.white,
                  child: FutureBuilder(
                    future:getItemsPerWeight() ,
                    builder: (BuildContext context,
                        AsyncSnapshot<WeightModel?> snapshot){
                      return ListView.builder(
                          itemCount: snapshot.data?.payload?.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 100,
                                      child: Center(child: Text('${snapshot.data?.payload?[index].inKg}')),

                                    ),
                                    Container(
                                      height: 40,
                                      width: 74,
                                      child: Center(child: Text('${snapshot.data?.payload?[index].washFold}')),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 74,
                                      child: Center(child: Text('${snapshot.data?.payload?[index].washIron}')),
                                    ),
                                  ],
                                ));
                          });
                    },
                  )
                ),
              ],
            )
        ),
      ),
    );
  }
}
