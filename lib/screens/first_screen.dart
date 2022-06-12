import 'package:flutter/material.dart';
import 'package:olympe/models/FetchCoins/exposed_coins_data_model.dart';
import 'package:olympe/repository/repository.dart';
import 'package:olympe/widgets/coin_list_widget.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>{


  final Repository repository =  Repository();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExposedCoinsDataModel>(
      future: repository.getCoins(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var coinsData = snapshot.data!.dataModel;
            return CoinListWidget(coins: coinsData);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
