import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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

  // Container _buildAcountCoinTextField() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         color: const Color(0xff181a26),
  //         borderRadius: BorderRadius.circular(30)),
  //     width: MediaQuery.of(context).size.width - 40,
  //     height: 60,
  //     padding: const EdgeInsets.all(5),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //               color: Palette.cardColor,
  //               borderRadius: BorderRadius.circular(30)),
  //           width: 100,
  //           height: 60,
  //         ),
  //         const SizedBox(width: 5),
  //         Container(
  //           padding: const EdgeInsets.only(top: 10),
  //           width: MediaQuery.of(context).size.width - 40 - 100 - 5 - 40 - 10,
  //           height: 60,
  //           child: const TextField(
  //             style: TextStyle(
  //               color: Colors.white,
  //             ),
  //             decoration: InputDecoration(
  //                 focusedBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.transparent),
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.transparent),
  //                 ),
  //                 hintText: '0.4 ETH',
  //                 hintStyle: TextStyle(color: Colors.white54)),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // handleSend() {
  //   showBarModalBottomSheet(
  //     expand: true,
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //       color: Palette.backgroundColor,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           const Text("Send"),
  //           Container(
  //             padding: const EdgeInsets.all(20),
  //             decoration: BoxDecoration(
  //               color: Palette.cardColor,
  //               borderRadius: BorderRadius.circular(25),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.1),
  //                   spreadRadius: 7,
  //                   blurRadius: 5,
  //                   offset: const Offset(0, 3), // changes position of shadow
  //                 ),
  //               ],
  //             ),
  //             height: MediaQuery.of(context).size.height - 200,
  //             child: Column(
  //               children: [
  //                 _buildAcountCoinTextField(),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
                              children: const <Widget>[
                                Icon(Icons.attach_money,
                                    color: Colors.white, size: 35),
                                Center(
                                  child: Text(
                                    "500 DT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
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
                                        context, "/addTransaction");
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
