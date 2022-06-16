import 'dart:math';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:olympe/models/FetchCoins/chart_data_model.dart';
import 'package:olympe/models/FetchCoins/coin_data_model.dart';
import 'package:olympe/statics.dart';
import 'package:olympe/widgets/coin_chart_widget.dart';
import 'package:olympe/widgets/coin_show_chart_widget.dart';
import 'package:olympe/widgets/coin_show_app_bar.dart';

class CoinShowScreen extends StatelessWidget {
  final CoinDataModel coin;
  const CoinShowScreen({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int next(int min, int max) => random.nextInt(max - min);
    var coinIconUrl =
        "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/";
    var coinPrice = coin.quoteModel.usdModel;
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(coinPrice.lastUpdated);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    var data = [
      ChartData(coinPrice.percentChange_90d, 2160),
      ChartData(coinPrice.percentChange_60d, 1440),
      ChartData(coinPrice.percentChange_30d, 720),
      ChartData(coinPrice.percentChange_24h, 24),
      ChartData(coinPrice.percentChange_1h, 1),
    ];

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 0,
        title: const Text(
          "Coin",
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          CoinShowAppBar(coin: coin, coinIconUrl: coinIconUrl),
          CoinChartWidget(coinPrice: coinPrice, data: data, color: Colors.grey),
          Container(
            child: SizedBox(
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 250.0,
                    width: 500.0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Circulating Supply: ",
                              style: TextStyle(
                                  fontFamily: "Oswald",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              coin.circulatingSupply.toString(),
                              style: const TextStyle(
                                  fontFamily: "Oswald",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Max Supply: ",
                              style: TextStyle(
                                  fontFamily: "Oswald",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            Text(
                              coin.maxSupply.toString(),
                              style: const TextStyle(
                                  fontFamily: "Oswald",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Market pairs: ",
                              style: TextStyle(
                                  fontFamily: "Oswald",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            Text(
                              coin.numMarketPairs.toString(),
                              style: const TextStyle(
                                  fontFamily: "Oswald",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Market Cap: ",
                              style: TextStyle(
                                  fontFamily: "Oswald",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            Text(
                              coin.quoteModel.usdModel.marketCap
                                  .toStringAsFixed(2),
                              style: const TextStyle(
                                  fontFamily: "Oswald",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
