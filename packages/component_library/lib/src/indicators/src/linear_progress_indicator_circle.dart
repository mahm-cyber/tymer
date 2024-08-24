import 'package:flutter/material.dart';


class LinearProgressIndicatorCircle extends StatelessWidget {
  const LinearProgressIndicatorCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        width: 30,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: const LinearProgressIndicator(),
      );
  }
}
