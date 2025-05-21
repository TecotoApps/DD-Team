class PieceModel {
  int? statusCode;
  String? message;
  List<Payload>? payload;
  String? timeStamp;

  PieceModel({this.statusCode, this.message, this.payload, this.timeStamp});

  PieceModel.fromJson(Map<String, dynamic> json) {
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
  int? itemId;
  String? priceZone;
  String? itemName;
  int? iron;
  int? wash;
  int? washIron;
  int? dry;
  int? stain;

  Payload(
      {this.itemId,
        this.priceZone,
        this.itemName,
        this.iron,
        this.wash,
        this.washIron,
        this.dry,
        this.stain});

  Payload.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    priceZone = json['priceZone'];
    itemName = json['itemName'];
    iron = json['iron'];
    wash = json['wash'];
    washIron = json['washIron'];
    dry = json['dry'];
    stain = json['stain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['priceZone'] = this.priceZone;
    data['itemName'] = this.itemName;
    data['iron'] = this.iron;
    data['wash'] = this.wash;
    data['washIron'] = this.washIron;
    data['dry'] = this.dry;
    data['stain'] = this.stain;
    return data;
  }
}
