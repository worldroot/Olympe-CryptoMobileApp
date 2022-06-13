import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olympe/models/FetchCoins/coin_data_model.dart';
import 'package:olympe/models/FetchCoins/usd_model.dart';
import 'package:olympe/statics.dart';

class CoinLogoWidget extends StatelessWidget {
  final CoinDataModel coin;

  const CoinLogoWidget({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coinIconUrl =
        "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/icon/";
    TextTheme textStyle = Theme.of(context).textTheme;
    UsdModel coinPrice = coin.quoteModel.usdModel;

    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      height: 150.0,
      width: 120.0,
      //78 Remaining
      child: Column(
        children: [
          SizedBox(
              height: 50.0,
              width: 50.0,
              child: CachedNetworkImage(
                imageUrl: ((coinIconUrl + coin.symbol + ".png").toLowerCase()),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    SvgPicture.asset('assets/icons/dollar.svg'),
              )),
          const SizedBox(height: 4.0),
          Text(
            coin.symbol,
            style: const TextStyle(color: Palette.textColor),
          ),
          const SizedBox(height: 2.0),
          Text(
            "\$" + coin.quoteModel.usdModel.price.toStringAsFixed(2),
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Palette.textColor),
          ),
          const SizedBox(height: 2.0),
          Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            width: 72,
            height: 36,
            decoration: BoxDecoration(
                color:
                    coinPrice.percentChange_7d >= 0 ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(16.0)),
            child: Text(
              coinPrice.percentChange_7d.toStringAsFixed(2) + "%",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
