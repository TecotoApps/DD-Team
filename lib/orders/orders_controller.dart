import 'package:dd_shop/orders/order_model.dart';
import 'package:dd_shop/services/api_services.dart';



class OrderController {
  Future getShopOrders(shopId) async {
    var orders = await apiService.getShopOrder(shopId);
    return orders;
  }
}

OrderController orderController = OrderController();
