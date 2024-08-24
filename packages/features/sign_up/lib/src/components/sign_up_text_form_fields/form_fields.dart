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
        final cubit = context.read<SignUpCubit>();
        return Expanded(
          child: SingleChildScrollView(
            controller: cubit.scrollController,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Name(),
                Phone(),
                Password(),
                PasswordConfirmation(),
                Email(),
                SizedBox(
                  height: Spacing.xLarge + Spacing.medium,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
