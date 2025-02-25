import 'package:dd_shop/services/api_services.dart';
import 'package:dd_shop/shop_prices/piece_model.dart';
import 'package:dd_shop/shop_prices/weight_model.dart';


class PriceController {
  Future<ItemPerWeightListModel> getWeights(shopId) async {
    ItemPerWeightListModel weights = await apiService.getWeight(shopId);
    print('inside controller');
    return weights;
  }


  Future<ItemPerPeiceListModel> getPieces(shopId) async {
    ItemPerPeiceListModel itemsperpeice = await apiService.getPiece(shopId);
    print('inside controller');
    return itemsperpeice;
  }
}

PriceController priceController = PriceController();
