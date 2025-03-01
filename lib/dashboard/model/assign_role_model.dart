class AssignRolesModel {
  int? statusCode;
  String? message;
  Payload? payload;
  String? timeStamp;

  AssignRolesModel(
      {this.statusCode, this.message, this.payload, this.timeStamp});

  AssignRolesModel.fromJson(Map<String, dynamic> json) {
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
  String? roleAssignId;
  String? employCode;
  String? roles;
  String? clusterName;
  String? shopCode;
  String? assignDate;
  Null? stopDate;
  String? description;

  Payload(
      {this.roleAssignId,
        this.employCode,
        this.roles,
        this.clusterName,
        this.shopCode,
        this.assignDate,
        this.stopDate,
        this.description});

  Payload.fromJson(Map<String, dynamic> json) {
    roleAssignId = json['roleAssignId'];
    employCode = json['employCode'];
    roles = json['roles'];
    clusterName = json['clusterName'];
    shopCode = json['shopCode'];
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
    data['shopCode'] = this.shopCode;
    data['assignDate'] = this.assignDate;
    data['stopDate'] = this.stopDate;
    data['description'] = this.description;
    return data;
  }
}
