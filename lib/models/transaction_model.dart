class Transaction {
  String? id;
  String? user;
  String? description;
  double? coinAmount;
  int? usdAmount;
  String? type;
  String? coin;
  int? coinPrice;
  int? acountBalanceUSD;
  int? acountBalanceCOIN;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? error;
  
  Transaction(
      {id,
      user,
      description,
      coinAmount,
      usdAmount,
      type,
      coin,
      coinPrice,
      acountBalanceUSD,
      acountBalanceCOIN,
      createdAt,
      updatedAt,
      iV});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user = json['user'];
    description = json['description'];
    coinAmount = json['coinAmount'];
    usdAmount = json['usdAmount'];
    type = json['type'];
    coin = json['coin'];
    coinPrice = json['coinPrice'];
    acountBalanceUSD = json['acountBalanceUSD'];
    acountBalanceCOIN = json['acountBalanceCOIN'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    error = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['user'] = user;
    data['description'] = description;
    data['coinAmount'] = coinAmount;
    data['usdAmount'] = usdAmount;
    data['type'] = type;
    data['coin'] = coin;
    data['coinPrice'] = coinPrice;
    data['acountBalanceUSD'] = acountBalanceUSD;
    data['acountBalanceCOIN'] = acountBalanceCOIN;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }

    Transaction.withError() {
    id = "";
    id = "";
    user = "";
    description = "";
    coinAmount = 0;
    usdAmount = 0;
    type = "";
    coin = "";
    coinPrice = 0;
    acountBalanceUSD = 0;
    acountBalanceCOIN = 0;
    createdAt = "";
    updatedAt = "";
    iV = 0;
    error = true;
  }
}
