import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olympe/Controllers/transaction_controller.dart';
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

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  fetchTransactions() {
    transactionController.getTransactions().then((list) {
      if (list != null) {
        setState(() {
          transactions = list;
          isLoading = false;
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
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          margin: const EdgeInsets.only(bottom: 5, top: 10),
                          child: Text(
                            "Current Balance",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 17),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          margin: const EdgeInsets.only(bottom: 5, top: 10),
                          child: const Text(
                            "500 DT",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 45),
                          ),
                        ),
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
                                    print("test");
                                  }),
                              const SizedBox(width: 25),
                              WalletButton(
                                  height: 60,
                                  width: 60,
                                  icon: CupertinoIcons.arrow_2_circlepath,
                                  backgroundColor: Palette.primaryColor,
                                  textColor: Colors.white,
                                  text: "Sync",
                                  onPressed: () {
                                    print("test");
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
                                    print("test");
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
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
