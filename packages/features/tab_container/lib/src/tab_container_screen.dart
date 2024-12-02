import 'package:component_library/component_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tab_container/src/l10n/tab_container_localizations.dart';

const tabBarHeight = 55.0;

class TabContainerScreen extends StatelessWidget {
  const TabContainerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);
    final l10n = TabContainerLocalizations.of(context);
    final localizedNavBarTabs = localizeNavBarTabs(l10n);
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: TabBarView(
        controller: tabPage.controller,
        physics: const NeverScrollableScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        children: [
          for (final stack in tabPage.stacks)
            PageStackNavigator(
              stack: stack,
            )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: tabBarHeight,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: theme.borderColor))),
          child: TabBar(
            controller: tabPage.controller,
            labelStyle: textTheme.labelSmall
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 10),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: colorScheme.primary,
            unselectedLabelColor: theme.dimmedTextColor,
            dividerColor: Colors.green,
            indicator: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: colorScheme.primary,
                  width: 2,
                ),
              ),
            ),
            tabs: <Widget>[
              for (int i = 0; i < tabPage.stacks.length; i++)
                NavBarTab(
                  title: localizedNavBarTabs[i].title,
                  svgPath: tabPage.index == i
                      ? localizedNavBarTabs[i].selectedSvgPath
                      : localizedNavBarTabs[i].unselectedSvgPath,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

List<NavBarTabModel> localizeNavBarTabs(
  TabContainerLocalizations l10n,
) {
  final navBarTabs = [
    NavBarTabModel(
      unselectedSvgPath: AssetPathConstants.homeUnselectedPath,
      selectedSvgPath: AssetPathConstants.homeSelectedPath,
      title: l10n.homeTabLabel,
    ),
    // NavBarTabModel(
    //   unselectedSvgPath: AssetPathConstants.searchUnselectedPath,
    //   selectedSvgPath: AssetPathConstants.searchSelectedPath,
    //   title: l10n.searchTabLabel,
    // ),
    NavBarTabModel(
      unselectedSvgPath: AssetPathConstants.walletUnselectedPath,
      selectedSvgPath: AssetPathConstants.walletSelectedPath,
      title: l10n.walletTabLabel,
    ),
    NavBarTabModel(
      unselectedSvgPath: AssetPathConstants.documentUnselectedPath,
      selectedSvgPath: AssetPathConstants.documentSelectedPath,
      title: l10n.ordersTabLabel,
    ),
    NavBarTabModel(
      unselectedSvgPath: AssetPathConstants.profileUnselectedPath,
      selectedSvgPath: AssetPathConstants.profileSelectedPath,
      title: l10n.profileTabLabel,
    ),
  ];
  return navBarTabs;
}

class NavBarTabModel {
  const NavBarTabModel({
    required this.title,
    required this.unselectedSvgPath,
    required this.selectedSvgPath,
  });

  final String title;
  final String unselectedSvgPath;
  final String selectedSvgPath;
}
