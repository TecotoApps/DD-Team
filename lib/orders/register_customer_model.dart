class RegisterCustomerModel {
  int? statusCode;
  String? message;
  Payload? payload;
  String? timeStamp;

  RegisterCustomerModel(
      {this.statusCode, this.message, this.payload, this.timeStamp});

  RegisterCustomerModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? name;
  String? phoneNumber;
  String? fcmToken;
  String? deviceData;
  String? createdDate;

  Payload(
      {this.userId,
        this.name,
        this.phoneNumber,
        this.fcmToken,
        this.deviceData,
        this.createdDate});

  Payload.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    fcmToken = json['fcmToken'];
    deviceData = json['deviceData'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['fcmToken'] = this.fcmToken;
    data['deviceData'] = this.deviceData;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
