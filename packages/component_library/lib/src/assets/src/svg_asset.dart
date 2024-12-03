import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgAsset extends StatelessWidget {
  const SvgAsset(
    this.assetPath, {
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.scaleDown,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    // final theme = GrowthInkTheme.of(context);

    return SvgPicture.asset(
      width: width,
      height: height,
      assetPath,
      fit: fit ?? BoxFit.scaleDown,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            ),
    );
  }
}

class AssetPathConstants {
  const AssetPathConstants._();

  static const String assetsPath = 'assets';
  static const String iconsPath = '$assetsPath/icons';
  static const String tabContainerIconsPath = '$iconsPath/tab_container';
  static const String logoPath = '$iconsPath/logo.svg';

  // Tab container icons
  static const String documentSelectedPath =
      '$tabContainerIconsPath/document_selected.svg';
  static const String documentUnselectedPath =
      '$tabContainerIconsPath/document_unselected.svg';
  static const String profileSelectedPath =
      '$tabContainerIconsPath/profile_selected.svg';
  static const String profileUnselectedPath =
      '$tabContainerIconsPath/profile_unselected.svg';
  static const String searchSelectedPath =
      '$tabContainerIconsPath/search_selected.svg';
  static const String searchUnselectedPath =
      '$tabContainerIconsPath/search_unselected.svg';
  static const String walletSelectedPath =
      '$tabContainerIconsPath/wallet_selected.svg';
  static const String walletUnselectedPath =
      '$tabContainerIconsPath/wallet_unselected.svg';
  static const String homeSelectedPath =
      '$tabContainerIconsPath/home_selected.svg';
  static const String homeUnselectedPath =
      '$tabContainerIconsPath/home_unselected.svg';

  static const String logoAndWordPath = '$assetsPath/logo_and_word.svg';

  //social media
  static const String facebookPath = '$iconsPath/facebook.svg';
  static const String googlePath = '$iconsPath/google.svg';
  static const String applePath = '$iconsPath/apple.svg';

  static const String emailPath = '$iconsPath/email.svg';
  static const String lockPath = '$iconsPath/lock.svg';
  static const String mobilePath = '$iconsPath/mobile.svg';
  static const String personPath = '$iconsPath/person.svg';
  static const String whiteLogoPath = '$iconsPath/white_logo.svg';
  static const String potPath = '$iconsPath/pot.svg';
  static const String footPrintsPath = '$iconsPath/foot_prints.svg';
  static const String arrowRightSquarePath = '$iconsPath/arrow_right_square.svg';
  static const String chatPath = '$iconsPath/chat.svg';
  static const String tickSquarePath = '$iconsPath/tick_square.svg';
  static const String footPrintFilledPath = '$iconsPath/foot_print_filled.svg';
  static const String bankNotePath = '$iconsPath/bank_note.svg';
  static const String locationPath = '$iconsPath/location.svg';
  static const String calendarPath = '$iconsPath/calendar.svg';
  static const String bankNoteBlackPath = '$iconsPath/bank_note_black.svg';
  static const String numberPath = '$iconsPath/number.svg';
  static const String streetSignPath = '$iconsPath/street_sign.svg';
  static const String personBlackPath = '$iconsPath/person_black.svg';

  static const String profilePath = '$iconsPath/profile.svg';
  static const String settingsPath = '$iconsPath/settings.svg';
  static const String bellPath = '$iconsPath/bell.svg';
  static const String infoCirclePath = '$iconsPath/info_circle.svg';
  static const String twoSlidersPath = '$iconsPath/two_sliders.svg';
  static const String uploadPath = '$iconsPath/upload.svg';

  static const String whiteBankNote = '$iconsPath/bank_note_white.svg';
  static const String arrowTowardsBox = '$iconsPath/arrow_towards_box.svg';


}
