import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:olympe/models/FetchCoins/coin_data_model.dart';

class CoinShowAppBar extends StatelessWidget {
  final CoinDataModel coin;
  final String coinIconUrl;
  const CoinShowAppBar({
    Key? key,
    required this.coin,
    required this.coinIconUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 4.4, 0.0),
        width: double.infinity,
        height: 56.0,
        child: ListTile(
          leading: SizedBox(
            height: 40.0,
            width: 40.0,
            child: CachedNetworkImage(
              imageUrl: ((coinIconUrl + coin.symbol + ".png").toLowerCase()),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  SvgPicture.asset('assets/icons/dollar.svg'),
            ),
          ),
          title: Text(
            coin.name + " " + coin.symbol + " #" + coin.cmcRank.toString(),
            style: const TextStyle(
                fontFamily: "Oswald", color: Colors.white, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          // subtitle: Text(coin.slug),
        ),
      ),
    );
  }
}
