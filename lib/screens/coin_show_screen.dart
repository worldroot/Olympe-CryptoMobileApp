import 'dart:math';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:olympe/models/FetchCoins/chart_data_model.dart';
import 'package:olympe/models/FetchCoins/coin_data_model.dart';
import 'package:olympe/widgets/coin_randomed_chart_widget.dart';
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
      backgroundColor: const Color.fromRGBO(11, 12, 54, 1),
      body: CustomScrollView(
        slivers: [
          CoinShowAppBar(coin: coin, coinIconUrl: coinIconUrl),
          CoinRandomedChartWidget(
              coinPrice: coinPrice, outputDate: outputDate, data: data),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    height: 420.0,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Circulating Supply: ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              coin.circulatingSupply.toString(),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Max Supply: ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              coin.maxSupply.toString(),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Market pairs: ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              coin.numMarketPairs.toString(),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Market Cap: ",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              coin.quoteModel.usdModel.marketCap
                                  .toStringAsFixed(2),
                              style: Theme.of(context).textTheme.headline6,
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
        ],
      ),
    );
  }
}
