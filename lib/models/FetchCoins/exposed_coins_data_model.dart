import 'package:olympe/models/FetchCoins/coin_data_model.dart';
import 'package:olympe/models/FetchCoins/exposed_status_model.dart';

class ExposedCoinsDataModel {
  final ExposedStatusModel statusModel;
  final List<CoinDataModel> dataModel;

  ExposedCoinsDataModel({
    required this.statusModel,
    required this.dataModel,
  });

  factory ExposedCoinsDataModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<CoinDataModel> dataModelList =
        dataList.map((e) => CoinDataModel.fromJson(e)).toList();
    return ExposedCoinsDataModel(
      statusModel: ExposedStatusModel.fromJson(json["status"]),
      dataModel: dataModelList,
    );
  }
  ExposedCoinsDataModel.withError(String error)
      : statusModel = ExposedStatusModel(error, 0, error, 0, 0, error, 0),
        dataModel = [];
}
