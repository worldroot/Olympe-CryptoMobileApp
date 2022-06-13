class ExposedGlobalMetrics {
  Status? status;
  Data? data;

  ExposedGlobalMetrics({this.status, this.data});

  ExposedGlobalMetrics.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  ExposedGlobalMetrics.withError() {
    status = Status.withError();
    data = null;
  }
}

class Status {
  String? timestamp;
  int? errorCode;
  Null? errorMessage;
  int? elapsed;
  int? creditCount;
  Null? notice;

  Status(
      {this.timestamp,
      this.errorCode,
      this.errorMessage,
      this.elapsed,
      this.creditCount,
      this.notice});

  Status.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    errorCode = json['error_code'];
    errorMessage = json['error_message'];
    elapsed = json['elapsed'];
    creditCount = json['credit_count'];
    notice = json['notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = timestamp;
    data['error_code'] = errorCode;
    data['error_message'] = errorMessage;
    data['elapsed'] = elapsed;
    data['credit_count'] = creditCount;
    data['notice'] = notice;
    return data;
  }

  static Status? withError() {
    return null;
  }
}

class Data {
  int? activeCryptocurrencies;
  int? totalCryptocurrencies;
  int? activeMarketPairs;
  int? activeExchanges;
  int? totalExchanges;
  double? ethDominance;
  double? btcDominance;
  double? ethDominanceYesterday;
  double? btcDominanceYesterday;
  double? ethDominance24hPercentageChange;
  double? btcDominance24hPercentageChange;
  double? defiVolume24h;
  double? defiVolume24hReported;
  double? defiMarketCap;
  double? defi24hPercentageChange;
  double? stablecoinVolume24h;
  double? stablecoinVolume24hReported;
  double? stablecoinMarketCap;
  double? stablecoin24hPercentageChange;
  double? derivativesVolume24h;
  double? derivativesVolume24hReported;
  double? derivatives24hPercentageChange;
  Quote? quote;
  String? lastUpdated;

  Data(
      {this.activeCryptocurrencies,
      this.totalCryptocurrencies,
      this.activeMarketPairs,
      this.activeExchanges,
      this.totalExchanges,
      this.ethDominance,
      this.btcDominance,
      this.ethDominanceYesterday,
      this.btcDominanceYesterday,
      this.ethDominance24hPercentageChange,
      this.btcDominance24hPercentageChange,
      this.defiVolume24h,
      this.defiVolume24hReported,
      this.defiMarketCap,
      this.defi24hPercentageChange,
      this.stablecoinVolume24h,
      this.stablecoinVolume24hReported,
      this.stablecoinMarketCap,
      this.stablecoin24hPercentageChange,
      this.derivativesVolume24h,
      this.derivativesVolume24hReported,
      this.derivatives24hPercentageChange,
      this.quote,
      this.lastUpdated});

  Data.fromJson(Map<String, dynamic> json) {
    activeCryptocurrencies = json['active_cryptocurrencies'];
    totalCryptocurrencies = json['total_cryptocurrencies'];
    activeMarketPairs = json['active_market_pairs'];
    activeExchanges = json['active_exchanges'];
    totalExchanges = json['total_exchanges'];
    ethDominance = json['eth_dominance'];
    btcDominance = json['btc_dominance'];
    ethDominanceYesterday = json['eth_dominance_yesterday'];
    btcDominanceYesterday = json['btc_dominance_yesterday'];
    ethDominance24hPercentageChange =
        json['eth_dominance_24h_percentage_change'];
    btcDominance24hPercentageChange =
        json['btc_dominance_24h_percentage_change'];
    defiVolume24h = json['defi_volume_24h'];
    defiVolume24hReported = json['defi_volume_24h_reported'];
    defiMarketCap = json['defi_market_cap'];
    defi24hPercentageChange = json['defi_24h_percentage_change'];
    stablecoinVolume24h = json['stablecoin_volume_24h'];
    stablecoinVolume24hReported = json['stablecoin_volume_24h_reported'];
    stablecoinMarketCap = json['stablecoin_market_cap'];
    stablecoin24hPercentageChange = json['stablecoin_24h_percentage_change'];
    derivativesVolume24h = json['derivatives_volume_24h'];
    derivativesVolume24hReported = json['derivatives_volume_24h_reported'];
    derivatives24hPercentageChange = json['derivatives_24h_percentage_change'];
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_cryptocurrencies'] = activeCryptocurrencies;
    data['total_cryptocurrencies'] = totalCryptocurrencies;
    data['active_market_pairs'] = activeMarketPairs;
    data['active_exchanges'] = activeExchanges;
    data['total_exchanges'] = totalExchanges;
    data['eth_dominance'] = ethDominance;
    data['btc_dominance'] = btcDominance;
    data['eth_dominance_yesterday'] = ethDominanceYesterday;
    data['btc_dominance_yesterday'] = btcDominanceYesterday;
    data['eth_dominance_24h_percentage_change'] =
        ethDominance24hPercentageChange;
    data['btc_dominance_24h_percentage_change'] =
        btcDominance24hPercentageChange;
    data['defi_volume_24h'] = defiVolume24h;
    data['defi_volume_24h_reported'] = defiVolume24hReported;
    data['defi_market_cap'] = defiMarketCap;
    data['defi_24h_percentage_change'] = defi24hPercentageChange;
    data['stablecoin_volume_24h'] = stablecoinVolume24h;
    data['stablecoin_volume_24h_reported'] = stablecoinVolume24hReported;
    data['stablecoin_market_cap'] = stablecoinMarketCap;
    data['stablecoin_24h_percentage_change'] = stablecoin24hPercentageChange;
    data['derivatives_volume_24h'] = derivativesVolume24h;
    data['derivatives_volume_24h_reported'] = derivativesVolume24hReported;
    data['derivatives_24h_percentage_change'] = derivatives24hPercentageChange;
    if (quote != null) {
      data['quote'] = quote!.toJson();
    }
    data['last_updated'] = lastUpdated;
    return data;
  }
}

