import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/services/sharedPress.dart';
import 'package:dd_shop/shop_signup/shop_model.dart';
import 'package:dd_shop/utils/constants/strings.dart';

class OTP_Verify_Controller {
  Future<ShopModel> validateOTP(mobile, otp) async {
    var shop = await apiService.verifyOTP(mobile, otp);
    if (shop.isPayload == true) {
      print(" inside verify controller");
      sharedPress.saveData(Dd_Strings.SHOPNAME, shop.payload.shopName);
      sharedPress.saveData(Dd_Strings.PHONENUMBER, shop.payload.phoneNumber);
      sharedPress.saveId(Dd_Strings.SHOPID, shop.payload.shopId);
      return shop;
    }
      return shop;
  }
}

OTP_Verify_Controller otp_verify_controller = OTP_Verify_Controller();
