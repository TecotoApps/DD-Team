class ShopModel {
  late int statusCode;
  late String message;
  late String error;
  late PayLoad payload;
  late bool isPayload;

  ShopModel(
      this.statusCode, this.message, this.error, this.payload, this.isPayload);

  ShopModel.fromJSON(dynamic parsedJson) {
    this.statusCode = parsedJson['statusCode'];
    this.message = parsedJson['message'];
    if (parsedJson['payload'] != null) {
      isPayload = true;
      this.payload = PayLoad.fromJSON(parsedJson['payload']);
    } else
      isPayload = false;

    error = "";
  }
  ShopModel.withError(String errorValue) : error = errorValue;
  @override
  String toString() {
    return '{ ${this.message}, ${this.message} }';
  }
}

class PayLoad {
  late int shopId;
  late String shopName;
  late String phoneNumber;
  late String email;
  late String deviceId;
  late String address;
  late String city;
  late String state;
  late String landmark;
  late String pinCode;
  late double latitude;
  late double longitude;
  late String accountNumber;
  late String ifscCode;
  late String upiId;
  late String shopStatus;
  late String imageUrl;
  late String createdDate;

  PayLoad(
    this.shopId,
    this.shopName,
    this.phoneNumber,
    this.email,
    this.deviceId,
    this.address,
    this.city,
    this.state,
    this.landmark,
    this.pinCode,
    this.latitude,
    this.longitude,
    this.accountNumber,
    this.ifscCode,
    this.upiId,
    this.shopStatus,
    this.imageUrl,
    this.createdDate,
  );

  PayLoad.fromJSON(parsedJson) {
    this.shopId = parsedJson['shopId'];
    this.shopName = parsedJson['shopName'];
    this.phoneNumber = parsedJson['phoneNumber'];

    if(parsedJson['email'] != null)
    this.email = parsedJson['email'];
    else
      this.email = '';

    if(parsedJson['deviceId'] != null)
      this.deviceId = parsedJson['deviceId'];
    else
      this.deviceId = ' ';

    this.address = parsedJson['address'];
    this.city = parsedJson['city'];
    this.state = parsedJson['state'];
    this.landmark = parsedJson['landmark'];
    this.pinCode = parsedJson['pinCode'];

    if (parsedJson['latitude'] != null)
      this.latitude = parsedJson['latitude'];
    else
      this.latitude = 0.0;

    if (parsedJson['longitude'] != null)
      this.longitude = parsedJson['longitude'];
    else
      this.longitude = 0.0;

    if (parsedJson['accountNumber'] != null)
    this.accountNumber = parsedJson['accountNumber'];
    else
      this.accountNumber = '';

    if (parsedJson['ifscCode'] != null)
    this.ifscCode = parsedJson['ifscCode'];
    else
      this.ifscCode = '';

    if(parsedJson['imageUrl'] != null)
    this.imageUrl = parsedJson['imageUrl'];
    else
      this.imageUrl = '';

    if(parsedJson['upiId'] != null)
      this.upiId = parsedJson['upiId'];
    else
      this.upiId = '';

    if(parsedJson['shopStatus'] != null)
      this.shopStatus = parsedJson['shopStatus'];
    else
      this.shopStatus = '';

    this.createdDate = parsedJson['createdDate'];

  }
  Map toJson() => {
        "shopId": shopId,
        "shopName": shopName,
        "phoneNumber": phoneNumber,
        "email": email,
        "deviceId": deviceId,
        "address": address,
        "upiId":upiId,
        "shopStatus":shopStatus,
        "city": city,
        "state": state,
        "landmark": landmark,
        "pinCode": pinCode,
        "latitude": latitude,
        "longitude": longitude,
        "accountNumber": accountNumber,
        "ifscCode": ifscCode,
        "imageUrl": imageUrl,
       "createdDate": createdDate,
      };
}
