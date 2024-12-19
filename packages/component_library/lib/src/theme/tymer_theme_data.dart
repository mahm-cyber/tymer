import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

// If the number of properties get too big, we can start grouping them in
// classes like Flutter does with TextTheme, ButtonTheme, etc, inside ThemeData.
abstract class TymerThemeData {
  ThemeData get materialThemeData;

  final iconColor = const Color(0xFF2C8268);
  final primaryColor = const Color(0xFF2C8268);
  final secondaryColor = const Color(0xFF2C8268);
  final tertiaryColor = const Color(0xFFD9EDDE);

  final successContainerColor = const Color(0xFFE3FFEC);
  final successOnContainerColor = const Color(0xFF19B100);
  final orderedVoucherUsedStatusTextColor = const Color(0xFF19B100);
  final switchActiveTrackColor = Colors.green;

  final errorColor = const Color(0xFFF56342);

  final switchActiveColor = Colors.white;
  final backButtonIconColor = Colors.white;
  final secondaryContainerBgColor = const Color(0xFFF2F4F7);
  final borderColor = const Color(0xFFD0D0D0);
  final dimmedTextColor = const Color(0xFF5A5D66);
  final secondaryIconColor = const Color(0xFF8B8B8B);
  final switchInactiveTrackColor = const Color(0xFFDCE0E1);
  final initialsTextColor = const Color(0xFFA2A0A7);

  final screenMargin = Spacing.mediumLarge;
  final listViewVerticalSpacing = Spacing.medium;
  final textFieldBorderRadius = 10.0;
  final searchTextFieldBorderRadius = 25.0;
  final double elevatedButtonBorderRadius = 10;

  final profileDescriptionTextShadow = Shadow(
    offset: const Offset(0, 4),
    blurRadius: 4,
    color: Colors.black.withAlpha((255 * 0.25).toInt()),
  );

  final snackBarMargin = const EdgeInsets.only(bottom: 70, left: 15, right: 15);

  final double smallAppBarTitleContainerHeight = 55;
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
        hintColor: const Color(0xFF6C6C6C),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(
            vertical: Spacing.mediumLarge,
            horizontal: Spacing.medium,
          ),
          labelStyle: TextStyle(
            color: const Color(0xFF6C6C6C).withAlpha((255 * 0.5).toInt()),
          ),
          hintStyle: TextStyle(
            color: const Color(0xFF6C6C6C).withAlpha((255 * 0.6).toInt()),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          suffixIconColor: secondaryIconColor,
          filled: true,
          // fillColor: textFieldFillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
            borderSide: BorderSide(color: borderColor),
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
          unselectedLabelColor: Colors.white.withAlpha((255 * 0.8).toInt()),
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
