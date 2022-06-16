import 'package:flutter/material.dart';
import 'package:olympe/models/FetchCoins/chart_data_model.dart';
import 'package:olympe/models/FetchCoins/usd_model.dart';
import 'package:olympe/widgets/coin_chart_price_widget.dart';
import 'package:olympe/widgets/coin_chart_widget.dart';
import 'package:olympe/widgets/sliver_app_bar_delegate.dart';
import 'package:olympe/widgets/toggle_button_widget.dart';

class CoinRandomedChartWidget extends StatefulWidget {
  const CoinRandomedChartWidget({
    Key? key,
    required this.coinPrice,
    required this.outputDate,
    required this.data,
  }) : super(key: key);

  final UsdModel coinPrice;
  final String outputDate;
  final List<ChartData> data;

  @override
  _CoinRandomedChartWidgetState createState() =>
      _CoinRandomedChartWidgetState();
}

class _CoinRandomedChartWidgetState extends State<CoinRandomedChartWidget> {
  final List<bool> _isSelected = [true, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(
            children: [
              Text(
                '\$' + widget.coinPrice.price.toStringAsFixed(2),
                style: const TextStyle(
                    fontFamily: "Oswald", color: Colors.white, fontSize: 20),
              ),
              Text(
                widget.outputDate,
                style: const TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              CoinChartWidget(
                  coinPrice: widget.coinPrice,
                  color: Colors.green,
                  data: widget.data),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
