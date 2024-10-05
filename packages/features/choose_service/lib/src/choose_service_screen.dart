import 'package:choose_service/src/choose_service_cubit.dart';
import 'package:choose_service/src/l10n/choose_service_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

class ChooseServiceScreen extends StatelessWidget {
  const ChooseServiceScreen({
    required this.userRepository,
    required this.serviceRepository,
    required this.onRequestServiceTapped,
    super.key,
  });

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final VoidCallback onRequestServiceTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseServiceCubit>(
      create: (_) => ChooseServiceCubit(
        userRepository: userRepository,
        serviceRepository: serviceRepository,
        onRequestServiceTapped: onRequestServiceTapped,
      ),
      child: ChooseServiceView(),
    );
  }
}

class ChooseServiceView extends StatelessWidget {
  const ChooseServiceView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final l10n = ChooseServiceLocalizations.of(context);
    final cubit = context.read<ChooseServiceCubit>();
    final colorScheme = theme.materialThemeData.colorScheme;
    return GestureDetector(
      onTap: context.releaseFocus,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: SvgAsset(AssetPathConstants.whiteLogoPath),
              toolbarHeight: 160,
              iconTheme: IconThemeData(color: colorScheme.surface),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.screenMargin * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TymerGestureContainer(
                    onTap: () => cubit.setServiceType(ServiceType.reservation),
                    icon: Icon(Icons.arrow_forward),
                    title: l10n.skipWaitingListContainerTitle,
                  ),
                  VerticalGap.xxLarge(),
                  TymerGestureContainer(
                    onTap: () => cubit.setServiceType(ServiceType.other),
                    icon: SvgAsset(
                      AssetPathConstants.potPath,
                      color: theme.materialThemeData.colorScheme.onSurface,
                    ),
                    title: l10n.otherRequestContainerTitle,
                    subtitle: l10n.otherRequestContainerSubtitle,
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     context.read<ChooseServiceCubit>().userRepository.logout();
                  //     cubit.onLogout();
                  //   },
                  //   child: const Text('logout'),
                  // ),
                ],
              ),
            ),
          ),
          AppBarTitleContainer(
            title: l10n.appBarTitle,
            icon: SvgAsset(
              AssetPathConstants.potPath,
            ),
          ),
        ],
      ),
    );
  }
}
