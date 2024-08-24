import 'package:reset_password/src/components/change_password_text_form_fields/change_password_text_form_fields.dart';
import 'package:reset_password/src/reset_password_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormFields extends StatelessWidget {
  const FormFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        return Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              NewPassword(),
              NewPasswordConfirmation(),
              SizedBox(
                height: Spacing.xLarge + Spacing.medium,
              )
            ],
          ),
        );
      },
    );
  }
}
