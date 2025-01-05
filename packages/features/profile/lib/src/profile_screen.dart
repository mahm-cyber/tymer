import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/src/l10n/profile_localizations.dart';
import 'package:profile/src/profile_cubit.dart';

import 'package:user_repository/user_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    required this.userRepository,
    required this.onRequestServiceTapped,
    required this.onProvideServiceTapped,
    required this.onLogoutSuccess,
    required this.onChangePasswordTapped,
    required this.onChangePhoneTapped,
    required this.onChangeLanguageTapped,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onRequestServiceTapped;
  final VoidCallback onProvideServiceTapped;
  final VoidCallback onLogoutSuccess;
  final VoidCallback onChangePasswordTapped;
  final VoidCallback onChangePhoneTapped;
  final VoidCallback onChangeLanguageTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) => ProfileCubit(
        userRepository: userRepository,
        onRequestServiceTapped: onRequestServiceTapped,
        onProvideServiceTapped: onProvideServiceTapped,
        onLogoutSuccess: onLogoutSuccess,
        onChangePasswordTapped: onChangePasswordTapped,
        onChangePhoneTapped: onChangePhoneTapped,
        onChangeLanguageTapped: onChangeLanguageTapped,
      ),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final l10n = ProfileLocalizations.of(context);
    final cubit = context.read<ProfileCubit>();
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final logoutInProgress = state.logoutStatus == LogoutStatus.loading;
        return Scaffold(
          appBar: AppBar(
            title: const SvgAsset(AssetPathConstants.whiteLogoPath),
            toolbarHeight: 100,
          ),
          body: ListView(
            children: [
              // VerticalGap.large(),
              ListTile(
                titleTextStyle: textTheme.titleMedium,
                title: Text('👋 ${l10n.greetingTileTitle}'),
                subtitle: Text(state.user?.name ?? ''),
                tileColor: theme.borderColor.withAlpha((255*0.3).toInt()),
                // contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              // ListTile(
              //   leading: const SvgAsset(AssetPathConstants.profilePath),
              //   titleTextStyle: textTheme.titleMedium,
              //   title: Text(l10n.myProfileTileTitle),
              //   trailing: const Icon(Icons.arrow_forward_ios),
              //   subtitle: Text(state.user?.name ?? ''),
              //   tileColor: theme.borderColor,
              // ),
              // ListTile(
              //   leading: const SvgAsset(AssetPathConstants.settingsPath),
              //   titleTextStyle: textTheme.titleMedium,
              //   title: Text(l10n.settingsTileTitle),
              //   trailing: const Icon(Icons.arrow_forward_ios),
              //   tileColor: theme.borderColor,
              // ),
              // ListTile(
              //   leading: const SvgAsset(AssetPathConstants.bellPath),
              //   titleTextStyle: textTheme.titleMedium,
              //   title: Text(l10n.notificationsTileTitle),
              //   trailing: const Icon(Icons.arrow_forward_ios),
              //   tileColor: theme.borderColor,
              // ),
              // ListTile(
              //   leading: const SvgAsset(AssetPathConstants.infoCirclePath),
              //   titleTextStyle: textTheme.titleMedium,
              //   title: Text(l10n.infoTileTitle),
              //   trailing: const Icon(Icons.arrow_forward_ios),
              //   tileColor: theme.borderColor,
              // ),
              ListTile(
                leading: const SvgAsset(AssetPathConstants.twoSlidersPath),
                titleTextStyle: textTheme.titleMedium,
                title: Text(l10n.changePhoneTileTitle),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: cubit.onChangePhoneTapped,
              ),
              ListTile(
                leading: const SvgAsset(AssetPathConstants.shieldDonePath),
                titleTextStyle: textTheme.titleMedium,
                title: Text(l10n.changePasswordTileTitle),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: cubit.onChangePasswordTapped,
              ),
              ListTile(
                leading: const SvgAsset(AssetPathConstants.twoSlidersPath),
                titleTextStyle: textTheme.titleMedium,
                title: Text(l10n.changeLanguageTileTitle),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: cubit.onChangeLanguageTapped,
              ),
              ListTile(
                leading: logoutInProgress
                    ? Transform.scale(
                        scale: 0.5,
                        child: const CircularProgressIndicator(),
                      )
                    : const SvgAsset(AssetPathConstants.uploadPath),
                titleTextStyle: textTheme.titleMedium,
                title: Text(l10n.logoutTileTitle),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: logoutInProgress ? null : cubit.logout,
              ),
            ],
          ),
        );
      },
    );
  }
}
