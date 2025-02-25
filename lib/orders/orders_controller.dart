import 'package:dd_shop/orders/order_model.dart';
import 'package:dd_shop/services/api_services.dart';


class OrderController {
  Future<OrderModel> getShopOrders(shopId) async {
    OrderModel orders = await apiService.getShopOrder(shopId);
    return orders;
  }

  Future<OrderModel> updateOrder(orderId, cancelReason) async {
    OrderModel updatedOrder =
        await apiService.updateOrder(orderId, cancelReason);
    return updatedOrder;
  }
}

OrderController orderController = OrderController();
