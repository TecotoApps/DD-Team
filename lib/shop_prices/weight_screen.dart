import 'package:dd_shop/shop_prices/price_controller.dart';
import 'package:dd_shop/shop_prices/weight_model.dart';
import 'package:flutter/material.dart';

class WeightScreen extends StatefulWidget {
  int? shopId;

  WeightScreen({required this.shopId});
  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {

  Future<ItemPerWeightListModel> getItemsPerWeight() async {
    ItemPerWeightListModel itemsperpeiece = await priceController.getWeights(widget.shopId);
    return itemsperpeiece;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 5),
        child: Container(
            height: MediaQuery.of(context).size.height*0.70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.pink.shade50,
                  height: MediaQuery.of(context).size.height*0.10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 100,
                        child: Center(child: Text('Weight',style: TextStyle(fontWeight: FontWeight.bold),)),

                      ),
                      Container(
                        height: 40,
                        width: 100,
                        child: Center(child: Text('Wash & Fold ',style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        child: Center(child: Text('Wash & Iron',style: TextStyle(fontWeight: FontWeight.bold))),
                      )

                    ],
                  ),
                ),

                Container(
                  height: MediaQuery.of(context).size.height*0.55,
                  child: FutureBuilder(
                    future:getItemsPerWeight() ,
                    builder: (BuildContext context,
                        AsyncSnapshot<ItemPerWeightListModel?> snapshot){
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
                                      child: Center(child: Text('${snapshot.data?.payload![index].inkg}')),

                                    ),
                                    Container(
                                      height: 40,
                                      width: 74,
                                      child: Center(child: Text('${snapshot.data?.payload![index].washFold}')),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 74,
                                      child: Center(child: Text('${snapshot.data?.payload![index].washIron}')),
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
