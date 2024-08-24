import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const iconsPath = 'icons';

class SvgAsset extends StatelessWidget {
  const SvgAsset(
    this.assetPath, {
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.scaleDown,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    // final theme = TymerkTheme.of(context);

    return SvgPicture.asset(
      width: width,
      height: height,
      'assets/$assetPath',
      fit: fit ?? BoxFit.scaleDown,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            ),
    );
  }
}
