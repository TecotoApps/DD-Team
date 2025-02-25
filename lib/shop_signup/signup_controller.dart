import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/services/sharedPress.dart';
import 'package:dd_shop/shop_signup/shop_model.dart';
import 'package:dd_shop/utils/constants/strings.dart';

class SignUp_Contoller {
  Future<ShopModel> signUp(
    shopName,
    phoneNumber,
    email,
    address, deviceId,
    city,
    state,
    landmark,
    pinCode,
    accountNumber,
    ifscCode, latitude, longitude
  ) async {
    print(shopName);
    print(city);
    var shop = await apiService.signUp(
      shopName,
      phoneNumber,
      email,
      deviceId,
      address,
      city,
      state,
      landmark,
      pinCode,
      accountNumber,
      ifscCode, latitude, longitude
    );
    print('received response');
    if (shop.statusCode == 200) {
      sharedPress.saveData(Dd_Strings.SHOPNAME, shop.payload.shopName);
      sharedPress.saveData(Dd_Strings.SHOPADDRESS, shop.payload.address);
      sharedPress.saveData(Dd_Strings.PHONENUMBER, shop.payload.phoneNumber);
      sharedPress.saveId(Dd_Strings.SHOPID, shop.payload.shopId);
      sharedPress.saveLatLag(Dd_Strings.SHOPLAT, shop.payload.latitude);
      sharedPress.saveLatLag(Dd_Strings.SHOPLAG, shop.payload.longitude);
    }
    return shop;
  }
}

SignUp_Contoller signUp_Contoller = SignUp_Contoller();
