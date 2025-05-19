class CreateOrderModel {
  int? statusCode;
  String? message;
  List<Payload>? payload;
  String? timeStamp;

  CreateOrderModel({this.statusCode, this.message, this.payload, this.timeStamp});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
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
  String? bagNo;
  int? totalItems;
  double? totalWeight;
  String? pricingType;
  String? paymentType;
  String? orderStatus;
  String? timeSlot;
  double? amount;
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
        this.bagNo,
        this.totalItems,
        this.totalWeight,
        this.pricingType,
        this.paymentType,
        this.orderStatus,
        this.timeSlot,
        this.amount,
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
    bagNo = json['bagNo'];
    totalItems = json['totalItems'];
    totalWeight = json['totalWeight'];
    pricingType = json['pricingType'];
    paymentType = json['paymentType'];
    orderStatus = json['orderStatus'];
    timeSlot = json['timeSlot'];
    amount = json['amount'];
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
    data['bagNo'] = this.bagNo;
    data['totalItems'] = this.totalItems;
    data['totalWeight'] = this.totalWeight;
    data['pricingType'] = this.pricingType;
    data['paymentType'] = this.paymentType;
    data['orderStatus'] = this.orderStatus;
    data['timeSlot'] = this.timeSlot;
    data['amount'] = this.amount;
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
