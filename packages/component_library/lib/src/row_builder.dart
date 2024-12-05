import 'package:flutter/material.dart';

class RowBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final int itemCount;
  final IndexedWidgetBuilder? separatorBuilder;

  const RowBuilder({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.separatorBuilder,
  });

  // separated unnamed constructor
  const RowBuilder.separated({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    required this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      verticalDirection: verticalDirection,
      children: List.generate(itemCount, (index) {
        final widgets = <Widget>[];
        widgets.add(itemBuilder(context, index));
        if (separatorBuilder != null && index < itemCount - 1) {
          widgets.add(separatorBuilder!(context, index));
        }
        return Row(
          children: widgets,
        );
      }).toList(),
    );
  }
}