class Quote {
  USD? uSD;

  Quote({this.uSD});

  Quote.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? new USD.fromJson(json['USD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (uSD != null) {
      data['USD'] = uSD!.toJson();
    }
    return data;
  }
}

class USD {
  double? totalMarketCap;
  double? totalVolume24h;
  double? totalVolume24hReported;
  double? altcoinVolume24h;
  double? altcoinVolume24hReported;
  double? altcoinMarketCap;
  double? defiVolume24h;
  double? defiVolume24hReported;
  double? defi24hPercentageChange;
  double? defiMarketCap;
  double? stablecoinVolume24h;
  double? stablecoinVolume24hReported;
  double? stablecoin24hPercentageChange;
  double? stablecoinMarketCap;
  double? derivativesVolume24h;
  double? derivativesVolume24hReported;
  double? derivatives24hPercentageChange;
  String? lastUpdated;
  double? totalMarketCapYesterday;
  double? totalVolume24hYesterday;
  double? totalMarketCapYesterdayPercentageChange;
  double? totalVolume24hYesterdayPercentageChange;

  USD(
      {this.totalMarketCap,
      this.totalVolume24h,
      this.totalVolume24hReported,
      this.altcoinVolume24h,
      this.altcoinVolume24hReported,
      this.altcoinMarketCap,
      this.defiVolume24h,
      this.defiVolume24hReported,
      this.defi24hPercentageChange,
      this.defiMarketCap,
      this.stablecoinVolume24h,
      this.stablecoinVolume24hReported,
      this.stablecoin24hPercentageChange,
      this.stablecoinMarketCap,
      this.derivativesVolume24h,
      this.derivativesVolume24hReported,
      this.derivatives24hPercentageChange,
      this.lastUpdated,
      this.totalMarketCapYesterday,
      this.totalVolume24hYesterday,
      this.totalMarketCapYesterdayPercentageChange,
      this.totalVolume24hYesterdayPercentageChange});

  USD.fromJson(Map<String, dynamic> json) {
    totalMarketCap = json['total_market_cap'];
    totalVolume24h = json['total_volume_24h'];
    totalVolume24hReported = json['total_volume_24h_reported'];
    altcoinVolume24h = json['altcoin_volume_24h'];
    altcoinVolume24hReported = json['altcoin_volume_24h_reported'];
    altcoinMarketCap = json['altcoin_market_cap'];
    defiVolume24h = json['defi_volume_24h'];
    defiVolume24hReported = json['defi_volume_24h_reported'];
    defi24hPercentageChange = json['defi_24h_percentage_change'];
    defiMarketCap = json['defi_market_cap'];
    stablecoinVolume24h = json['stablecoin_volume_24h'];
    stablecoinVolume24hReported = json['stablecoin_volume_24h_reported'];
    stablecoin24hPercentageChange = json['stablecoin_24h_percentage_change'];
    stablecoinMarketCap = json['stablecoin_market_cap'];
    derivativesVolume24h = json['derivatives_volume_24h'];
    derivativesVolume24hReported = json['derivatives_volume_24h_reported'];
    derivatives24hPercentageChange = json['derivatives_24h_percentage_change'];
    lastUpdated = json['last_updated'];
    totalMarketCapYesterday = json['total_market_cap_yesterday'];
    totalVolume24hYesterday = json['total_volume_24h_yesterday'];
    totalMarketCapYesterdayPercentageChange =
        json['total_market_cap_yesterday_percentage_change'];
    totalVolume24hYesterdayPercentageChange =
        json['total_volume_24h_yesterday_percentage_change'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_market_cap'] = totalMarketCap;
    data['total_volume_24h'] = totalVolume24h;
    data['total_volume_24h_reported'] = totalVolume24hReported;
    data['altcoin_volume_24h'] = altcoinVolume24h;
    data['altcoin_volume_24h_reported'] = altcoinVolume24hReported;
    data['altcoin_market_cap'] = altcoinMarketCap;
    data['defi_volume_24h'] = defiVolume24h;
    data['defi_volume_24h_reported'] = defiVolume24hReported;
    data['defi_24h_percentage_change'] = defi24hPercentageChange;
    data['defi_market_cap'] = defiMarketCap;
    data['stablecoin_volume_24h'] = stablecoinVolume24h;
    data['stablecoin_volume_24h_reported'] = stablecoinVolume24hReported;
    data['stablecoin_24h_percentage_change'] = stablecoin24hPercentageChange;
    data['stablecoin_market_cap'] = stablecoinMarketCap;
    data['derivatives_volume_24h'] = derivativesVolume24h;
    data['derivatives_volume_24h_reported'] = derivativesVolume24hReported;
    data['derivatives_24h_percentage_change'] = derivatives24hPercentageChange;
    data['last_updated'] = lastUpdated;
    data['total_market_cap_yesterday'] = totalMarketCapYesterday;
    data['total_volume_24h_yesterday'] = totalVolume24hYesterday;
    data['total_market_cap_yesterday_percentage_change'] =
        totalMarketCapYesterdayPercentageChange;
    data['total_volume_24h_yesterday_percentage_change'] =
        totalVolume24hYesterdayPercentageChange;
    return data;
  }
}
