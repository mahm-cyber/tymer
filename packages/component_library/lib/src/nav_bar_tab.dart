import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NavBarTab extends StatelessWidget {
  const NavBarTab({
    super.key,
    required this.title,
    this.icon,
    this.svgPath,
    required this.isSelected,
  });

  final String title;
  final IconData? icon;
  final String? svgPath;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    assert(
      icon != null || svgPath != null,
      'Must provide either an svgPath or an icon',
    );
    final theme = TymerTheme.of(context).materialThemeData;
    // final appLocale = Localizations.localeOf(context);
    // final isArabic = appLocale == const Locale('ar');
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Tab(
        iconMargin: const EdgeInsets.only(bottom: 8),

        text: title,
        icon: SvgPicture.asset(
          svgPath!,
          colorFilter: ColorFilter.mode(
            isSelected
                ? theme.colorScheme.surface
                : theme.tabBarTheme.unselectedLabelColor!,
            BlendMode.srcIn,
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
