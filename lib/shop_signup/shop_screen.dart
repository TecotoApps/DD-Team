import 'package:dd_shop/orders/price_home.dart';
import 'package:dd_shop/services/sharedPress.dart';
import 'package:dd_shop/utils/components/dd_elevated_buttons.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  late double latitude = '' as double;
  late double langitude = '' as double;

  getLat() async {
    double? lat = await sharedPress.getLatLag(Dd_Strings.SHOPLAT);
    if (lat != null) {
      setState(() {
        latitude = lat;
      });
    }
  }

  getLag() async {
    double? lag = await sharedPress.getLatLag(Dd_Strings.SHOPLAG);
    if (lag != null) {
      setState(() {
        langitude = lag;
      });
    }
  }

  @override
  void initState() {
    getLat();
    getLag();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Container(
            child: Text('Shop Name',
                style: TextStyle(
                    color: Colors.pink.shade600,
                    fontSize: 20,
                    fontFamily: 'OpenSansSemiBold'))),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.asset('images/shopimg.jpeg',fit:BoxFit.fitWidth ,),
              ),
              SizedBox(height: 30,),
              Text('My Shop',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text('Shop Address',style: TextStyle(fontSize: 18,color: Colors.grey),),
              SizedBox(height: 10,),
              Text('Call- 9393939399',style: TextStyle(fontSize: 18,color: Colors.grey),),
              SizedBox(height: 50,),
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width:100,
                      child: DD_ElevatedButton(
                          hintText: 'Pricing',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PriceScreen(shopId: '7')));
                          }),
                    ),
                    SizedBox(
                      width:140,
                      child: DD_ElevatedButton(
                        hintText: 'Locate on Map',
                        onPressed: () async{

                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

