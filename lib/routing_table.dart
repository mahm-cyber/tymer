import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:reset_password/reset_password.dart';

import 'package:routemaster/routemaster.dart';
import 'package:send_otp/send_otp.dart';
import 'package:sign_in/sign_in.dart';
import 'package:tab_container/tab_container.dart';
import 'package:user_repository/user_repository.dart';
import 'package:verify_otp/verify_otp.dart';

// Set to true if the user signs in as a guest, signs in normally or signs up
final ValueNotifier<bool> _shouldPassInitialAuthentication =
    ValueNotifier(false);

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required UserRepository userRepository,
  required ValueNotifier<bool> signInSuccessVN,
}) {
  return {
    _PathConstants.initialPath: (_) => TabPage(
      backBehavior: TabBackBehavior.history,
      paths: [
        _PathConstants.homePath,
        _PathConstants.homePath,
      ],
      child: BackButtonListener(
        onBackButtonPressed: () async {
          return routerDelegate.history.canGoBack ? false : true;
        },
        child: ValueListenableBuilder(
          valueListenable: _shouldPassInitialAuthentication,
          builder: (context, shouldPassInitialAuthentication, __) {
            return shouldPassInitialAuthentication
                ? const TabContainerScreen()
                : InitialScreen(
              userRepository: userRepository,
              onSignInTap: () =>
                  routerDelegate.push(_PathConstants.signInPath),
              onSignUpTap: () =>
                  routerDelegate.push(_PathConstants.signUpPath),
              onGuestSignInTap: () =>
              _shouldPassInitialAuthentication.value = true,
            );
          },
        ),
      ),
    ),
    _PathConstants.signUpPath: (_) => MaterialPage(
      name: 'sign-up',
      child: SignUpScreen(
        userRepository: userRepository,
        onSignInTap: () => routerDelegate
            .popRoute()
            .then((_) => routerDelegate.push(_PathConstants.signInPath)),
        onSignUpSuccess: () async {
          await routerDelegate.popRoute();
          if (routerDelegate.history.canGoBack) {
            await routerDelegate.popRoute();
          }
          routerDelegate.push(_PathConstants.verifyOtpPath);
        },
      ),
    ),

    _PathConstants.homePath: (_) => const MaterialPage(
          name: 'home',
          child: HomeScreen(),
        ),

    _PathConstants.resetPasswordPath: (_) => MaterialPage(
          name: 'reset-password',
          child: ResetPasswordScreen(
            userRepository: userRepository,
            onResetPasswordSuccess: () async {
              await routerDelegate.popRoute();
              routerDelegate.popRoute();
            },
            onBackTapped: routerDelegate.popRoute,
          ),
        ),
    _PathConstants.sendOtpPath: (_) => MaterialPage(
          name: 'send-otp',
          child: SendOtpScreen(
            userRepository: userRepository,
            onSendOtpSuccess: () async {
              await routerDelegate.popRoute();
              routerDelegate.push(_PathConstants.verifyOtpPath);
            },
          ),
        ),
    _PathConstants.verifyOtpPath: (_) => MaterialPage(
          name: 'verify-otp',
          child: VerifyOtpScreen(
            userRepository: userRepository,
            onVerifyOtpSuccess: () async {
              await routerDelegate.popRoute();
              final otpVerification =
                  userRepository.changeNotifier.otpVerification!;
              if (otpVerification.isRegistrationOrLogin) {
                _shouldPassInitialAuthentication.value = true;
              } else {
                routerDelegate.push(_PathConstants.resetPasswordPath);
              }
            },
            otpVerification: userRepository.changeNotifier.otpVerification!,
          ),
        ),
    // Task paths
  };
}

class _PathConstants {
  const _PathConstants._();

  static String get tabContainerPath => '/';

  static String get homePath => '${tabContainerPath}home';

  static String get sendOtpPath => '${tabContainerPath}send-otp';

  static String get verifyOtpPath => '${tabContainerPath}verify-otp';

  static String get resetPasswordPath => '${tabContainerPath}reset-password';
}
