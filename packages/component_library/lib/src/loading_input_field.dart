import 'package:flutter/material.dart';




class LoadingInputField extends StatelessWidget {
  const LoadingInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: LinearProgressIndicator(
        color: Colors.grey.withAlpha((255 * 0.3).toInt()),
        backgroundColor: Colors.white,
      ),
    );
  }
}
