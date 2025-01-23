import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:top_up/src/top_up_cubit.dart';

class TopUpAmountInputField extends StatefulWidget {
  const TopUpAmountInputField({
    super.key,
  });

  @override
  State<TopUpAmountInputField> createState() => _TopUpAmountInputFieldState();
}

class _TopUpAmountInputFieldState extends State<TopUpAmountInputField> {
  final _topUpAmountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpTopUpAmountFieldFocusListener();
  }

  void _setUpTopUpAmountFieldFocusListener() {
    final cubit = context.read<TopUpCubit>();
    _topUpAmountFocusNode.addListener(() {
      if (!_topUpAmountFocusNode.hasFocus) {
        cubit.onTopUpAmountUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpCubit, TopUpState>(builder: (context, state) {
      final cubit = context.read<TopUpCubit>();
      final isArabic = Localizations.localeOf(context).languageCode == 'ar';
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      final clL10n = ComponentLibraryLocalizations.of(context);
      final textTheme = Theme.of(context).textTheme;
      final theme = TymerTheme.of(context);
      return GestureDetector(
        onTap: _topUpAmountFocusNode.hasFocus
            ? context.releaseFocus
            : _topUpAmountFocusNode.requestFocus,
        child: Container(
          padding: const EdgeInsets.only(
            top: Spacing.xxLarge,
            bottom: Spacing.xLarge,
            right: Spacing.xxLarge,
            left: Spacing.xxLarge,
          ),
          margin: const EdgeInsets.symmetric(horizontal: Spacing.large),
          decoration: BoxDecoration(
            color: theme.tertiaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: isArabic ? Spacing.medium : Spacing.medium + 4,
                ),
                child: Transform.scale(
                  scale: 1.5,
                  child: const SvgAsset(
                    AssetPathConstants.bankNotePath,
                  ),
                ),
              ),
              HorizontalGap.large(),
              SizedBox(
                width: 50,
                child: TextFormField(
                  enableInteractiveSelection: false,
                  enabled: !isSubmissionInProgress,
                  focusNode: _topUpAmountFocusNode,
                  onChanged: cubit.onTopUpAmountChanged,
                  keyboardType: TextInputType.number,
                  style: textTheme.titleLarge?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    fillColor: theme.tertiaryColor,

                    isDense: true,
                    helperText: '',

                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      // horizontal: Spacing.medium,
                    ),
                    border: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    // labelText: l10n.topUpAmountTextFieldLabel,
                    hintText: '00.0',
                    // errorText: topUpAmountError == DynamicValidationError.empty
                    //     ? clL10n.requiredFieldErrorMessage
                    //     : topUpAmountError == DynamicValidationError.isNotNumber
                    //         ? l10n.isNotNumberTextFieldErrorMessage
                    //         : null,
                  ),
                ),
              ),
              HorizontalGap.xSmall(),
              Padding(
                padding:  EdgeInsets.only(
                  top: isArabic? Spacing.small:Spacing.medium + Spacing.xxSmall,
                ),
                child: Text(
                  clL10n.eyptianPoundLetters,
                  style: textTheme.titleMedium?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
