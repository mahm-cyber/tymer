import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_up/src/l10n/sign_up_localizations.dart';

import 'package:sign_up/src/sign_up_cubit.dart';

class Name extends StatefulWidget {
  const Name({
    super.key,
  });

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      final cubit = context.read<SignUpCubit>();
      if (!_focusNode.hasFocus) {
        cubit.onNameUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final error = state.name.isNotValid ? state.name.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        // final theme = TymerTheme.of(context);
        final l10n = SignUpLocalizations.of(context);
        final cubit = context.read<SignUpCubit>();
        return TextField(
          focusNode: _focusNode,
          onChanged: cubit.onNameChanged,
          decoration: InputDecoration(
            prefixIcon: const SvgAsset(
              AssetPathConstants.personPath,
            ),
            hintText: l10n.nameTextFieldHint,
            labelText: l10n.nameTextFieldLabel,
            helperText: '',
            errorText: error == DynamicValidationError.empty
                ? l10n.requiredTextFieldErrorMessage
                : null,
          ),
          enabled: !isSubmissionInProgress,
        );
      },
    );
  }
}
