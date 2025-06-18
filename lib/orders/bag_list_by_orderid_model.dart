class BagListByOrderIdModel {
  int? statusCode;
  String? message;
  List<BagListPayload>? payload;
  String? timeStamp;

  BagListByOrderIdModel({this.statusCode, this.message, this.payload, this.timeStamp});

  BagListByOrderIdModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['payload'] != null) {
      payload = <BagListPayload>[];
      json['payload'].forEach((v) {
        payload!.add(new BagListPayload.fromJson(v));
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

class BagListPayload {
  String? bagId;
  String? orderId;
  String? orderCode;
  int? totalItems;
  double? totalWeight;
  String? pricingType;
  String? paymentType;
  String? orderStatus;
  String? orderProcess;
  List<OrderItems>? orderItems;
  double? amount;
  double? gst;
  double? payableAmount;
  String? comments;
  String? deliveryDate;
  String? deliveryTime;

  BagListPayload(
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

  BagListPayload.fromJson(Map<String, dynamic> json) {
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
