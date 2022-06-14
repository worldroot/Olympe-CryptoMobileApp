import 'package:flutter/material.dart';
import 'dart:ui';

class GlassMorphism extends StatelessWidget {
  final double blur;
  final double opacity;
  final Widget child;
  final double myWidth;
  final double myHeight;

  const GlassMorphism({
    Key? key,
    required this.blur,
    required this.opacity,
    required this.child,
    required this.myWidth,
    required this.myHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        // borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        height: myWidth,
        width: myHeight,
        decoration: BoxDecoration(
          color: Colors.indigo.withOpacity(opacity), // Colors.indigo[900]
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: child,
      ),
    ));
  }
}
