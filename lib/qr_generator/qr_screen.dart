import 'package:flutter/material.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class QR_Screen extends StatefulWidget{
  final String shopId;
  final String upiID;
  final String amount;
  const QR_Screen({Key? key, required this.upiID, required this.shopId, required this.amount}) : super(key: key);

  @override
  State<QR_Screen> createState() => _QR_ScreenState();

}

class _QR_ScreenState extends State<QR_Screen> {
  final upiDetails = UPIDetails(
      upiID: "nithyapramodgc-2@okicici",
      payeeName: "shop-name",
      amount: 20,
      transactionID: "123456abcdefgh");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scan QR to Pay'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text("Thank You for choosing Dhobi Dosth",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              UPIPaymentQRCode(
                upiDetails: upiDetails,
                size: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Payable amount is ",
                style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
