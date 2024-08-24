import 'package:component_library/component_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tab_container/src/l10n/tab_container_localizations.dart';
import 'package:tab_container/src/tab_container_cubit.dart';
import 'package:user_repository/user_repository.dart';

const tabBarHeight = 70.0;

class TabContainerScreen extends StatefulWidget {
  const TabContainerScreen({
    required this.userRepository,
    super.key,
  });

  final UserRepository userRepository;

  @override
  State<TabContainerScreen> createState() => _TabContainerScreenState();
}

class _TabContainerScreenState extends State<TabContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabContainerCubit>(
      create: (_) => TabContainerCubit(
        userRepository: widget.userRepository,
      ),
      child: const TabContainerView(),
    );
  }
}

class TabContainerView extends StatelessWidget {
  const TabContainerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TabContainerCubit, TabContainerState>(
      listener: (context, state) {
        final l10n = TabContainerLocalizations.of(context);
        if (state.refreshAppDependenciesState ==
            RefreshAppDependenciesState.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.appDependenciesFetchSuccessSnackBarMessage,
            ),
          );
        }
      },
      builder: (context, state) {
        final tabPage = TabPage.of(context);
        final l10n = TabContainerLocalizations.of(context);
        final localizedNavBarTabs = localizeNavBarTabs(l10n);
        final colorScheme =
            TymerTheme.of(context).materialThemeData.colorScheme;
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
              color: colorScheme.primary,
              height: tabBarHeight,
              child: TabBar(
                dividerColor: colorScheme.primary,
                controller: tabPage.controller,
                indicator: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.secondary,
                      width: 5,
                    ),
                  ),
                ),
                labelStyle:
                    textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500),
                labelPadding: EdgeInsets.zero,
                indicatorColor: colorScheme.secondary,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: <Widget>[
                  for (int i = 0; i < tabPage.stacks.length; i++)
                    NavBarTab(
                      title: localizedNavBarTabs[i].title,
                      icon: localizedNavBarTabs[i].icon,
                      svgPath: localizedNavBarTabs[i].svgPath,
                      isSelected: tabPage.index == i,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

List<NavBarTabModel> localizeNavBarTabs(
  TabContainerLocalizations l10n,
) {
  final navBarTabs = [
    NavBarTabModel(
      svgPath: 'assets/icons/tasks.svg',
      title: l10n.tasksTabLabel,
    ),
    NavBarTabModel(
      svgPath: 'assets/icons/contacts.svg',
      title: l10n.contactsTabLabel,
    ),
    NavBarTabModel(
      svgPath: 'assets/icons/company.svg',
      title: l10n.companiesTabLabel,
    ),
    NavBarTabModel(
      svgPath: 'assets/icons/deals.svg',
      title: l10n.dealsTabLabel,
    ),
    NavBarTabModel(
      svgPath: 'assets/icons/menu.svg',
      title: l10n.menuTabLabel,
    ),
  ];
  return navBarTabs;
}

class NavBarTabModel {
  const NavBarTabModel({
    required this.title,
    this.icon,
    this.svgPath,
  });

  final String title;
  final IconData? icon;
  final String? svgPath;
}
