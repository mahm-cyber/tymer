import 'package:request_service/src/request_service_cubit.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

import 'package:user_repository/user_repository.dart';

class RequestServiceScreen extends StatelessWidget {
  const RequestServiceScreen({
    required this.userRepository,
    required this.onLogout,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestServiceCubit>(
      create: (_) => RequestServiceCubit(
        userRepository: userRepository,
        onLogout: onLogout,
      ),
      child: RequestServiceView(),
    );
  }
}

class RequestServiceView extends StatelessWidget {
  const RequestServiceView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final l10n = RequestServiceLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: context.releaseFocus,
      child: Stack(
        children: [
          Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Transform.scale(
                  scale: 0.7,
                  child: SvgAsset(
                    AssetPathConstants.chatPath,
                    width: 50,
                    height: 50,
                  )),
            ),
            appBar: AppBar(
              title: SvgAsset(AssetPathConstants.whiteLogoPath),
              toolbarHeight: 160,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.screenMargin * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TymerGestureContainer(
                    onTap: () {},
                    icon: SvgAsset(AssetPathConstants.potPath),
                    title: l10n.skipWaitingListContainerTitle,
                  ),
                  VerticalGap.xxLarge(),
                  TymerGestureContainer(
                    onTap: () {},
                    icon: SvgAsset(
                      AssetPathConstants.potPath,
                      color: theme.materialThemeData.colorScheme.onSurface,
                    ),
                    title: l10n.otherRequestContainerTitle,
                    subtitle: l10n.otherRequestContainerSubtitle,
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     context.read<RequestServiceCubit>().userRepository.logout();
                  //     cubit.onLogout();
                  //   },
                  //   child: const Text('logout'),
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 170,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: theme.screenMargin * 2),
              decoration: BoxDecoration(
                color: theme.materialThemeData.colorScheme.surface,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: kElevationToShadow[1],
              ),
              child: Row(
                children: [
                  Text(
                    l10n.appBarTitle,
                    style: textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  HorizontalGap.medium(),
                  SvgAsset(
                    AssetPathConstants.potPath,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
