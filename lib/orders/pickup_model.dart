class PickupModel {
  int? statusCode;
  String? message;
  List<Payload>? payload;
  String? timeStamp;

  PickupModel({this.statusCode, this.message, this.payload, this.timeStamp});

  PickupModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(new Payload.fromJson(v));
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

class Payload {
  String? orderId;
  String? shopId;
  String? customerId;
  String? locationId;
  double? lat;
  double? lng;
  String? orderCode;
  String? address;
  String? bagNo;
  List<OrderItems>? orderItems;
  int? totalItems;
  double? totalWeight;
  String? orderType;
  String? pricingType;
  String? paymentType;
  String? orderStatus;
  String? timeSlot;
  double? amount;
  double? gst;
  double? payableAmount;
  double? discount;
  String? comments;
  String? orderDate;
  String? pickupDate;
  String? deliveryDate;
  String? deliveryTime;
  String? pickUpTime;

  Payload(
      {this.orderId,
        this.shopId,
        this.customerId,
        this.locationId,
        this.lat,
        this.lng,
        this.orderCode,
        this.address,
        this.bagNo,
        this.orderItems,
        this.totalItems,
        this.totalWeight,
        this.orderType,
        this.pricingType,
        this.paymentType,
        this.orderStatus,
        this.timeSlot,
        this.amount,
        this.gst,
        this.payableAmount,
        this.discount,
        this.comments,
        this.orderDate,
        this.pickupDate,
        this.deliveryDate,
        this.deliveryTime,
        this.pickUpTime});

  Payload.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    shopId = json['shopId'];
    customerId = json['customerId'];
    locationId = json['locationId'];
    lat = json['lat'];
    lng = json['lng'];
    orderCode = json['orderCode'];
    address = json['address'];
    bagNo = json['bagNo'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    totalItems = json['totalItems'];
    totalWeight = json['totalWeight'];
    orderType = json['orderType'];
    pricingType = json['pricingType'];
    paymentType = json['paymentType'];
    orderStatus = json['orderStatus'];
    timeSlot = json['timeSlot'];
    amount = json['amount'];
    gst = json['gst'];
    payableAmount = json['payableAmount'];
    discount = json['discount'];
    comments = json['comments'];
    orderDate = json['orderDate'];
    pickupDate = json['pickupDate'];
    deliveryDate = json['deliveryDate'];
    deliveryTime = json['deliveryTime'];
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
    data['bagNo'] = this.bagNo;
    if (this.orderItems != null) {
      data['orderItems'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['totalItems'] = this.totalItems;
    data['totalWeight'] = this.totalWeight;
    data['orderType'] = this.orderType;
    data['pricingType'] = this.pricingType;
    data['paymentType'] = this.paymentType;
    data['orderStatus'] = this.orderStatus;
    data['timeSlot'] = this.timeSlot;
    data['amount'] = this.amount;
    data['gst'] = this.gst;
    data['payableAmount'] = this.payableAmount;
    data['discount'] = this.discount;
    data['comments'] = this.comments;
    data['orderDate'] = this.orderDate;
    data['pickupDate'] = this.pickupDate;
    data['deliveryDate'] = this.deliveryDate;
    data['deliveryTime'] = this.deliveryTime;
    data['pickUpTime'] = this.pickUpTime;
    return data;
  }
}

class OrderItems {
  String? itemName;
  int? nos;
  double? price;

  OrderItems({this.itemName, this.nos, this.price});

  OrderItems.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    nos = json['nos'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['nos'] = this.nos;
    data['price'] = this.price;
    return data;
  }
}
