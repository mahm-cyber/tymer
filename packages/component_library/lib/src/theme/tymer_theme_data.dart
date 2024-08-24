import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

// If the number of properties get too big, we can start grouping them in
// classes like Flutter does with TextTheme, ButtonTheme, etc, inside ThemeData.
abstract class TymerThemeData {
  ThemeData get materialThemeData;

  final iconColor = const Color(0xFF191F6D);
  final primaryColor = const Color(0xFF004746);
  final secondaryColor = const Color(0xFF5F45BF);
  final tertiaryColor = const Color(0xFFBA38F2);

  final dealLeadStageColor = const Color(0xFF5F45BF); // Lead
  final dealContactedStageColor = const Color(0xFF6D48B2); // Contacted
  final dealMeetingStageColor = const Color(0xFF7D4BA4); // Meeting
  final dealProposalStageColor = const Color(0xFFA25383); // Proposal
  final dealWonStageColor = const Color(0xFFBA586D); // Won
  final dealLostStageColor = const Color(0xFFD95E52); // Lost

  final successContainerColor = const Color(0xFFE3FFEC);
  final successOnContainerColor = const Color(0xFF19B100);
  final orderedVoucherUsedStatusTextColor = const Color(0xFF19B100);
  final switchActiveTrackColor = Colors.green;

  final errorColor = const Color(0xFFF56342);

  final switchActiveColor = Colors.white;
  final backButtonIconColor = Colors.white;
  final discountChipTextColor = Colors.white;
  final secondaryContainerBgColor = const Color(0xFFF2F4F7);
  final initialsBgColor = const Color(0xFFD9D9D9);
  final selectedBgColor = const Color(0xFFD0CDE0);
  final unselectedCheckboxBorderColor = const Color(0xFFD7D5DD);
  final borderColor = const Color(0xFFD8DADC);
  final xMarkColor = const Color(0xFFC3C3C3);
  final dimmedTextColor = const Color(0xFF5A5D66);
  final updatePhotoTextColor = const Color(0xFF7D7C7C);
  final secondaryIconColor = const Color(0xFF8B8B8B);
  final switchInactiveTrackColor = Colors.grey;
  final initialsTextColor = const Color(0xFFA2A0A7);

  final screenMargin = Spacing.mediumLarge;
  final listViewVerticalSpacing = Spacing.medium;
  final textFieldBorderRadius = 5.0;
  final searchTextFieldBorderRadius = 25.0;
  final double elevatedButtonBorderRadius = 5;

  final profileDescriptionTextShadow = Shadow(
    offset: const Offset(0, 4),
    blurRadius: 4,
    color: Colors.black.withOpacity(0.25),
  );

  final boxShadow = const [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15), // Shadow color with opacity
      offset: Offset(0, 3), // Horizontal and vertical offsets
      blurRadius: 3, // Blur radius
    ),
  ];

  final hintStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF3B2E8C).withOpacity(0.5),
  );
}

class LightTymerThemeData extends TymerThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.medium,
          ), // Rem
          minimumSize: const Size(50, 25),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        )),
        bottomSheetTheme: BottomSheetThemeData(
          dragHandleSize: const Size(200, 6),
          dragHandleColor: borderColor,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        useMaterial3: true,
        dividerTheme: DividerThemeData(
          color: borderColor,
          thickness: 1,
          indent: 0,
          space: 0,
        ),
        brightness: Brightness.light,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          tertiary: tertiaryColor,
          primaryContainer: const Color(0xFFF0EFF5),
          tertiaryContainer: const Color(0xFFF0EFF5),
          error: errorColor,
          errorContainer: const Color(0xFFFFF0ED),
        ),

        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ButtonStyle(
        //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //       RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(100.0),
        //       ),
        //     ),
        //   ),
        // ),
        tabBarTheme: const TabBarTheme(
          unselectedLabelColor: Color(0xFFC3C5C8),
          labelColor: Colors.white,
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(
            vertical: Spacing.xSmall,
            horizontal: Spacing.small,
          ),
          hintStyle: hintStyle,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(textFieldBorderRadius),
              borderSide: BorderSide(color: borderColor, width: 1)),
          suffixIconColor: secondaryIconColor,
          filled: true,
          // fillColor: textFieldFillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
            borderSide: BorderSide(color: primaryColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorColor),
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorColor),
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
      );
}

class DarkTymerThemeData extends TymerThemeData {
  @override
  ThemeData get materialThemeData => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
            primary: Colors.indigo, secondary: Colors.deepPurpleAccent),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.white.withOpacity(0.8),
          labelColor: Colors.white,
          dividerColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
      );
}
