import 'package:dd_shop/shop_prices/piece_screen.dart';
import 'package:dd_shop/shop_prices/weight_screen.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  int? shopId;

  PriceScreen({required this.shopId});
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // actionsIconTheme: IconThemeData(color:  Colors.pink.shade600),
          iconTheme:  IconThemeData(color:  Colors.white),
          backgroundColor: Colors.pink.shade600,
          title: Text("Our Prices"),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: "Per Kg",
              ),
              Tab(
                text: "Per Piece",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [WeightScreen(shopId: widget.shopId,),Pricing(shopId:widget.shopId)],
        ),
      ),
    );
  }
}
