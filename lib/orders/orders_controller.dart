import 'package:dd_shop/orders/order_model.dart';
import 'package:dd_shop/services/api_services.dart';



class OrderController {
  Future getShopOrders(shopId) async {
    var orders = await apiService.getShopOrder(shopId);
    return orders;
  }

  double addAmount(List<Map<String, dynamic>> orderItems) {
    double total = 0.0;
    for (var item in orderItems) {
      final price = item['price'];
      final quantity = item['nos'];
      if (price != null && price is double && quantity != null && quantity is num) {
        total += price * quantity;
      }
    }
    return total;
  }

  double getGSTAmount(List<Map<String, dynamic>> orderItems) {
    double total = addAmount(orderItems);
    double gst = total * 0.18;
    return gst;
  }

  double getTotalPayableAmount(List<Map<String, dynamic>> orderItems) {
    double amount = addAmount(orderItems);
    double gst = getGSTAmount(orderItems);
    return amount + gst;
  }

}

OrderController orderController = OrderController();
