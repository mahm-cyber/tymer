import 'package:change_password/src/components/change_password_text_form_fields/new_password.dart';
import 'package:change_password/src/components/change_password_text_form_fields/new_password_confirmation.dart';
import 'package:change_password/src/components/change_password_text_form_fields/password.dart';
import 'package:change_password/src/components/components.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:change_password/src/change_password_cubit.dart';

class FormFields extends StatelessWidget {
  const FormFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      builder: (context, state) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: theme.screenMargin * 2),
          shrinkWrap: true,
          children: [
            const SvgAsset(
              AssetPathConstants.logoAndWordPath,
              width: 60,
            ),
            VerticalGap.large(),
            VerticalGap.large(),
            const Password(),
            VerticalGap.small(),
            const NewPassword(),
            VerticalGap.small(),
            const NewPasswordConfirmation(),
            VerticalGap.large(),
            const ChangePasswordButton(),
            VerticalGap.medium(),

          ],
        );
      },
    );
  }
}
