import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olympe/models/transaction_model.dart';
import 'package:olympe/statics.dart';

class TransactionHistory extends StatelessWidget {
  final Transaction transaction;
  const TransactionHistory({
    Key? key,
    required this.transaction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color mainColor = (transaction.type == "IN") ? const Color(0xff5fae58) : Colors.red;
    final IconData icon = (transaction.type == "IN") ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;
    final String text = (transaction.type == "IN") ? "Transaction IN" : "Transaction OUT";

    


    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xff222632).withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: mainColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(25)),
              child: Icon(
                icon,
                color: mainColor.withOpacity(0.9),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                height: 32.0,
                width: 32.0,
                child: CachedNetworkImage(
                  imageUrl: ((coinIconUrl + transaction.coin! + ".png").toLowerCase()),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      SvgPicture.asset('assets/icons/dollar.svg'),
                )),
                const SizedBox(width: 5,),
                    Text(text,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(datetimeFormat.format(DateTime.parse(transaction.createdAt!)),
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9), fontSize: 13))
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (transaction.description!.isNotEmpty)
                  ? Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color(0xff303549).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "${transaction.usdAmount!.toStringAsFixed(3)} \$",
                        style: TextStyle(color: Colors.white.withOpacity(0.9)),
                      ))
                  : const SizedBox(height: 18),
                  
                  const SizedBox(height: 10),
                  Text("${transaction.coinAmount!.toStringAsFixed(2)} ${transaction.coin}",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ],
              ),
            )
          ],
        ),
    );
  }
}
