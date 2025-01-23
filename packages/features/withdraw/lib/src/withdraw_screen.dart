import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:withdraw/src/l10n/withdraw_localizations.dart';
import 'package:withdraw/src/withdraw_cubit.dart';

import 'package:user_repository/user_repository.dart';

import 'components/withdraw_amount_text_field.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({
    required this.userRepository,
    required this.onBackTapped,
    required this.onProvideServiceTapped,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onBackTapped;
  final VoidCallback onProvideServiceTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WithdrawCubit>(
      create: (_) => WithdrawCubit(
        userRepository: userRepository,
        onBackTapped: onBackTapped,
        onProvideServiceTapped: onProvideServiceTapped,
      ),
      child: const WithdrawView(),
    );
  }
}

class WithdrawView extends StatelessWidget {
  const WithdrawView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = WithdrawLocalizations.of(context);
    final cubit = context.read<WithdrawCubit>();
    return GestureDetector(
      onTap: context.releaseFocus,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: cubit.onBackTapped,
              ),
              title: const SvgAsset(
                AssetPathConstants.whiteLogoPath,
                height: 30,
              ),
              toolbarHeight: 160,
              iconTheme: IconThemeData(color: colorScheme.surface),
            ),
            body: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
                children: [
                  const WithdrawAmountInputField(),
                  VerticalGap.xxLarge(),
                  TymerElevatedButton(
                    label: l10n.withdrawConfirmButtonLabel,
                    onTap: cubit.onSubmit,
                  )
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
