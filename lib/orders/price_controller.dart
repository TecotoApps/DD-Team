import 'package:dd_shop/orders/piece_model.dart';
import 'package:dd_shop/orders/weight_model.dart';
import 'package:dd_shop/services/api_services.dart';

class PriceController {
  Future<WeightModel> getWeights(shopId) async {
    WeightModel weights = await apiService.getItemPriceByWeight(shopId);
    print('inside controller');
    return weights;
  }


  Future<PieceModel> getItemListPerPiece(shopId) async {
    PieceModel itemsperpeice = await apiService.getItemPriceByPeice(shopId);
    print('inside controller');
    return itemsperpeice;
  }
}

PriceController priceController = PriceController();
