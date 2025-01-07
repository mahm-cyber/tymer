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
    final l10n = WalletLocalizations.of(context);
    return GestureDetector(
      onTap: context.releaseFocus,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const SvgAsset(AssetPathConstants.whiteLogoPath),
              toolbarHeight: 160,
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VerticalGap.xxLarge(),
                  Wrap(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: Spacing.medium,
                    // crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: Spacing.medium,
                    // runAlignment: WrapAlignment.center,
                    // alignment: WrapAlignment.center,
                    children: [
                      WalletButton(
                        icon: const SvgAsset(AssetPathConstants.whiteBankNote),
                        title: l10n.withdrawalContainerTitle,
                        onTap: () {},
                      ),
                      WalletButton(
                        icon: const SvgAsset(AssetPathConstants.arrowTowardsBox),
                        title: l10n.topUpContainerTitle,
                        onTap: () {},
                      ),
                    ],
                  ),
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
    final textTheme = Theme.of(context).textTheme;
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
        width: 175,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            HorizontalGap.medium(),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
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
