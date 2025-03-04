import 'dart:convert';
import 'package:dd_shop/dashboard/model/add_employee.dart';
import 'package:dd_shop/dashboard/model/add_new_cluster.dart';
import 'package:dd_shop/dashboard/model/add_shop_to_cluster.dart';
import 'package:dd_shop/dashboard/model/assign_role_model.dart';
import 'package:dd_shop/employee/model/employee_list_model.dart';
import 'package:dd_shop/hr/model/role_list_model.dart';
import 'package:dd_shop/mpin/model/validate_mpin_model.dart';
import 'package:dd_shop/orders/model/shop_order_model.dart';
import 'package:dd_shop/orders/order_model.dart';
import 'package:dd_shop/shop/model/location_model.dart';
import 'package:dd_shop/shop_prices/piece_model.dart';
import 'package:dd_shop/shop_prices/weight_model.dart';
import 'package:dd_shop/shop_signup/shop_model.dart';
import 'package:dd_shop/utils/components/alertDialogue.dart';
import 'package:http/http.dart';

import '../otp_generate/otp_modal.dart';

class APIService {
  //String url = 'https://10.0.2.2:8080';
  String url = 'http://35.207.255.233:90';

  static const Map<String, String> _headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
  };

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

    Map<String, dynamic> jsonResponse = json.decode(response.body);
    UserInfoModal? payload;
    if (jsonResponse["statusCode"] == 200) {
      payload = UserInfoModal.fromJson(jsonResponse["payload"]);
    } else {
      payload = null;
    }
    // Now map the JSON Map to the UserInfoModal using the fromJson constructor
    // Return the UserInfoModal object
    return payload;
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

    Map<String, dynamic> jsonResponse = json.decode(response.body);
    ValidateMpinModel? payload;

    payload = ValidateMpinModel.fromJson(jsonResponse);

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
      ifscCode,
      latitude,
      longitude) async {
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

  Future<ShopOrderModel> getShopOrder(shopId) async {
    print('in services $shopId');
    Response response = await get(Uri.parse('$url/order/shopOrders/$shopId'),
        headers: _headers);
    print("this is response ${response.body}");
    if (response.statusCode == 202) {
      Map<String, dynamic> OrderMap = jsonDecode(response.body);
      ShopOrderModel userOrders = ShopOrderModel.fromJson(OrderMap);
      return userOrders;
    } else {
      ShopOrderModel res = json.decode(response.body);
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
      ItemPerWeightListModel weightPrice =
          ItemPerWeightListModel.fromJson(WeightMap);
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
      ItemPerPeiceListModel weightPrice =
          ItemPerPeiceListModel.fromJson(PieceMap);
      return weightPrice;
    } else {
      ItemPerPeiceListModel res = json.decode(response.body);
      return res;
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
      id, addressName, address, city, landmark, latitude, longitude) async {
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
}

APIService apiService = APIService();
