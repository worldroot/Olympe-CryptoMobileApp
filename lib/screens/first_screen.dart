import 'package:flutter/material.dart';
import 'package:olympe/models/FetchCoins/coin_data_model.dart';
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

class _FirstScreenState extends State<FirstScreen> with AutomaticKeepAliveClientMixin<FirstScreen> {

    @override
  bool get wantKeepAlive => true;
  
  final Repository repository = Repository();
  List<CoinDataModel> coinsData = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    repository.getCoins().then((list) {
      setState(() {
        coinsData = list.dataModel;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : CoinListWidget(coins: coinsData);
  }
}
