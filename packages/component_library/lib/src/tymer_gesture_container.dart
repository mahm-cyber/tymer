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
    final cubit = context.read<HomeCubit>();
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
                  HomeContainer(
                    onTap: () {},
                    icon: SvgAsset(AssetPathConstants.potPath),
                    title: l10n.requestServiceContainerTitle,
                    subtitle: l10n.requestServiceContainerSubtitle,
                  ),
                  VerticalGap.xxLarge(),
                  HomeContainer(
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
          Positioned(
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
              child: Text(
                l10n.appBarTitle,
                style:
                    textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final VoidCallback onTap;
  final Widget icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: Spacing.large),
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(Spacing.xSmall),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: icon,
            ),
            HorizontalGap.medium(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.surface,
                      fontSize: 20,
                    )),
                if (subtitle != null) ...[
                  VerticalGap.xSmall(),
                  Text(
                    subtitle!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.surface.withOpacity(0.6),
                    ),
                  ),
                ],
              ],
            ),
            HorizontalGap.medium(),
            RotatedBox(
              quarterTurns: isArabic ? 2 : 0,
              child: SvgAsset(
                AssetPathConstants.arrowRightSquarePath,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
