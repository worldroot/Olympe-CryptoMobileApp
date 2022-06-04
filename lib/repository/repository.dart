import 'package:dio/dio.dart';
import 'package:olympe/models/FetchCoins/exposed_coins_data_model.dart';

class Repository {
  static String mainUrl = "https://pro-api.coinmarketcap.com/v1/";
  final String apiKey = 'ad0c2520-b153-43f2-aab9-bdf7d0d55ca8';
  var currencyListingAPI = '${mainUrl}cryptocurrency/listings/latest';

//A powerful Http client for Dart, which supports Interceptors, Global configuration, FormData, Request Cancellation, File downloading, Timeout etc.
  final Dio _dio = Dio();

  Future<ExposedCoinsDataModel> getCoins() async {
    try {
      _dio.options.headers["X-CMC_PRO_API_KEY"] = apiKey;
      Response response = await _dio.get(currencyListingAPI);
      return ExposedCoinsDataModel.fromJson((response.data));
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print("Exception occured: $error stackTrace: $stacktrace");
      return ExposedCoinsDataModel.withError("error");
    }
  }
}
