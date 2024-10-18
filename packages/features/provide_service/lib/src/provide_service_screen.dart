import 'package:provide_service/provide_service.dart';
import 'package:provide_service/src/provide_service_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

class ProvideServiceScreen extends StatelessWidget {
  const ProvideServiceScreen({
    required this.userRepository,
    required this.serviceRepository,
    super.key,
  });

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProvideServiceCubit>(
      create: (_) => ProvideServiceCubit(
        userRepository: userRepository,
        serviceRepository: serviceRepository,
      ),
      child: const ProvideServiceView(),
    );
  }
}

class ProvideServiceView extends StatelessWidget {
  const ProvideServiceView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final l10n = ProvideServiceLocalizations.of(context);
    return BlocBuilder<ProvideServiceCubit, ProvideServiceState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: const SvgAsset(AssetPathConstants.whiteLogoPath),
                  toolbarHeight: 70,
                  iconTheme: IconThemeData(color: colorScheme.surface),
                ),
                body: const Text('provide service screen'),
              ),
              AppBarTitleContainer(
                top: 95,
                height: 30,
                title: l10n.otherServiceTypeAppBarTitle,
              ),
            ],
          ),
        );
      },
    );
  }
}
