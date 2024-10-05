import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:home/src/home_cubit.dart';
import 'package:home/src/l10n/home_localizations.dart';

import 'package:user_repository/user_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.userRepository,
    required this.onLogout,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(
        userRepository: userRepository,
        onLogout: onLogout,
      ),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final l10n = HomeLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: context.releaseFocus,
      child: Stack(
        children: [
          Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Transform.scale(
                  scale: 0.7,
                  child: SvgAsset(
                    AssetPathConstants.chatPath,
                    width: 50,
                    height: 50,
                  )),
            ),
            appBar: AppBar(
              title: SvgAsset(AssetPathConstants.whiteLogoPath),
              toolbarHeight: 160,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.screenMargin * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TymerGestureContainer(
                    onTap: () {},
                    icon: SvgAsset(AssetPathConstants.potPath),
                    title: l10n.requestServiceContainerTitle,
                    subtitle: l10n.requestServiceContainerSubtitle,
                  ),
                  VerticalGap.xxLarge(),
                  TymerGestureContainer(
                    onTap: () {},
                    icon: SvgAsset(AssetPathConstants.footPrintsPath),
                    title: l10n.provideServiceContainerTitle,
                    subtitle: l10n.provideServiceContainerSubtitle,
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     context.read<HomeCubit>().userRepository.logout();
                  //     cubit.onLogout();
                  //   },
                  //   child: const Text('logout'),
                  // ),
                ],
              ),
            ),
          ),
          AppBarTitleContainer(title: l10n.appBarTitle,),
        ],
      ),
    );
  }
}

class AppBarTitleContainer extends StatelessWidget {
  const AppBarTitleContainer({
    super.key,
    required this.title,
    this.icon,
  });

  final String title;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Positioned(
      top: 170,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: theme.screenMargin * 2),
        decoration: BoxDecoration(
          color: theme.materialThemeData.colorScheme.surface,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: kElevationToShadow[1],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            HorizontalGap.small(),
            Text(
              title,
              style:
                  textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
