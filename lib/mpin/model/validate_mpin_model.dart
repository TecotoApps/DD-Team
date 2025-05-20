import 'package:dd_shop/utils/constants/enumss.dart';

class ValidateMpinModel {
  int? statusCode;
  String? message;
  List<Payload>? payload;
  String? timeStamp;

  ValidateMpinModel(
      {this.statusCode, this.message, this.payload, this.timeStamp});

  ValidateMpinModel.fromJson(Map<String, dynamic> json) {
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
  String? roleAssignId;
  String? employCode;
  UserRole? roles;
  String? clusterName;
  String? shopId;
  String? assignDate;
  String? stopDate;
  String? description;

  Payload(
      {this.roleAssignId,
        this.employCode,
        this.roles,
        this.clusterName,
        this.shopId,
        this.assignDate,
        this.stopDate,
        this.description});

  Payload.fromJson(Map<String, dynamic> json) {
    roleAssignId = json['roleAssignId'];
    employCode = json['employCode'];
    roles = json['roles'] != null
        ? UserRole.values.firstWhere(
          (e) => e.toString().split('.').last == json['roles'],
      orElse: () => UserRole.DELIVERBOY, // Default role if not found
    )
        : null;
    clusterName = json['clusterName'];
    shopId = json['shopId'];
    assignDate = json['assignDate'];
    stopDate = json['stopDate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleAssignId'] = this.roleAssignId;
    data['employCode'] = this.employCode;
    data['roles'] = this.roles;
    data['clusterName'] = this.clusterName;
    data['shopId'] = this.shopId;
    data['assignDate'] = this.assignDate;
    data['stopDate'] = this.stopDate;
    data['description'] = this.description;
    return data;
  }
}
