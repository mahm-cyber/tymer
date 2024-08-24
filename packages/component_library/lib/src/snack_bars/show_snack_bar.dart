import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required SnackBar snackBar,
}) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(snackBar);
}
