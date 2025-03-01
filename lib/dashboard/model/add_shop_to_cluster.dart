class AddShopToClusterModel {
  int? statusCode;
  String? message;
  Payload? payload;
  String? timeStamp;

  AddShopToClusterModel(
      {this.statusCode, this.message, this.payload, this.timeStamp});

  AddShopToClusterModel.fromJson(Map<String, dynamic> json) {
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
  String? shopId;
  String? shopCode;
  String? phoneNumber;
  String? imageUrl;
  String? userStatus;
  String? shopType;
  String? shopOwnership;
  Null? priceZone;
  String? clusterId;
  String? city;
  String? state;
  Null? franchiseId;
  Null? franchiseAccountNumber;
  Null? franchiseIfscCode;
  Null? franchiseEmail;
  Null? franchiseAadharCopy;
  Null? franchisePanCopy;
  Null? franchiseAgreementCopy;
  Null? landlordName;
  Null? landlordNumber;
  Null? landlordAccountNuber;
  Null? landlordIfsc;
  Null? shopAgreementCopy;
  Null? landlordAadhar;
  Null? landlordPan;
  Null? landlordEmail;
  Null? shopRent;
  Null? shopAdvance;
  Null? shopDescription;
  int? shopAnualIncrement;
  Null? agreementRenevalDate;
  Null? agreementDate;
  String? createdDate;

  Payload(
      {this.shopId,
        this.shopCode,
        this.phoneNumber,
        this.imageUrl,
        this.userStatus,
        this.shopType,
        this.shopOwnership,
        this.priceZone,
        this.clusterId,
        this.city,
        this.state,
        this.franchiseId,
        this.franchiseAccountNumber,
        this.franchiseIfscCode,
        this.franchiseEmail,
        this.franchiseAadharCopy,
        this.franchisePanCopy,
        this.franchiseAgreementCopy,
        this.landlordName,
        this.landlordNumber,
        this.landlordAccountNuber,
        this.landlordIfsc,
        this.shopAgreementCopy,
        this.landlordAadhar,
        this.landlordPan,
        this.landlordEmail,
        this.shopRent,
        this.shopAdvance,
        this.shopDescription,
        this.shopAnualIncrement,
        this.agreementRenevalDate,
        this.agreementDate,
        this.createdDate});

  Payload.fromJson(Map<String, dynamic> json) {
    shopId = json['shopId'];
    shopCode = json['shopCode'];
    phoneNumber = json['phoneNumber'];
    imageUrl = json['imageUrl'];
    userStatus = json['userStatus'];
    shopType = json['shopType'];
    shopOwnership = json['shopOwnership'];
    priceZone = json['priceZone'];
    clusterId = json['clusterId'];
    city = json['city'];
    state = json['state'];
    franchiseId = json['franchiseId'];
    franchiseAccountNumber = json['franchiseAccountNumber'];
    franchiseIfscCode = json['franchiseIfscCode'];
    franchiseEmail = json['franchiseEmail'];
    franchiseAadharCopy = json['franchiseAadharCopy'];
    franchisePanCopy = json['franchisePanCopy'];
    franchiseAgreementCopy = json['franchiseAgreementCopy'];
    landlordName = json['landlordName'];
    landlordNumber = json['landlordNumber'];
    landlordAccountNuber = json['landlordAccountNuber'];
    landlordIfsc = json['landlordIfsc'];
    shopAgreementCopy = json['shopAgreementCopy'];
    landlordAadhar = json['landlordAadhar'];
    landlordPan = json['landlordPan'];
    landlordEmail = json['landlordEmail'];
    shopRent = json['shopRent'];
    shopAdvance = json['shopAdvance'];
    shopDescription = json['shopDescription'];
    shopAnualIncrement = json['shopAnualIncrement'];
    agreementRenevalDate = json['agreementRenevalDate'];
    agreementDate = json['agreementDate'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopId'] = this.shopId;
    data['shopCode'] = this.shopCode;
    data['phoneNumber'] = this.phoneNumber;
    data['imageUrl'] = this.imageUrl;
    data['userStatus'] = this.userStatus;
    data['shopType'] = this.shopType;
    data['shopOwnership'] = this.shopOwnership;
    data['priceZone'] = this.priceZone;
    data['clusterId'] = this.clusterId;
    data['city'] = this.city;
    data['state'] = this.state;
    data['franchiseId'] = this.franchiseId;
    data['franchiseAccountNumber'] = this.franchiseAccountNumber;
    data['franchiseIfscCode'] = this.franchiseIfscCode;
    data['franchiseEmail'] = this.franchiseEmail;
    data['franchiseAadharCopy'] = this.franchiseAadharCopy;
    data['franchisePanCopy'] = this.franchisePanCopy;
    data['franchiseAgreementCopy'] = this.franchiseAgreementCopy;
    data['landlordName'] = this.landlordName;
    data['landlordNumber'] = this.landlordNumber;
    data['landlordAccountNuber'] = this.landlordAccountNuber;
    data['landlordIfsc'] = this.landlordIfsc;
    data['shopAgreementCopy'] = this.shopAgreementCopy;
    data['landlordAadhar'] = this.landlordAadhar;
    data['landlordPan'] = this.landlordPan;
    data['landlordEmail'] = this.landlordEmail;
    data['shopRent'] = this.shopRent;
    data['shopAdvance'] = this.shopAdvance;
    data['shopDescription'] = this.shopDescription;
    data['shopAnualIncrement'] = this.shopAnualIncrement;
    data['agreementRenevalDate'] = this.agreementRenevalDate;
    data['agreementDate'] = this.agreementDate;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
