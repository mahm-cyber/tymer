
import 'package:flutter/material.dart';


class NoItemsFoundIndicator extends StatelessWidget {
  const NoItemsFoundIndicator({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        message,
        style: textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
