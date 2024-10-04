import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_up/src/components/components.dart';
import 'package:sign_up/src/sign_up_cubit.dart';

class FormFields extends StatelessWidget {
  const FormFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Expanded(
          child: ListView(
            children: [
              VerticalGap.large(),
              Name(),
              VerticalGap.xSmall(),
              Phone(),
              VerticalGap.xSmall(),
              Email(),
              VerticalGap.xSmall(),
              Password(),
              VerticalGap.xSmall(),
              PasswordConfirmation(),
            ],
          ),
        );
      },
    );
  }
}
