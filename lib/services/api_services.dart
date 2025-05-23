import 'dart:convert';
import 'package:dd_shop/dashboard/model/add_employee.dart';
import 'package:dd_shop/dashboard/model/add_new_cluster.dart';
import 'package:dd_shop/dashboard/model/add_shop_to_cluster.dart';
import 'package:dd_shop/dashboard/model/assign_role_model.dart';
import 'package:dd_shop/dashboard/model/order_list_model.dart';
import 'package:dd_shop/employee/model/employee_list_model.dart';
import 'package:dd_shop/hr/model/role_list_model.dart';
import 'package:dd_shop/mpin/model/validate_mpin_model.dart';
import 'package:dd_shop/orders/create_order_model.dart';
import 'package:dd_shop/orders/pickup_model.dart';
import 'package:dd_shop/orders/piece_model.dart';
import 'package:dd_shop/orders/register_customer_model.dart';
import 'package:dd_shop/orders/user_check_model.dart';
import 'package:dd_shop/orders/weight_model.dart';
import 'package:dd_shop/shop/model/location_model.dart';
import 'package:dd_shop/shop_signup/shop_model.dart';
import 'package:http/http.dart';

import '../otp_generate/otp_modal.dart';

class APIService {
  //String url = 'https://10.0.2.2:8080';
  String url = 'http://35.207.255.233:80';

