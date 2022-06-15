import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olympe/components/glassmorphism.dart';
import 'package:olympe/statics.dart';
import 'package:olympe/widgets/wallet_button.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.custom_icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData custom_icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GlassMorphism(
          color: Colors.transparent,
          blur: 10,
          myWidth: 150,
          myHeight: double.infinity,
          opacity: 0.2,
          child: TextButton(
            style: TextButton.styleFrom(
              primary: Palette.buttonColor,
              padding: const EdgeInsets.all(20),
            ),
            onPressed: press,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WalletButton(
                  icon: custom_icon,
                  backgroundColor: Palette.backgroundColor,
                  height: 240,
                  onPressed: () {},
                  text: text,
                  textColor: Palette.textColor,
                  width: 60,
                ),
              ],
            ),
          )),
    );
  }
}
