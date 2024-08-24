
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class NewPageProgressIndicator extends StatelessWidget {
  const NewPageProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 7,
      width: MediaQuery.of(context).size.width / 2.5,
      child: const CenteredCircularProgressIndicator(),
    );
  }
}
