class WeightModel {
  int? statusCode;
  String? message;
  List<Payload>? payload;
  String? timeStamp;

  WeightModel({this.statusCode, this.message, this.payload, this.timeStamp});

  WeightModel.fromJson(Map<String, dynamic> json) {
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
  int? weightId;
  String? priceZone;
  String? inKg;
  int? washFold;
  int? washIron;

  Payload(
      {this.weightId, this.priceZone, this.inKg, this.washFold, this.washIron});

  Payload.fromJson(Map<String, dynamic> json) {
    weightId = json['weightId'];
    priceZone = json['priceZone'];
    inKg = json['inKg'];
    washFold = json['washFold'];
    washIron = json['washIron'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weightId'] = this.weightId;
    data['priceZone'] = this.priceZone;
    data['inKg'] = this.inKg;
    data['washFold'] = this.washFold;
    data['washIron'] = this.washIron;
    return data;
  }
}
