import 'package:flutter/cupertino.dart';

class HorizontalGap extends StatelessWidget {
  final double width;

  const HorizontalGap._internal({
    super.key,
    required this.width,
  });

  factory HorizontalGap.xSmall({Key? key}) =>
      HorizontalGap._internal(key: key, width:  4);
  factory HorizontalGap.small({Key? key}) =>
      HorizontalGap._internal(key: key, width:  8);
  factory HorizontalGap.smallMedium({Key? key}) =>
      HorizontalGap._internal(key: key, width:  10);
  factory HorizontalGap.medium({Key? key}) =>
      HorizontalGap._internal(key: key, width:  12);
  factory HorizontalGap.mediumLarge({Key? key}) =>
      HorizontalGap._internal(key: key, width:  16);
  factory HorizontalGap.large({Key? key}) =>
      HorizontalGap._internal(key: key, width:  20);
  factory HorizontalGap.xLarge({Key? key}) =>
      HorizontalGap._internal(key: key, width:  24);
  factory HorizontalGap.xxLarge({Key? key}) =>
      HorizontalGap._internal(key: key, width:  48);
  factory HorizontalGap.xxxLarge({Key? key}) =>
      HorizontalGap._internal(key: key, width:  64);
  factory HorizontalGap.huge({Key? key}) =>
      HorizontalGap._internal(key: key, width:  89);
  factory HorizontalGap.xHuge({Key? key}) =>
      HorizontalGap._internal(key: key, width:  130);



  // because sometimes you need it:
  factory HorizontalGap.custom(double width, {Key? key}) =>
      HorizontalGap._internal(key: key, width: width);

  @override
  Widget build(BuildContext context) => SizedBox(width: width);
}
