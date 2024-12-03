import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:wallet/src/wallet_cubit.dart';
import 'package:wallet/src/l10n/wallet_localizations.dart';

import 'package:user_repository/user_repository.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({
    required this.userRepository,
    required this.onRequestServiceTapped,
    required this.onProvideServiceTapped,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onRequestServiceTapped;
  final VoidCallback onProvideServiceTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletCubit>(
      create: (_) => WalletCubit(
        userRepository: userRepository,
        onRequestServiceTapped: onRequestServiceTapped,
        onProvideServiceTapped: onProvideServiceTapped,
      ),
      child: const WalletView(),
    );
  }
}

class WalletView extends StatelessWidget {
  const WalletView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final l10n = WalletLocalizations.of(context);
    return GestureDetector(
      onTap: context.releaseFocus,
      child: Stack(
        children: [
          Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Transform.scale(
                  scale: 0.7,
                  child: const SvgAsset(
                    AssetPathConstants.chatPath,
                    width: 50,
                    height: 50,
                  )),
            ),
            appBar: AppBar(
              title: const SvgAsset(AssetPathConstants.whiteLogoPath),
              toolbarHeight: 160,
            ),
            body: Column(
              children: [
                VerticalGap.xxLarge(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HorizontalGap.custom(theme.screenMargin),
                    WalletButton(
                      icon: const SvgAsset(AssetPathConstants.whiteBankNote),
                      title: l10n.withdrawalContainerTitle,
                      onTap: (){},
                    ),
                    WalletButton(
                      icon: const SvgAsset(AssetPathConstants.arrowTowardsBox),
                      title: l10n.topUpContainerTitle,
                      onTap: (){},
                    ),
                    HorizontalGap.custom(theme.screenMargin),
                  ],
                ),
              ],
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

class WalletButton extends StatelessWidget {
  const WalletButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.mediumLarge,
          vertical: Spacing.medium,
        ),
        decoration: BoxDecoration(
          color: theme.materialThemeData.colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            HorizontalGap.medium(),
            Text(
              title,
              style: theme.materialThemeData.textTheme.titleMedium?.copyWith(
                color: theme.materialThemeData.colorScheme.surface,
                fontSize: 16,
                // fontWeight: FontWeight.w500,
              ),
            ),
            HorizontalGap.medium(),
            const SvgAsset(
              AssetPathConstants.arrowRightSquarePath,
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
