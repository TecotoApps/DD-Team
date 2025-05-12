class UserCheckModel {
  int? statusCode;
  String? message;
  Payload? payload;
  String? timeStamp;

  UserCheckModel({this.statusCode, this.message, this.payload, this.timeStamp});

  UserCheckModel.fromJson(Map<String, dynamic> json) {
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
  Null? deviceData;
  Null? fcmToken;
  Null? userStatus;
  String? createdDate;
  Null? signoutDate;

  Payload(
      {this.userId,
        this.name,
        this.phoneNumber,
        this.deviceData,
        this.fcmToken,
        this.userStatus,
        this.createdDate,
        this.signoutDate});

  Payload.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    deviceData = json['deviceData'];
    fcmToken = json['fcmToken'];
    userStatus = json['userStatus'];
    createdDate = json['createdDate'];
    signoutDate = json['signoutDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['deviceData'] = this.deviceData;
    data['fcmToken'] = this.fcmToken;
    data['userStatus'] = this.userStatus;
    data['createdDate'] = this.createdDate;
    data['signoutDate'] = this.signoutDate;
    return data;
  }
}
