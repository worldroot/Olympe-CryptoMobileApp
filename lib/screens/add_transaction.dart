import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:olympe/statics.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String selectedCoin = "BTC";
  String selectedUSD = "USDT";

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
                  builder: (context) => Container(
                        color: Colors.red,
                      ));
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
            child: const TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: '0.4 ETH',
                  hintStyle: TextStyle(color: Colors.white54)),
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
          InkWell(
            onTap: () {
              showBarModalBottomSheet(
                  expand: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Container(
                        color: Colors.green,
                      ));
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
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width - 40 - 100 - 5 - 40 - 10,
            height: 60,
            child: const TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: '0.4 ETH',
                  hintStyle: TextStyle(color: Colors.white54)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 0,
        title: const Text(
          "Add Transaction",
        ),
        toolbarHeight: 70,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Palette.cardColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 7,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        child: const Text(
                          "Acount coin",
                          style: TextStyle(color: Colors.white70),
                        )),
                    _buildAcountCoinTextField(),
                    const SizedBox(height: 15),
                    Container(
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        child: const Text(
                          "Acount usd",
                          style: TextStyle(color: Colors.white70),
                        )),
                    _buildAcountUSDTextField(),
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
