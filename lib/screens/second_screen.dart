import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olympe/Controllers/transaction_controller.dart';
import 'package:olympe/components/glassmorphism.dart';
import 'package:olympe/components/snackbar.dart';
import 'package:olympe/models/transaction_model.dart';
import 'package:olympe/statics.dart';
import 'package:olympe/widgets/transaction_history.dart';
import 'package:olympe/widgets/wallet_button.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with AutomaticKeepAliveClientMixin<SecondScreen> {
  @override
  bool get wantKeepAlive => true;

  final TransactionController transactionController = TransactionController();
  late double? currentBalance;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  fetchTransactions() {
    transactionController.getTransactions().then((list) {
      currentBalance = 0;

      if (list != null && currentBalance != null) {
        setState(() {
          transactions = list;
          isLoading = false;
          transactions.forEach((transaction) {
            if (transaction.type == "IN" && currentBalance != null) {
              currentBalance = transaction.usdAmount! + currentBalance!;
            } else {
              currentBalance = currentBalance! - transaction.usdAmount!;
            }
          });
        });
      } else {
        ShowSnackBar().showSnackBar(
          context,
          "Try again later!",
          duration: const Duration(seconds: 2),
          noAction: false,
        );
      }
    });
  }

  bool isLoading = true;
  List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(color: Palette.primaryColor),
          )
        : Stack(
            children: [
              RefreshIndicator(
                backgroundColor: Palette.buttonColor,
                color: Palette.primaryColor,
                onRefresh: () async {
                  print("test");
                  await Future.delayed(const Duration(seconds: 2));
                  fetchTransactions();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GlassMorphism(
                        blur: 10,
                        opacity: 0.2,
                        myWidth: 140,
                        color: Palette.backgroundColor,
                        myHeight: double.infinity,
                        child: Column(children: <Widget>[
                          Container(
                              padding: const EdgeInsets.only(left: 10),
                              margin: const EdgeInsets.only(bottom: 5, top: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Current Balance",
                                        style: TextStyle(
                                          fontFamily: "Oswald",
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  ])),
                          const SizedBox(
                            width: 25,
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Icon(Icons.attach_money,
                                    color: Colors.white, size: 35),
                                Center(
                                  child: Text(
                                    currentBalance!.toStringAsFixed(2),
                                    style: const TextStyle(
                                        fontFamily: "Oswald",
                                        color: Colors.white,
                                        fontSize: 35),
                                  ),
                                ),
                              ]),
                        ]),
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          margin: const EdgeInsets.only(bottom: 5, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WalletButton(
                                  height: 60,
                                  width: 60,
                                  icon: CupertinoIcons.tray_arrow_up,
                                  text: "Send",
                                  backgroundColor: Palette.buttonColor,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                            context, "/addTransaction/IN")
                                        .then((value) {
                                      if (value == "refresh") {
                                        print("refreshing transactions");
                                        fetchTransactions();
                                      }
                                    });
                                  }),
                              const SizedBox(width: 25),
                              WalletButton(
                                  height: 60,
                                  width: 60,
                                  icon: CupertinoIcons.arrow_2_circlepath,
                                  backgroundColor: Palette.primaryColor,
                                  textColor: Colors.white,
                                  text: ("Sync"),
                                  onPressed: () {
                                    fetchTransactions();
                                  }),
                              const SizedBox(width: 25),
                              WalletButton(
                                  height: 60,
                                  width: 60,
                                  icon: CupertinoIcons.tray_arrow_down,
                                  backgroundColor: Palette.buttonColor,
                                  textColor: Colors.white,
                                  text: "Receive",
                                  onPressed: () {
                                    Navigator.pushNamed(
                                            context, "/addTransaction/OUT")
                                        .then((value) {
                                      if (value == "refresh") {
                                        print("refreshing transactions");
                                        fetchTransactions();
                                      }
                                    });
                                  })
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        margin: const EdgeInsets.only(bottom: 5, top: 40),
                        child: const Text(
                          "Your Activity",
                          style: TextStyle(
                              fontFamily: "Oswald",
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: transactions.map((transaction) {
                            return TransactionHistory(transaction: transaction);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
