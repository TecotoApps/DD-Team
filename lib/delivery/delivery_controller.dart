

import 'package:dd_shop/dashboard/model/order_list_model.dart';
import 'package:dd_shop/delivery/order_pickup.dart';
import 'package:dd_shop/orders/pickup_model.dart';
import 'package:dd_shop/services/api_services.dart';
import 'package:flutter/material.dart';

class DeliveryController{

  goToOrderPickUP(orderpayload,context){
    OrderPayload order = OrderPayload.fromJson(orderpayload);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddOrderPickupDetails(orderPayload: order,)));
  }

  changeOrderStatus(OrderPayload order,status,context) async{
      bool employeeListModel = await apiService.updateOrderStatus(order.orderId,status);
      return employeeListModel;

  }

  confirmPickup(orderId,bagNo,totalItems,totalWeight,comments,pricingType) async{
    PickupModel pickupModel = await apiService.confirmPickup(orderId,bagNo,totalItems,totalWeight,comments,pricingType);
    return pickupModel;

  }

}

DeliveryController deliveryController = DeliveryController();