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
    required this.onRequestServiceTapped,
    required this.onProvideServiceTapped,
    required this.onChatTapped,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onRequestServiceTapped;
  final VoidCallback onProvideServiceTapped;
  final VoidCallback onChatTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => HomeCubit(
        userRepository: userRepository,
        onRequestServiceTapped: onRequestServiceTapped,
        onProvideServiceTapped: onProvideServiceTapped,
        onChatTapped: onChatTapped,
      ),
      child: const HomeView(),
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
    final cubit = context.read<HomeCubit>();
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: context.releaseFocus,
      child: Stack(
        children: [
          Scaffold(
            floatingActionButton: SizedBox(
              height: 45,
              child: FloatingActionButton.extended(
                isExtended: true,
                label: Text(
                  l10n.fabLabel,
                  style: textTheme.labelLarge?.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
                // shape: const CircleBorder(),
                onPressed: cubit.onChatTapped,
                extendedIconLabelSpacing: 0,
                extendedPadding: const EdgeInsetsDirectional.only(
                  end: Spacing.smallMedium,
                ),
                icon: Transform.scale(
                  scale: 0.5,
                  child: const SvgAsset(
                    AssetPathConstants.chatPath,
                    // width: 50,
                    // height: 50,
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              title: const SvgAsset(AssetPathConstants.whiteLogoPath),
              toolbarHeight: 160,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TymerGestureContainer(
                    onTap: cubit.onRequestServiceTapped,
                    icon: const SvgAsset(AssetPathConstants.potPath),
                    title: l10n.requestServiceContainerTitle,
                    subtitle: l10n.requestServiceContainerSubtitle,
                  ),
                  VerticalGap.xxLarge(),
                  TymerGestureContainer(
                    onTap: cubit.onProvideServiceTapped,
                    icon: const SvgAsset(AssetPathConstants.footPrintsPath),
                    title: l10n.provideServiceContainerTitle,
                    subtitle: l10n.provideServiceContainerSubtitle,
                  ),
                  // TextButton(
                  //   onPressed: () => throw Exception(),
                  //   child: const Text("Throw Test Exception"),
                  // ),
                ],
              ),
            ),
          ),
          AppBarTitleContainer(
            title: l10n.appBarTitle,
          ),
        ],
      ),
    );
  }
}
