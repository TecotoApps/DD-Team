
import 'package:dd_shop/services/api_services.dart';

class OTP_Controller {
  generateOTP(mobile) async {
    var result = await apiService.sendOTP(mobile);
    print(result);
    return result;
  }
}

OTP_Controller otp_controller = OTP_Controller();
