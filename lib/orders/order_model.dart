class OrderModel {
  late int statusCode;
  late String message;
  late String error;
  late List<PayLoad> payload;
  late bool isPayload;

  OrderModel(
      this.statusCode, this.message, this.error, this.payload, this.isPayload);

  OrderModel.fromJSON(dynamic parsedJson) {
    this.statusCode = parsedJson['statusCode'];
    this.message = parsedJson['message'];
    if (parsedJson['payload'] != null) {
      isPayload = true;
      var myOrders = parsedJson['payload'] as List;
      this.payload =
          myOrders.map((tagJson) => PayLoad.fromJSON(tagJson)).toList();
    } else
      isPayload = false;

    error = "";
  }
  OrderModel.withError(String errorValue) : error = errorValue;
  @override
  String toString() {
    return '{ ${this.message}, ${this.message} }';
  }
}

class PayLoad {
  late int orderId;
  late int shopId;
  late int userId;
  late int addressId;
  late int totalItems;
  late double totalWeight;
  late double longitude;
  late double latitude;
  late String shopPhone;
  late String addressName;
  late String orderStatus;
  late String phoneNumber;
  late String paymentType;
  late String upiId;
  late String paidAmount;
  late String paymentStatus;
  late String transactionId;
  late String comments;
  late String pricingType;
  late String assignPdateAtime;
  late String copletedPdateAtime;
  late String assignDdateAtime;
  late String copletedDdateAtime;
  late String ceatedDate;

  PayLoad(
      this.orderId,
      this.shopId,
      this.userId,
      this.addressId,
      this.assignPdateAtime,
      this.copletedPdateAtime,
      this.assignDdateAtime,
      this.copletedDdateAtime,
      this.phoneNumber,
      this.totalItems,
      this.totalWeight,
      this.paymentType,
      this.paymentStatus,
      this.paidAmount,
      this.transactionId,
      this.comments,
      this.latitude,
      this.longitude,
      this.upiId,
      this.addressName,
      this.ceatedDate,
      this.shopPhone,
      this.orderStatus,
      this.pricingType);

  PayLoad.fromJSON(parsedJson) {
    this.orderId = parsedJson['orderId'];
    this.userId = parsedJson['userId'];
    this.ceatedDate = parsedJson['ceatedDate'];
    if (parsedJson['shopId'] != null)
      this.shopId = parsedJson['shopId'];
    else
      this.shopId = 0;
    this.phoneNumber = parsedJson['phoneNumber'];
    this.addressId = parsedJson['addressId'];
    this.orderStatus = parsedJson['orderStatus'];
    this.latitude = parsedJson['latitude'];
    this.longitude = parsedJson['longitude'];
    this.addressName = parsedJson['addressName'];

    if (parsedJson['assignPdateAtime'] != null)
      this.assignPdateAtime = parsedJson['assignPdateAtime'];
    else
      this.assignPdateAtime = "";

    if (parsedJson['copletedPdateAtime'] != null)
      this.copletedPdateAtime = parsedJson['copletedPdateAtime'];
    else
      this.copletedPdateAtime = "";

    if (parsedJson['assignDdateAtime'] != null)
      this.assignDdateAtime = parsedJson['assignDdateAtime'];
    else
      this.assignDdateAtime = "";

    if (parsedJson['copletedDdateAtime'] != null)
      this.copletedDdateAtime = parsedJson['copletedDdateAtime'];
    else
      this.copletedDdateAtime = "";

    if (parsedJson['totalItems'] != null)
      this.totalItems = parsedJson['totalItems'];
    else
      this.totalItems = 0;

    if (parsedJson['totalWeight'] != null)
      this.totalWeight = parsedJson['totalWeight'];
    else
      this.totalWeight = 0.0;

    if (parsedJson['paymentType'] != null)
      this.paymentType = parsedJson['paymentType'];
    else
      this.paymentType = "";

    if (parsedJson['paymentStatus'] != null)
      this.paymentStatus = parsedJson['paymentStatus'];
    else
      this.paymentStatus = "";

    if (parsedJson['paidAmount'] != null)
      this.paidAmount = parsedJson['paidAmount'];
    else
      this.paidAmount = "";

    if (parsedJson['transactionId'] != null)
      this.transactionId = parsedJson['transactionId'];
    else
      this.transactionId = "";

    if (parsedJson['comments'] != null)
      this.comments = parsedJson['comments'];
    else
      this.comments = "";

    if (parsedJson['shopPhone'] != null)
      this.shopPhone = parsedJson['shopPhone'];
    else
      this.shopPhone = "";

    if (parsedJson['pricingType'] != null)
      this.pricingType = parsedJson['pricingType'];
    else
      this.pricingType = "";

    if (parsedJson['upiId'] != null)
      this.upiId = parsedJson['upiId'];
    else
      this.upiId = "";
  }
  Map toJson() => {
        "orderId": orderId,
        "shopId": shopId,
        "userId": userId,
        "addressId": addressId,
        "assignPdateAtime": assignPdateAtime,
        "copletedPdateAtime": copletedPdateAtime,
        "assignDdateAtime": assignDdateAtime,
        "copletedDdateAtime": copletedDdateAtime,
        "phoneNumber": phoneNumber,
        "totalItems": totalItems,
        "totalWeight": totalWeight,
        "paymentType": paymentType,
        "paymentStatus": paymentStatus,
        "paidAmount": paidAmount,
        "transactionId": transactionId,
        "cancelReason": comments,
        "orderStatus": orderStatus,
        "pricingType": pricingType,
        "ceatedDate": ceatedDate,
        "upiId": upiId,
        "shopPhone": shopPhone,
        "addressName": addressName,
        "longitude": longitude,
        "latitude": latitude
      };

  @override
  String toString() {
    return '{ ${this.userId}, ${this.shopId},${this.orderId}, ${this.addressId}, ${this.totalWeight} }';
  }
}
