import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:withdraw/src/l10n/withdraw_localizations.dart';
import 'package:withdraw/src/withdraw_cubit.dart';

class WalletNumberTextField extends StatefulWidget {
  const WalletNumberTextField({super.key});

  @override
  State<WalletNumberTextField> createState() => _WalletNumberTextFieldState();
}

class _WalletNumberTextFieldState extends State<WalletNumberTextField> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpFocusListener();
  }

  void _setUpFocusListener() {
    final cubit = context.read<WithdrawCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onWalletNumberUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WithdrawCubit, WithdrawState>(builder: (context, state) {
      final cubit = context.read<WithdrawCubit>();
      final error =
          state.walletNumber.isNotValid ? state.walletNumber.error : null;
      final l10n = WithdrawLocalizations.of(context);
      final clL10n = ComponentLibraryLocalizations.of(context);

      return TextFormField(
        focusNode: _focusNode,
        onChanged: cubit.onWalletNumberChanged,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          isDense: true,
          helperText: '',
          prefixIcon: const SvgAsset(AssetPathConstants.mobilePath),
          labelText: l10n.walletNumberTextFieldLabel,
          errorText: error == DynamicValidationError.empty
              ? clL10n.requiredFieldErrorMessage
              : error == DynamicValidationError.isNotEgyptianMobile
                  ? l10n.invalidWalletNumberErrorMessage
                  : null,
        ),
      );
    });
  }
}
