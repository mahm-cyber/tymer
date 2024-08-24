import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:sign_up/src/sign_up_cubit.dart';


class Phone extends StatefulWidget {
  const Phone({
    super.key,
  });

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignUpCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onPhoneUnfocused();
      } else {
        cubit.onPhoneFocused();
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
        final error = state.phone.isNotValid ? state.phone.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        // final theme = TymerTheme.of(context);

        return PhoneTextField(
          isInputRequired: true,
          focusNode: _focusNode,
          helperText: '',
          onChanged: context.read<SignUpCubit>().onPhoneChanged,
          error: error,
          enabled: !isSubmissionInProgress,
        );
      },
    );
  }
}
