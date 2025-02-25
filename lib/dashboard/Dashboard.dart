import 'package:dd_shop/orders/order_pickup_details.dart';
import 'package:dd_shop/services/sharedPress.dart';
import 'package:dd_shop/utils/components/ImageSlider.dart';
import 'package:dd_shop/utils/components/dd_elevated_buttons.dart';
import 'package:dd_shop/utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  late String titleName = "Dhobi Dosth";
  late String name = '';
  int? userId;
  String verifymsg = '';

  @override
  void initState() {
    getId();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: Container(
              child: Text(titleName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'OpenSansSemiBold'))),
          actions: [
            GestureDetector(
                onTap: () {
                  //logout();
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(
                    'images/logout.png',
                    height: 24,
                    width: 24,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                ImageSlider(),
                SizedBox(
                  height: 5,
                ),
                Card(
                  color: Colors.white,
                  child: ListTile(
                    minVerticalPadding: 20.0,
                    leading: Image.asset('images/logo.png'),
                    title: Text(
                      "Hi" + ' ' + name,
                      style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    ),
                    subtitle: Text(
                      " Welcome to Dhobi Dosth",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  elevation: 8,
                  shadowColor: Colors.green,
                  margin: EdgeInsets.all(20),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.green, width: 1)),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                      //padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      child: DD_ElevatedButton(
                        onPressed: () async {

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderPickupDetails()));
                          /* var result =
                              await locationController.getLocation(userId);
                          if (result.statusCode == 202) {
                            if (result.isPayload == true) {
                              if (result.payload != null) {
                                print(result.payload);
                                verifymsg = result.message;
                                Fluttertoast.showToast(
                                    msg: verifymsg,
                                    toastLength: Toast.LENGTH_LONG,
                                    fontSize: 20,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.blueAccent);
                                */ /*Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LocationScreen()));*/ /*
                              }
                            }
                          } else {
                            print('failed to get locations');
                          }*/
                        },
                        hintText: 'Order Now',
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  getData() async {
    String? name1 = await sharedPress.getData(Dd_Strings.SHOPNAME);
    print(name1);
    if (name1 != null) {
      setState(() {
        name = name1;
      });
    }
  }

  getId() async {
    int? userid = await sharedPress.getId(Dd_Strings.SHOPID);
    print(userid);
    if (userid != null) {
      setState(() {
        userId = userid;
      });
    }
  }
}
