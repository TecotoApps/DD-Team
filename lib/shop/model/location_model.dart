class LocationModel {
  int? statusCode;
  String? message;
  List<Payload>? payload;
  String? timeStamp;

  LocationModel({this.statusCode, this.message, this.payload, this.timeStamp});

  LocationModel.fromJSON(Map<String, dynamic> json) {
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
  String? locationId;
  String? userId;
  String? address;
  String? landmark;
  double? lat;
  double? lng;
  String? orderStatus;
  String? createDate;

  Payload(
      {this.locationId,
        this.userId,
        this.address,
        this.landmark,
        this.lat,
        this.lng,
        this.orderStatus,
        this.createDate});

  Payload.fromJson(Map<String, dynamic> json) {
    locationId = json['locationId'];
    userId = json['userId'];
    address = json['address'];
    landmark = json['landmark'];
    lat = json['lat'];
    lng = json['lng'];
    orderStatus = json['orderStatus'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationId'] = this.locationId;
    data['userId'] = this.userId;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['orderStatus'] = this.orderStatus;
    data['createDate'] = this.createDate;
    return data;
  }
}
