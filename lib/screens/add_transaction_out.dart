import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:olympe/Controllers/transaction_controller.dart';
import 'package:olympe/components/snackbar.dart';
import 'package:olympe/models/FetchCoins/coin_data_model.dart';
import 'package:olympe/models/transaction_model.dart';
import 'package:olympe/repository/repository.dart';
import 'package:olympe/statics.dart';
import 'package:olympe/widgets/currency_widget.dart';

class AddTransactionOUT extends StatefulWidget {
  const AddTransactionOUT({Key? key}) : super(key: key);

  @override
  State<AddTransactionOUT> createState() => _AddTransactionOUTState();
}

class _AddTransactionOUTState extends State<AddTransactionOUT> {
  String selectedCoin = "BTC";
  String selectedUSD = "USDT";
  num selectedPrice = 0;
  final Repository _repository = Repository();
  final TransactionController transactionController = TransactionController();
  List<CoinDataModel> coins = [];

  double usdAmountvalue = 0;

  TextEditingController coinAmountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCoins();
  }

  void fetchCoins() {
    _repository.getCoins().then((result) {
      print(result);
      setState(() {
        coins = result.dataModel;
        selectedCoin = result.dataModel.first.symbol;
        selectedPrice = result.dataModel.first.quoteModel.usdModel.price;
      });
    }).catchError((error) {
      print(error);
    });
  }

  void handleOnChanged(String value) {
    if (value.isNotEmpty) {
      double num = double.parse(value);

      setState(() {
        usdAmountvalue = num * selectedPrice;
      });
    }
  }

  Container _buildAcountCoinTextField() {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff181a26),
          borderRadius: BorderRadius.circular(30)),
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showBarModalBottomSheet(
                  expand: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Scaffold(
                      backgroundColor: Palette.backgroundColor,
                      body: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: coins.map((coin) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedCoin = coin.symbol;
                                  selectedPrice =
                                      coin.quoteModel.usdModel.price;
                                });
                                Navigator.pop(context);
                              },
                              child: CurrencyWidget(
                                coin: coin,
                                isSelected: selectedCoin == coin.symbol,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Palette.cardColor,
                  borderRadius: BorderRadius.circular(30)),
              width: 100,
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: CachedNetworkImage(
                        imageUrl: ((coinIconUrl + selectedCoin + ".png")
                            .toLowerCase()),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            SvgPicture.asset('assets/icons/dollar.svg'),
                      )),
                  const SizedBox(width: 5),
                  Text(
                    selectedCoin,
                    style: const TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Colors.white70,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width - 40 - 100 - 5 - 40 - 10,
            height: 60,
            child: TextField(
              controller: coinAmountController,
              onChanged: handleOnChanged,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: '0.4 $selectedCoin',
                  hintStyle: const TextStyle(color: Colors.white54)),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildAcountUSDTextField() {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff181a26),
          borderRadius: BorderRadius.circular(30)),
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Palette.cardColor,
                borderRadius: BorderRadius.circular(30)),
            width: 100,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CachedNetworkImage(
                      imageUrl:
                          ((coinIconUrl + selectedUSD + ".png").toLowerCase()),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          SvgPicture.asset('assets/icons/dollar.svg'),
                    )),
                const SizedBox(width: 5),
                Text(
                  selectedUSD,
                  style: const TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Colors.white70,
                )
              ],
            ),
          ),
          const SizedBox(width: 5),
          Container(
            width: MediaQuery.of(context).size.width - 40 - 100 - 5 - 40 - 10,
            height: 60,
            child: TextField(
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  enabled: false,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: "${usdAmountvalue.toStringAsFixed(3)} USDT",
                  hintStyle: const TextStyle(color: Colors.white54)),
            ),
          ),
        ],
      ),
    );
  }

  addTransaction() {
    Transaction inTransaction = Transaction(
      description: descriptionController.text,
      acountBalanceCOIN: 0,
      acountBalanceUSD: 0,
      coin: selectedCoin,
      coinAmount: double.parse(coinAmountController.text),
      usdAmount: usdAmountvalue,
      coinPrice: selectedPrice.toDouble(),
      type: "OUT",
      user: Hive.box('user_data').get('id'),
    );

    transactionController.addTransaction(inTransaction).then((response) {
      ShowSnackBar().showSnackBar(
        context,
        response.message!,
        duration: const Duration(seconds: 2),
        noAction: false,
      );

      Navigator.pop(context, "refresh");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 0,
        title: const Text(
          "Add Transaction (OUT)",
        ),
        toolbarHeight: 70,
      ),
      body: coins.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: Palette.primaryColor))
          : SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      //padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Palette.cardColor,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 7,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      height: MediaQuery.of(context).size.height - 320,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: const Text(
                                      "Acount coin",
                                      style: TextStyle(color: Colors.white70),
                                    )),
                                _buildAcountCoinTextField(),
                                const SizedBox(height: 15),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: const Text(
                                      "Acount usd",
                                      style: TextStyle(color: Colors.white70),
                                    )),
                                _buildAcountUSDTextField(),
                                const SizedBox(height: 15),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: const Text(
                                      "Description",
                                      style: TextStyle(color: Colors.white70),
                                    )),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    bottom: 5,
                                    left: 10,
                                    right: 10,
                                  ),
                                  height: 57.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Palette.backgroundColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5.0,
                                        offset: Offset(0.0, 3.0),
                                      )
                                    ],
                                  ),
                                  child: TextField(
                                      controller: descriptionController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      keyboardType: TextInputType.name,
                                      decoration: const InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1.5,
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.description,
                                          color: Palette.primaryColor,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Note transaction",
                                        hintStyle: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.white10,
                          ),
                          GestureDetector(
                            onTap: addTransaction,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 15),
                              width: MediaQuery.of(context).size.width,
                              height: 57.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Palette.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Palette.primaryColor.withAlpha(100),
                                    blurRadius: 5.0,
                                    offset: const Offset(0.0, 3.0),
                                  )
                                ],
                              ),
                              child: const Center(
                                  child: Text("Add",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18))),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Coin price",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 16)),
                                Text(
                                  "${selectedPrice.toStringAsFixed(2)} \$",
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
