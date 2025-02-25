import 'package:dd_shop/shop_prices/piece_model.dart';
import 'package:dd_shop/shop_prices/price_controller.dart';
import 'package:flutter/material.dart';

class Pricing extends StatefulWidget {
  int? shopId;
  Pricing({required this.shopId});

  @override
  State<Pricing> createState() => _PricingState();
}

class _PricingState extends State<Pricing> {


  Future<ItemPerPeiceListModel> getItemsPerPeice() async {
    ItemPerPeiceListModel itemsperpeiece = await priceController.getPieces(widget.shopId);
    return itemsperpeiece;
  }

  @override
  void initState() {
    // TODO: implement initState
    print("inisdne per peiecepeircing ");
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
                      width: 90,
                       child: Center(child: Text('Type',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                    Container(
                      height: 40,
                      width: 70,
                       child: Center(child: Text('Only \nWash',style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      child: Center(child: Text('Wash & Fold',style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    Container(
                      height: 40,
                      width: 70,
                       child: Center(child: Text('Iron \nonly',style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    Container(
                      height: 40,
                      width: 70,
                      child: Center(child: Text('Wash & \n Iron',style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                  ],
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height*0.55,
                child: FutureBuilder(
                  future: getItemsPerPeice(),
                  builder: (BuildContext context,
                      AsyncSnapshot<ItemPerPeiceListModel?> snapshot){
                    print("this is snapshot per peiece${snapshot.hasData}");
                    print("this is snapshot ${snapshot.hasData}");
                    print("this is snapshot.items");
                    return ListView.builder(
                        itemCount: snapshot.data?.payload?.length,
                        itemBuilder: (BuildContext context, int index){
                          return Container(
                              height: 50,
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 100,
                                    child: Center(child: Text('${snapshot.data?.payload![index]?.itemName}')),

                                  ),
                                  Container(
                                    height: 40,
                                    width: 74,
                                    child: Center(child: Text('${snapshot.data?.payload![index].wash}')),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 74,
                                    child: Center(child: Text('${snapshot.data?.payload![index].dry}')),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 74,
                                    child: Center(child: Text('${snapshot.data?.payload![index].iron}')),
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

                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}


