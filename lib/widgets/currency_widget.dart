import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olympe/models/FetchCoins/coin_data_model.dart';
import 'package:olympe/statics.dart';

class CurrencyWidget extends StatelessWidget {
  final CoinDataModel coin;
  final bool isSelected;
  const CurrencyWidget({Key? key, required this.coin, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xff222632).withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Palette.buttonColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CachedNetworkImage(
                  imageUrl:
                      ((coinIconUrl + coin.symbol + ".png").toLowerCase()),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      SvgPicture.asset('assets/icons/dollar.svg'),
                )),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(coin.name,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Text(coin.symbol,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6), fontSize: 13))
            ],
          ),
          isSelected
              ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xff5fae58).withOpacity(0.05),
                            borderRadius: BorderRadius.circular(25)),
                        child: Icon(
                          Icons.check,
                          color: const Color(0xff5fae58).withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                )
              : const Text("")
        ],
      ),
    );
  }
}
