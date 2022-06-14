class Transaction {
  String? id;
  String? user;
  String? description;
  double? coinAmount;
  double? usdAmount;
  String? type;
  String? coin;
  double? coinPrice;
  double? acountBalanceUSD;
  double? acountBalanceCOIN;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? error;

  Transaction(
      {this.id,
      this.user,
      this.description,
      this.coinAmount,
      this.usdAmount,
      this.type,
      this.coin,
      this.coinPrice,
      this.acountBalanceUSD,
      this.acountBalanceCOIN,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user = json['user'];
    description = json['description'];
    coinAmount = double.parse(json['coinAmount'].toString());
    usdAmount = double.parse(json['usdAmount'].toString());
    type = json['type'];
    coin = json['coin'];
    coinPrice = double.parse(json['coinPrice'].toString());
    acountBalanceUSD = double.parse(json['acountBalanceUSD'].toString());
    acountBalanceCOIN = double.parse(json['acountBalanceCOIN'].toString());
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    error = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id ?? "";
    data['user'] = user ?? "";
    data['description'] = description ?? "";
    data['coinAmount'] = coinAmount ?? 0;
    data['usdAmount'] = usdAmount ?? 0;
    data['type'] = type ?? "";
    data['coin'] = coin ?? "";
    data['coinPrice'] = coinPrice ?? 0;
    data['acountBalanceUSD'] = acountBalanceUSD ?? 0;
    data['acountBalanceCOIN'] = acountBalanceCOIN ?? 0;
    data['createdAt'] = createdAt ?? "";
    data['updatedAt'] = updatedAt ?? "";
    data['__v'] = iV ?? 0;
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

  @override
  String toString() {
    return 'Transaction{id: $id, user: $user, description: $description, coinAmount: $coinAmount, usdAmount: $usdAmount, type: $type, coin: $coin, coinPrice: $coinPrice, acountBalanceUSD: $acountBalanceUSD, acountBalanceCOIN: $acountBalanceCOIN, createdAt: $createdAt, updatedAt: $updatedAt, iV: $iV, error: $error}';
  }
}
