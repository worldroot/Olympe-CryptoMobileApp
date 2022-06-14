import 'package:flutter/material.dart';

class WalletButton extends StatelessWidget {
  final double height;
  final double width;
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final void Function() onPressed;

  const WalletButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.icon,
      required this.text,
      required this.backgroundColor,
      required this.textColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
              width: height,
              height: width,
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Icon(icon, color: textColor)),
          const SizedBox(height: 10),
          Text(text,
              style: const TextStyle(
                  fontFamily: "Oswald", fontSize: 15, color: Colors.white))
        ],
      ),
    );
  }
}
