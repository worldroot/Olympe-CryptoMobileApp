import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:olympe/Controllers/request_controller.dart';
import 'package:olympe/models/backend_response.dart';
import 'package:olympe/models/transaction_model.dart';

class TransactionController {
  final RequestController _requestController = RequestController();

  Future<List<Transaction>?> getTransactions() async {
    String token = Hive.box('user_data').get('token');

    final response = await _requestController.get(
        apiRoute: "api/transactions/",
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      List<Transaction> transactions = [];

      for (var item in body) {
        Transaction transaction = Transaction.fromJson(item);
        transactions.add(transaction);
      }
      return transactions;
    } else {
      print("something went wrong");
      return null;
    }
  }

  Future<BackendResponse> addTransaction(Transaction transaction) async {
    String token = Hive.box('user_data').get('token');
    // Map<String, dynamic> body = <String, dynamic>{
    //   'description': transaction.description,
    //   'coinAmount': transaction.coinAmount,
    //   'usdAmount': transaction.usdAmount,
    //   'type': transaction.type,
    //   'coin': transaction.coin,
    //   'coinPrice': transaction.coinPrice,
    //   'acountBalanceUSD': transaction.acountBalanceUSD,
    //   'acountBalanceCOIN': transaction.acountBalanceCOIN,
    // };

    final response = await _requestController.post(
        apiRoute: "api/transactions/add",
        body: transaction.toJson(),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      BackendResponse backendResponse = BackendResponse.fromJson(body);
      return backendResponse;
    } else {
      return BackendResponse.withError();
    }
  }

  Future<BackendResponse> updateTransaction(Transaction transaction) async {
    String token = Hive.box('user_data').get('token');

    final response = await _requestController
        .put(apiRoute: "api/transactions/update", body: <String, dynamic>{
      'transactionId': transaction.id,
      'description': transaction.description,
      'coinAmount': transaction.coinAmount,
      'usdAmount': transaction.usdAmount,
      'type': transaction.type,
      'coin': transaction.coin,
      'coinPrice': transaction.coinPrice,
      'acountBalanceUSD': transaction.acountBalanceUSD,
      'acountBalanceCOIN': transaction.acountBalanceCOIN,
    }, headers: {
      'Authorization': 'Bearer $token',
      'content-type': 'application/json'
    });

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      BackendResponse backendResponse = BackendResponse.fromJson(body);
      return backendResponse;
    } else {
      return BackendResponse.withError();
    }
  }

  Future<BackendResponse> deleteTransaction(Transaction transaction) async {
    String token = Hive.box('user_data').get('token');

    final response = await _requestController.delete(
        apiRoute: "api/transactions/delete/${transaction.id}",
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      BackendResponse backendResponse = BackendResponse.fromJson(body);
      return backendResponse;
    } else {
      return BackendResponse.withError();
    }
  }
}
