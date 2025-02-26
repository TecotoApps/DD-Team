import 'dart:convert';
import 'package:dd_shop/orders/order_model.dart';
import 'package:dd_shop/shop_prices/piece_model.dart';
import 'package:dd_shop/shop_prices/weight_model.dart';
import 'package:dd_shop/shop_signup/shop_model.dart';
import 'package:dd_shop/utils/components/alertDialogue.dart';
import 'package:http/http.dart';

import '../otp_generate/otp_modal.dart';

class APIService {
  //String url = 'https://10.0.2.2:8080';
  String url = 'http://35.207.255.233:90';

  Future<UserInfoModal> getEmployeeDetailsByPhone(mobile) async {
    print("this is mobile number passing, $mobile");
    Response response = await post(
      Uri.parse('$url/employ/userPhone'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode(<String, String>{'phoneNumber': '$mobile'}),
    );
    print("this is response ${response.body}");

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    // Now map the JSON Map to the UserInfoModal using the fromJson constructor
    UserInfoModal userInfoModal = UserInfoModal.fromJson(jsonResponse);

    // Return the UserInfoModal object
    return userInfoModal;
  }

  Future<EmployeePayload?> generateMPIN(empcode, mpin) async {
    print("this is empcode passing, $empcode");
    Response response = await post(
      Uri.parse('$url/employ/genratempin'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode(<String, String>{
        "employCode":"$empcode",
        "mpin":"$mpin",
      }),
    );
    print("this is response ${response.body}");

    Map<String, dynamic> jsonResponse = json.decode(response.body);
    EmployeePayload? payload;
      if(jsonResponse["statusCode"] == 200){
        payload  = EmployeePayload.fromJson(jsonResponse["payload"]);
      }else{
        payload = null;
      }
    // Now map the JSON Map to the UserInfoModal using the fromJson constructor
    // Return the UserInfoModal object
    return payload;
  }
  Future<ShopModel> verifyOTP(mobile, otp) async {
    Response response = await post(
      Uri.parse('$url/user/otp/verify'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body:
          jsonEncode(<String, String>{'phoneNumber': '$mobile', 'otp': '$otp'}),
    );
    print("this is response ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var user = ShopModel.fromJSON(userMap);
      return user;
    } else {
      var res = json.decode(response.body);
      return res;
    }
  }

  Future<ShopModel> signUp(
    shopName,
    phoneNumber,
    email,
    deviceId,
    address,
    city,
    state,
    landmark,
    pinCode,
    accountNumber,
    ifscCode,latitude,
      longitude
  ) async {
    Response response = await post(
      Uri.parse('$url/shop'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '$phoneNumber',
        'shopName': '$shopName',
        'email': '$email',
        'deviceId': '123456',
        'address': '$address',
        'city': '$city',
        'state': '$state',
        'landmark': '$landmark',
        'pinCode': '$pinCode',
        'accountNumber': '$accountNumber',
        'ifscCode': '$ifscCode',
        'latitude': '122ygugu',
        'longitude': 'gsghgh14245'
      }),
    );
    print("this is response ${response.body}");

    if (response.statusCode == 200) {
      print('inside 200');
      Map<String, dynamic> shopMap = jsonDecode(response.body);
      var shop = ShopModel.fromJSON(shopMap);
      return shop;
    } else {
      var res = json.decode(response.body);
      return res;
    }
  }

  Future<OrderModel> updateOrder(orderId, cancelReason) async {
    Response response = await put(
      Uri.parse('$url/order'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode(<String, String>{
        'orderId': '$orderId',
        'cancelReason': '$cancelReason'
      }),
    );
    print("this is response ${response.body}");

    if (response.statusCode == 201) {
      print('inside 201');
      Map<String, dynamic> orderMap = jsonDecode(response.body);
      var orders = OrderModel.fromJSON(orderMap);
      return orders;
    } else {
      var res = json.decode(response.body);
      return res;
    }
  }

  Future<OrderModel> getShopOrder(shopId) async {
    print('in services $shopId');
    Response response = await get(
      Uri.parse('$url/order/shopOrders/$shopId'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    print("this is response ${response.body}");
    if (response.statusCode == 202) {
      Map<String, dynamic> OrderMap = jsonDecode(response.body);
      OrderModel userOrders = OrderModel.fromJSON(OrderMap);
      return userOrders;
    } else {
      OrderModel res = json.decode(response.body);
      return res;
    }
  }

  Future<ItemPerWeightListModel> getWeight(shopId) async {
    Response response = await get(
      Uri.parse('$url/order/$shopId'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    print("this is response ${response.body}");
    if (response.statusCode == 202) {
      Map<String, dynamic> WeightMap = jsonDecode(response.body);
      ItemPerWeightListModel weightPrice = ItemPerWeightListModel.fromJson(WeightMap);
      return weightPrice;
    } else {
      ItemPerWeightListModel res = json.decode(response.body);
      return res;
    }
  }

  Future<ItemPerPeiceListModel> getPiece(shopId) async {
    Response response = await get(
      Uri.parse('$url/order/$shopId'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    print("this is response ${response.body}");
    if (response.statusCode == 202) {
      Map<String, dynamic> PieceMap = jsonDecode(response.body);
      ItemPerPeiceListModel weightPrice = ItemPerPeiceListModel.fromJson(PieceMap);
      return weightPrice;
    } else {
      ItemPerPeiceListModel res = json.decode(response.body);
      return res;
    }
  }


}

APIService apiService = APIService();
