class UsdModel {
  final num price;
  final num volume24h;
  final double percentChange_1h;
  final double percentChange_24h;
  final double percentChange_7d;
  final double percentChange_30d;
  final double percentChange_60d;
  final double percentChange_90d;
  final num marketCap;
  final String lastUpdated;

  UsdModel(
      {required this.price,
      required this.volume24h,
      required this.percentChange_1h,
      required this.percentChange_24h,
      required this.percentChange_7d,
      required this.percentChange_30d,
      required this.percentChange_60d,
      required this.percentChange_90d,
      required this.marketCap,
      required this.lastUpdated});

  factory UsdModel.fromJson(Map<String, dynamic> json) {
    return UsdModel(
      price: json["price"] ?? 0.0,
      volume24h: json["volume_24"] ?? 0.0,
      percentChange_1h: json["percent_change_1h"] ?? 0.0,
      percentChange_24h: json["percent_change_24h"] ?? 0.0,
      percentChange_7d: json["percent_change_7d"] ?? 0.0,
      percentChange_30d: json["percent_change_30d"] ?? 0.0,
      percentChange_60d: json["percent_change_60d"] ?? 0.0,
      percentChange_90d: json["percent_change_90d"] ?? 0.0,
      marketCap: json["market_cap"] ?? 0.0,
      lastUpdated: json["last_updated"],
    );
  }
}
