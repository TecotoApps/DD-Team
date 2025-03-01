class AddClusterModel {
  int? statusCode;
  String? message;
  Payload? payload;
  String? timeStamp;

  AddClusterModel(
      {this.statusCode, this.message, this.payload, this.timeStamp});

  AddClusterModel.fromJson(Map<String, dynamic> json) {
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
  String? clusterId;
  Null? cmId;
  Null? zmId;
  String? clusterName;
  String? description;
  String? createdDate;

  Payload(
      {this.clusterId,
        this.cmId,
        this.zmId,
        this.clusterName,
        this.description,
        this.createdDate});

  Payload.fromJson(Map<String, dynamic> json) {
    clusterId = json['clusterId'];
    cmId = json['cmId'];
    zmId = json['zmId'];
    clusterName = json['clusterName'];
    description = json['description'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clusterId'] = this.clusterId;
    data['cmId'] = this.cmId;
    data['zmId'] = this.zmId;
    data['clusterName'] = this.clusterName;
    data['description'] = this.description;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
