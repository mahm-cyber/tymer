import 'package:component_library/component_library.dart';
import 'package:form_fields/form_fields.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdditionalCommentsTextField extends StatefulWidget {
  const AdditionalCommentsTextField({
    super.key,
  });

  @override
  State<AdditionalCommentsTextField> createState() =>
      _AdditionalCommentsTextFieldState();
}

class _AdditionalCommentsTextFieldState
    extends State<AdditionalCommentsTextField> {
  final _additionalCommentsFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpAddressFieldFocusListener();
  }

  void _setUpAddressFieldFocusListener() {
    final cubit = context.read<RequestServiceCubit>();
    _additionalCommentsFocusNode.addListener(() {
      if (!_additionalCommentsFocusNode.hasFocus) {
        cubit.onAddressUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final cubit = context.read<RequestServiceCubit>();
        final l10n = RequestServiceLocalizations.of(context);
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final theme = TymerTheme.of(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
          child: TextField(
            enabled: !isSubmissionInProgress,
            focusNode: _additionalCommentsFocusNode,
            onChanged: cubit.onAdditionalCommentsChanged,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              helperText: '',
              labelText: l10n.additionalCommentsTextFieldLabel,
              hintText: l10n.additionalCommentsTextFieldLabel,
            ),
            maxLines: 4,
          ),
        );
      },
    );
  }
}