  static const Map<String, String> _headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "SECURE-API-KEY":"336924d18ed3718f48dc62b5ae3032afe387d5dc86685e5d43ad04bf2cc41f60"
  };

  Future<UserInfoModal> getEmployeeDetailsByPhone(mobile) async {
    print("this is mobile number passing, $mobile");
    Response response = await post(
      Uri.parse('$url/employ/userPhone'),
      headers: _headers,
      body: jsonEncode(<String, String>{'phoneNumber': '$mobile'}),
    );
    print("this is response ${response.body}");

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    // Now map the JSON Map to the UserInfoModal using the fromJson constructor
    UserInfoModal userInfoModal = UserInfoModal.fromJson(jsonResponse);

    // Return the UserInfoModal object
    return userInfoModal;
  }

  Future<UserCheckModel> getUserDetailsByPhone(mobile) async {
    print("this is mobile number passing, $mobile");
    Response response = await post(
      Uri.parse('$url/user/userPhone'),
      headers: _headers,
      body: jsonEncode(<String, String>{'phoneNumber': '$mobile'}),
    );
    print("this is response ${response.body}");

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    // Now map the JSON Map to the UserInfoModal using the fromJson constructor
    UserCheckModel userInfoModal = UserCheckModel.fromJson(jsonResponse);

    // Return the UserInfoModal object
    return userInfoModal;
  }

  Future<UserInfoModal?> generateMPIN(empcode, mpin) async {
    print("this is empcode passing, $empcode");
    Response response = await post(
      Uri.parse('$url/employ/genratempin'),
      headers: _headers,
      body: jsonEncode(<String, String>{
        "employCode": "$empcode",
        "mpin": "$mpin",
      }),
    );
    print("this is response ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var user = UserInfoModal.fromJson(userMap);
      return user;
    } else {
      var res = json.decode(response.body);
      return res;
    }
  }

  Future<ValidateMpinModel?> validateMpin(empcode, mpin) async {
    print("this is empcode passing, $empcode");
    Response response = await post(
      Uri.parse('$url/employ/validatempin'),
      headers: _headers,
      body: jsonEncode(<String, String>{
        "employCode": "$empcode",
        "mpin": "$mpin",
      }),
    );
    print("this is response ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var user = ValidateMpinModel.fromJson(userMap);
      return user;
    } else {
      var res = json.decode(response.body);
      return res;
    }

    // Map<String, dynamic> jsonResponse = json.decode(response.body);
    // ValidateMpinModel? payload;
    //
    // payload = ValidateMpinModel.fromJson(jsonResponse);

    // Now map the JSON Map to the UserInfoModal using the fromJson constructor
    // Return the UserInfoModal object
    // return payload;
  }

  Future<ShopModel> verifyOTP(mobile, otp) async {
    Response response = await post(
      Uri.parse('$url/user/otp/verify'),
      headers: _headers,
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
      ifscCode,
      latitude,
      longitude) async {
    Response response = await post(
      Uri.parse('$url/shop'),
      headers: _headers,
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

  Future getShopOrder(shopId) async {
    print('in services $shopId');
    Response response = await get(Uri.parse('$url/order/shopOrders/$shopId'),
        headers: _headers);
    print("this is response ${response.body}");
    if (response.statusCode == 200) {
      var OrderMap = jsonDecode(response.body);
      // var userOrders = OrderlistModel.fromJson(OrderMap);
      return OrderMap;
    } else {
      OrderListModel res = json.decode(response.body);
      return res;
    }
  }


  Future deliveryOders(empCode) async {
    print('in services $empCode');
    Response response = await get(Uri.parse('$url/order/deliverOrders/$empCode'),
        headers: _headers);
    print("this is response ${response.body}");
    if (response.statusCode == 200) {
      var OrderMap = jsonDecode(response.body);
      // var userOrders = OrderlistModel.fromJson(OrderMap);
      return OrderMap;
    } else {
      var res = json.decode(response.body);
      return res;
    }
  }

  Future<EmployeeListModel> getEmployeeList() async {
    Response response =
        await get(Uri.parse('$url/employ/allemploys'), headers: _headers);
    print("this is response ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> employeeMap = jsonDecode(response.body);
      EmployeeListModel employeeListModel =
          EmployeeListModel.fromJson(employeeMap);
      return employeeListModel;
    } else {
      EmployeeListModel res = json.decode(response.body);
      return res;
    }
  }

  Future<RoleListModel> getRolesList() async {
    Response response =
        await get(Uri.parse('$url/roles/allroles'), headers: _headers);
    print("this is response ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> allRolesMap = jsonDecode(response.body);
      RoleListModel roleListModel = RoleListModel.fromJson(allRolesMap);
      return roleListModel;
    } else {
      RoleListModel res = json.decode(response.body);
      return res;
    }
  }

  Future<bool> createNewRole(String role, String Description) async {
    Response response = await post(
      Uri.parse('$url/roles/regrole'),
      headers: _headers,
      body: jsonEncode(
          <String, String>{"roles": "$role", "description": "$Description"}),
    );
    print("this is response ${response.body}");
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editRole(String roleId, String role, String Description) async {
    Response response = await put(
      Uri.parse('$url/roles/updaterole'),
      headers: _headers,
      body: jsonEncode(<String, String>{
        "roleId": "$roleId",
        "roles": "$role",
        "description": "$Description"
      }),
    );
    print("this is response of update role ${response.body}");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  Future<AddShopToClusterModel> addShopToCluster(shopId, clusterId) async {
    Response response = await put(
      Uri.parse('$url/shop/addToCluster'),
      headers: _headers,
      body: jsonEncode(
          <String, String>{'shopId': '$shopId', 'clusterId': '$clusterId'}),
    );
    print("this is response ${response.body}");

    if (response.statusCode == 200) {
      print('inside 200');
      Map<String, dynamic> orderMap = jsonDecode(response.body);
      var orders = AddShopToClusterModel.fromJson(orderMap);
      return orders;
    } else {
      var res = json.decode(response.body);
      return res;
    }
  }

  Future<AddClusterModel> addCluster(clusterName, description) async {
    Response response = await put(
      Uri.parse('$url/shop/addcluster'),
      headers: _headers,
      body: jsonEncode(<String, String>{
        'clusterName': '$clusterName',
        'description': '$description'
      }),
    );
    print("this is response ${response.body}");

    if (response.statusCode == 201) {
      print('inside 201');
      Map<String, dynamic> orderMap = jsonDecode(response.body);
      var orders = AddClusterModel.fromJson(orderMap);
      return orders;
    } else {
      var res = json.decode(response.body);
      return res;
    }
  }

  updateOrderStatus(orderId, orderStatus) async{
    print("this is orderId $orderId and status $orderStatus");
    Response response = await put(
      Uri.parse('$url/order/orderStatus'),
      headers: _headers,
      body: jsonEncode(<String, String>{
        "orderId": "$orderId",
        "orderStatus": "$orderStatus",
        "comments":"order picked up intime"
      }),
    );
    print("this is response of update order ${response.body}");

    if (response.statusCode == 200) {
      print('inside 201');
      return true;
    } else {
      return false;
    }
  }
  Future<PickupModel> confirmPickup(orderId,bagNo,totalItems,totalWeight,comments,pricingType,orderItems) async{
    print("this is orderId $orderId and status $orderId");
    Response response = await put(
      Uri.parse('$url/order/pickup'),
      headers: _headers,
      body: jsonEncode(<String, dynamic>{
        "orderId": orderId,
        "bagNo": bagNo,
        "totalItems": totalItems,
        "totalWeight": totalWeight,
        "comments": comments,
        "pricingType": pricingType,
        "orderItems":orderItems
      }),
    );
    print("this is response of update order ${response.body}");

    if (response.statusCode == 200) {

      Map<String, dynamic> jsonResponse = json.decode(response.body);
      PickupModel userInfoModal = PickupModel.fromJson(jsonResponse);
      return userInfoModal;

    } else {
      PickupModel res = json.decode(response.body);
      return res;
    }
  }

  Future<UserInfoModal> addShop(phoneNumber, imageUrl, city, state) async {
    print("this is mobile number passing, $phoneNumber");
    Response response = await post(
      Uri.parse('$url/shop/addshop'),
      headers: _headers,
      body: jsonEncode(<String, String>{
        "phoneNumber": "$phoneNumber",
        "imageUrl": "$imageUrl",
        "shopType": "REGULAR",
        "shopOwnership": "COMPANY",
        "city": "$city",
        "state": "$state"
      }),
    );
    print("this is response ${response.body}");

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    // Now map the JSON Map to the UserInfoModal using the fromJson constructor
    UserInfoModal userInfoModal = UserInfoModal.fromJson(jsonResponse);

    // Return the UserInfoModal object
    return userInfoModal;
  }

  Future<AddEmployeeModel> addEmployeeByHR(
      employName, employPhone, email, description, joinDate) async {
    print("this is mobile number passing, $employPhone");
    Response response = await post(
      Uri.parse('$url/employ/regemploy'),
      headers: _headers,
      body: jsonEncode(<String, String>{
        "employName": "$employName",
        "employPhone": "$employPhone",
        "aadharCopy": "abc.pdf",
        "panCopy": "abc.pdf",
        "photo": "abc.jpeg",
        "email": "$email",
        "description": "$description",
        "joinDate": "$joinDate"
      }),
    );
    print("this is response ${response.body}");

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    // Now map the JSON Map to the UserInfoModal using the fromJson constructor
    AddEmployeeModel addEmployeeModel = AddEmployeeModel.fromJson(jsonResponse);

    // Return the UserInfoModal object
    return addEmployeeModel;
  }

  Future<AddEmployeeModel> updateEmployeeDataByHR(employCode, employName,
      employPhone, email, description, roles, joinDate) async {
    print("this is mobile number passing, $employPhone");
    Response response = await post(
      Uri.parse('$url/employ/regemploy'),
      headers: _headers,
      body: jsonEncode(<String, String>{
        "employCode": "$employCode",
        "employName": "$employName",
        "employPhone": "$employPhone",
        "aadharCopy": "abc.pdf",
        "panCopy": "abc.pdf",
        "photo": "abc.jpeg",
        "email": "$email",
        "description": "$description",
        "roles": "$roles",
        "joinDate": "$joinDate"
      }),
    );
    print("this is response ${response.body}");

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    // Now map the JSON Map to the UserInfoModal using the fromJson constructor
    AddEmployeeModel addEmployeeModel = AddEmployeeModel.fromJson(jsonResponse);

    // Return the UserInfoModal object
    return addEmployeeModel;
  }

  Future<AssignRolesModel> assignRoles({
    roles,
    clusterName,
    employCode,
    shopId,
    assignDate,
    stopDate,
    description,
  }) async {
    Response response = await post(
      Uri.parse('$url/roles/assignrole'),
      headers: _headers,
      body: jsonEncode(<String, String>{
        "roles": "$roles",
        "clusterName": "$clusterName",
        "employCode": "$employCode",
        "shopId": "$shopId",
        "assignDate": "$assignDate",
        "stopDate": "$stopDate",
        "description": "$description"
      }),
    );
    print("this is response ${response.body}");

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    // Now map the JSON Map to the UserInfoModal using the fromJson constructor
    AssignRolesModel assignRolesModel = AssignRolesModel.fromJson(jsonResponse);

    // Return the UserInfoModal object
    return assignRolesModel;
  }

  Future<LocationModel> addLocation(
      id, address, city, landmark, latitude, longitude) async {
    print(
        "this is userid---->$id, address--->$address, landmark---->$landmark, lat-->$latitude, long---->$longitude");
    Response response = await post(
      Uri.parse('$url/location/save'),
      headers: _headers, //78c2ee77-5302-4ae2-afa9-54a8e76ebf3b
      body: jsonEncode(<String, String>{
        'userId': '$id',
        'address': '$address, $city',
        'landmark': '$landmark',
        'lat': '$latitude',
        'lng': '$longitude'
      }),
    );
    print("this is response ${response.body}");

    if (response.statusCode == 201) {
      print('inside 201');
      Map<String, dynamic> locationMap = jsonDecode(response.body);
      LocationModel locations = LocationModel.fromJSON(locationMap);
      return locations;
    } else {
      LocationModel res = json.decode(response.body);
      return res;
    }
  }

  Future<LocationModel> getLocation(userId) async {
    print('fetching locaitons');
    Response response = await get(
        Uri.parse('$url/location/$userId'),
        headers: _headers
    );
    print("this is response ${response.body}");
    if (response.statusCode == 201) {
      Map<String, dynamic> locationMap = jsonDecode(response.body);
      LocationModel locations = LocationModel.fromJSON(locationMap);
      return locations;
    } else {
      LocationModel res = json.decode(response.body);
      return res;
    }
  }

  Future<CreateOrderModel> createOrder(customerId, locationId, shopId,comments,address,timeSlot,orderDate) async {
    Response response = await post(
      Uri.parse('$url/order/create'),
      headers: _headers,
      body: jsonEncode(<String, String>{
        'customerId': '$customerId',
        'shopId': '$shopId',
        'locationId': '$locationId',
        'comments':'$comments',
        'address':'$address',
        'timeSlot':'$timeSlot',
        'orderDate':'$orderDate'
      }),
    );
    print("this is response ${response.body}");

    if (response.statusCode == 200) {
      print('inside 200');
      Map<String, dynamic> orderMap = jsonDecode(response.body);
      CreateOrderModel orders = CreateOrderModel.fromJson(orderMap);
      return orders;
    } else {
      Map<String, dynamic> res = json.decode(response.body);
      CreateOrderModel result = CreateOrderModel.fromJson(res);
      return result;
    }
  }

  Future<RegisterCustomerModel> registerCustomer(mobile, name) async {
    print("this is username $mobile and mobile $name ");
    Response response = await post(
      Uri.parse('$url/user/register'),
      headers: _headers,
      body: jsonEncode(
          <String, String>{'phoneNumber': '$mobile', 'name': '$name',
            'userType':'CUSTOMER', 'fcmToken':'', 'deviceData': ''}),
    );
    print("this is response ${response.body}");

    if (response.statusCode == 201) {
      print('inside 200');
      Map<String, dynamic> userMap = jsonDecode(response.body);
      var user = RegisterCustomerModel.fromJson(userMap);
      return user;
    } else {
      var res = json.decode(response.body);
      return res;
    }
  }

  Future<UserInfoModal> pickupOrder(phoneNumber, imageUrl, city, state) async {
    print("this is mobile number passing, $phoneNumber");
    Response response = await post(
      Uri.parse('$url/order/pickup'),
      headers: _headers,
      body: jsonEncode(<String, String>{
        "phoneNumber": "$phoneNumber",
        "imageUrl": "$imageUrl",
        "shopType": "REGULAR",
        "shopOwnership": "COMPANY",
        "city": "$city",
        "state": "$state"
      }),
    );
    print("this is response ${response.body}");

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    // Now map the JSON Map to the UserInfoModal using the fromJson constructor
    UserInfoModal userInfoModal = UserInfoModal.fromJson(jsonResponse);

    // Return the UserInfoModal object
    return userInfoModal;
  }

  Future<bool> updateLocationToOrder( orderId, locationId, address, lat, lng) async {
    Response response = await put(
      Uri.parse('$url/order/addLocation'),
      headers: _headers,
      body: jsonEncode(<String, String>{
        "userId": "$orderId",
        "locationId": "$locationId",
        "address":'$address',
        "lat":lat,
        "lng":lng
      }),
    );
    print("this is response of update role ${response.body}");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<PieceModel> getItemPriceByPeice(shopId) async {
    Response response = await get(
        Uri.parse('$url/item/zone/ZONEONE'),
        headers: _headers
    );
    print("this is response ItemPerPeiceListModel ${response.body}");
    if (response.statusCode == 200) {
      print('inside 202');
      Map<String, dynamic> perPeiceItemMap = jsonDecode(response.body);
      PieceModel perPeiceItems = PieceModel.fromJson(perPeiceItemMap);
      return perPeiceItems;
    } else {
      PieceModel res = json.decode(response.body);
      return res;
    }
  }

  Future<WeightModel> getItemPriceByWeight(shopId) async {
    Response response = await get(
        Uri.parse('$url/weight/zone/ZONEONE'),
        headers: _headers
    );
    print("this is response ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> WeightMap = jsonDecode(response.body);
      WeightModel weightPrice = WeightModel.fromJson(WeightMap);
      return weightPrice;
    } else {
      WeightModel res = json.decode(response.body);
      return res;
    }
  }


}

APIService apiService = APIService();
