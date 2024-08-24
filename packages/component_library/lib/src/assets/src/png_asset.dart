import 'package:flutter/material.dart';


class PngAsset extends StatelessWidget {
  const PngAsset(
    this.assetPath, {
    super.key,
    this.width,
    this.height,
    this.color,
  });

  static const iconsPath = 'icons';
  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/$assetPath',
      width: width,
      height: height,
    );
  }
}