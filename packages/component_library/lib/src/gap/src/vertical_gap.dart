import 'package:flutter/cupertino.dart';

class VerticalGap extends StatelessWidget {
  final double height;

  const VerticalGap._internal({
    super.key,
    required this.height,
  });

  factory VerticalGap.xSmall({Key? key}) =>
      VerticalGap._internal(key: key, height:  4);
  factory VerticalGap.small({Key? key}) =>
      VerticalGap._internal(key: key, height:  8);
  factory VerticalGap.smallMedium({Key? key}) =>
      VerticalGap._internal(key: key, height:  10);
  factory VerticalGap.medium({Key? key}) =>
      VerticalGap._internal(key: key, height:  12);
  factory VerticalGap.mediumLarge({Key? key}) =>
      VerticalGap._internal(key: key, height:  16);
  factory VerticalGap.large({Key? key}) =>
      VerticalGap._internal(key: key, height:  20);
  factory VerticalGap.xLarge({Key? key}) =>
      VerticalGap._internal(key: key, height:  24);
  factory VerticalGap.xxLarge({Key? key}) =>
      VerticalGap._internal(key: key, height:  48);
  factory VerticalGap.xxxLarge({Key? key}) =>
      VerticalGap._internal(key: key, height:  64);
  factory VerticalGap.huge({Key? key}) =>
      VerticalGap._internal(key: key, height:  89);
  factory VerticalGap.xHuge({Key? key}) =>
      VerticalGap._internal(key: key, height:  130);



  // because sometimes you need it:
  factory VerticalGap.custom(double height, {Key? key}) =>
      VerticalGap._internal(key: key, height: height);

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}
