class RoleListModel {
  int? statusCode;
  String? message;
  List<RolePayload>? payload;
  String? timeStamp;

  RoleListModel({this.statusCode, this.message, this.payload, this.timeStamp});

  RoleListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['payload'] != null) {
      payload = <RolePayload>[];
      json['payload'].forEach((v) {
        payload!.add(new RolePayload.fromJson(v));
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

class RolePayload {
  String? roleId;
  String? roles;
  String? description;

  RolePayload({this.roleId, this.roles, this.description});

  RolePayload.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    roles = json['roles'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleId'] = this.roleId;
    data['roles'] = this.roles;
    data['description'] = this.description;
    return data;
  }
}
