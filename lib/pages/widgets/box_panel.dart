import 'package:traffix/constants/constants.dart';
import 'package:flutter/material.dart';

class BoxPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final DecorationImage? image;
  final BoxShadow shadow;

  const BoxPanel({
    Key? key,
    required this.child,
    this.image,
    this.shadow = const BoxShadow(
      color: kShadowColor5,
      blurRadius: kSpacingUnit * 4,
      offset: Offset(0, kSpacingUnit * 2),
    ),
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(
        horizontal: kSpacingUnit * 2,
        vertical: kSpacingUnit * 1.5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kSpacingUnit / 2),
        image: image,
        boxShadow: [
          shadow,
        ],
      ),
      child: child,
    );
  }
}
