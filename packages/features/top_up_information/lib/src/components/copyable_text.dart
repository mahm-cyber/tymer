import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyableText extends StatelessWidget {
  const CopyableText({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: EdgeInsets.only(
        left: theme.screenMargin,
        right: theme.screenMargin,
        bottom: Spacing.smallMedium,
      ),
      elevation: 4.0,
      child: ListTile(
        title: Text(
          label,
          style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: SelectableText(value),
        trailing: IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Copied $label to clipboard')),
            );
          },
        ),
      ),
    );
  }
}
