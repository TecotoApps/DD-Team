class EmployeeListModel {
  int? statusCode;
  String? message;
  List<Payload>? payload;
  String? timeStamp;

  EmployeeListModel(
      {this.statusCode, this.message, this.payload, this.timeStamp});

  EmployeeListModel.fromJson(Map<String, dynamic> json) {
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
  String? employId;
  String? employCode;
  String? mpin;
  String? employName;
  String? employPhone;
  String? aadharCopy;
  String? panCopy;
  String? photo;
  String? email;
  String? joinDate;
  String? description;
  String? roles;
  String? employStatus;
  String? createdDate;

  Payload(
      {this.employId,
        this.employCode,
        this.mpin,
        this.employName,
        this.employPhone,
        this.aadharCopy,
        this.panCopy,
        this.photo,
        this.email,
        this.joinDate,
        this.description,
        this.roles,
        this.employStatus,
        this.createdDate});

  Payload.fromJson(Map<String, dynamic> json) {
    employId = json['employId'];
    employCode = json['employCode'];
    mpin = json['mpin'];
    employName = json['employName'];
    employPhone = json['employPhone'];
    aadharCopy = json['aadharCopy'];
    panCopy = json['panCopy'];
    photo = json['photo'];
    email = json['email'];
    joinDate = json['joinDate'];
    description = json['description'];
    roles = json['roles'];
    employStatus = json['employStatus'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employId'] = this.employId;
    data['employCode'] = this.employCode;
    data['mpin'] = this.mpin;
    data['employName'] = this.employName;
    data['employPhone'] = this.employPhone;
    data['aadharCopy'] = this.aadharCopy;
    data['panCopy'] = this.panCopy;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['joinDate'] = this.joinDate;
    data['description'] = this.description;
    data['roles'] = this.roles;
    data['employStatus'] = this.employStatus;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
