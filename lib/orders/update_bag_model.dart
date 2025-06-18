class UpdateBagModel {
  int? statusCode;
  String? message;
  Payload? payload;
  String? timeStamp;

  UpdateBagModel({this.statusCode, this.message, this.payload, this.timeStamp});

  UpdateBagModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    payload =
    json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}

class Payload {
  String? bagId;
  String? orderId;
  String? orderCode;
  Null? totalItems;
  int? totalWeight;
  String? pricingType;
  String? paymentType;
  String? orderStatus;
  String? orderProcess;
  List<OrderItems>? orderItems;
  int? amount;
  double? gst;
  double? payableAmount;
  String? comments;
  String? deliveryDate;
  String? deliveryTime;

  Payload(
      {this.bagId,
        this.orderId,
        this.orderCode,
        this.totalItems,
        this.totalWeight,
        this.pricingType,
        this.paymentType,
        this.orderStatus,
        this.orderProcess,
        this.orderItems,
        this.amount,
        this.gst,
        this.payableAmount,
        this.comments,
        this.deliveryDate,
        this.deliveryTime});

  Payload.fromJson(Map<String, dynamic> json) {
    bagId = json['bagId'];
    orderId = json['orderId'];
    orderCode = json['orderCode'];
    totalItems = json['totalItems'];
    totalWeight = json['totalWeight'];
    pricingType = json['pricingType'];
    paymentType = json['paymentType'];
    orderStatus = json['orderStatus'];
    orderProcess = json['orderProcess'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    amount = json['amount'];
    gst = json['gst'];
    payableAmount = json['payableAmount'];
    comments = json['comments'];
    deliveryDate = json['deliveryDate'];
    deliveryTime = json['deliveryTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bagId'] = this.bagId;
    data['orderId'] = this.orderId;
    data['orderCode'] = this.orderCode;
    data['totalItems'] = this.totalItems;
    data['totalWeight'] = this.totalWeight;
    data['pricingType'] = this.pricingType;
    data['paymentType'] = this.paymentType;
    data['orderStatus'] = this.orderStatus;
    data['orderProcess'] = this.orderProcess;
    if (this.orderItems != null) {
      data['orderItems'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['gst'] = this.gst;
    data['payableAmount'] = this.payableAmount;
    data['comments'] = this.comments;
    data['deliveryDate'] = this.deliveryDate;
    data['deliveryTime'] = this.deliveryTime;
    return data;
  }
}

class OrderItems {
  String? itemName;
  int? nos;
  int? price;

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
