import 'package:flutter/material.dart';


extension FocusRelease on BuildContext {
  void releaseFocus() => FocusScope.of(this).unfocus();
}

