class OrderListModel {
  int? statusCode;
  String? message;
  List<OrderPayload>? payload;
  String? timeStamp;

  OrderListModel({this.statusCode, this.message, this.payload, this.timeStamp});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['payload'] != null) {
      payload = <OrderPayload>[];
      json['payload'].forEach((v) {
        payload!.add(new OrderPayload.fromJson(v));
      });
    }
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.map((v) => v.toJson()).toList();
    }
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}

class OrderPayload {
  String? orderId;
  String? shopId;
  String? customerId;
  String? locationId;
  double? lat;
  double? lng;
  String? orderCode;
  String? address;
  String? totalItems;
  double? totalWeight;
  String? orderType;
  String? paymentType;
  String? orderStatus;
  String? timeSlot;
  String? orderDate;
  String? pickupDate;
  String? pickUpTime;

  OrderPayload(
      {this.orderId,
        this.shopId,
        this.customerId,
        this.locationId,
        this.lat,
        this.lng,
        this.orderCode,
        this.address,
        this.totalItems,
        this.totalWeight,
        this.orderType,
        this.paymentType,
        this.orderStatus,
        this.timeSlot,
        this.orderDate,
        this.pickupDate,
        this.pickUpTime});

  OrderPayload.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    shopId = json['shopId'];
    customerId = json['customerId'];
    locationId = json['locationId'];
    lat = json['lat'];
    lng = json['lng'];
    orderCode = json['orderCode'];
    address = json['address'];
    totalItems = json['totalItems'];
    totalWeight = json['totalWeight'];
    orderType = json['orderType'];
    paymentType = json['paymentType'];
    orderStatus = json['orderStatus'];
    timeSlot = json['timeSlot'];
    orderDate = json['orderDate'];
    pickupDate = json['pickupDate'];
    pickUpTime = json['pickUpTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['shopId'] = this.shopId;
    data['customerId'] = this.customerId;
    data['locationId'] = this.locationId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['orderCode'] = this.orderCode;
    data['address'] = this.address;
    data['totalItems'] = this.totalItems;
    data['totalWeight'] = this.totalWeight;
    data['orderType'] = this.orderType;
    data['paymentType'] = this.paymentType;
    data['orderStatus'] = this.orderStatus;
    data['timeSlot'] = this.timeSlot;
    data['orderDate'] = this.orderDate;
    data['pickupDate'] = this.pickupDate;
    data['pickUpTime'] = this.pickUpTime;
    return data;
  }
}
