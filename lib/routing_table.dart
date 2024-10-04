import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:initial/initial.dart';

import 'package:routemaster/routemaster.dart';
import 'package:sign_in/sign_in.dart';
import 'package:sign_up/sign_up.dart';
import 'package:tab_container/tab_container.dart';
import 'package:user_repository/user_repository.dart';
import 'package:verify_otp/verify_otp.dart';

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required UserRepository userRepository,
  required ValueNotifier<bool> signInSuccessVN,
}) {
  routerDelegate.addListener(
    //print current route
    () {
      debugPrint('Current route: ${routerDelegate.currentConfiguration?.path}');
    },
  );
  return {
    _PathConstants.initialPath: (_) => TabPage(
          backBehavior: TabBackBehavior.history,
          paths: [
            _PathConstants.homePath,
            _PathConstants.homePath,
            _PathConstants.homePath,
            _PathConstants.homePath,
            _PathConstants.homePath,
          ],
          child: BackButtonListener(
            onBackButtonPressed: () async {
              return routerDelegate.history.canGoBack ? false : true;
            },
            child: ValueListenableBuilder(
              valueListenable: signInSuccessVN,
              builder: (context, shouldPassInitialAuthentication, __) {
                return shouldPassInitialAuthentication
                    ? const TabContainerScreen()
                    : InitialScreen(
                        userRepository: userRepository,
                        onSignInTap: () =>
                            routerDelegate.push(_PathConstants.signInPath),
                        onSignUpTap: () =>
                            routerDelegate.push(_PathConstants.signUpPath),
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
              routerDelegate.push(_PathConstants.verifyOtpPath);
            },
          ),
        ),
    _PathConstants.signInPath: (_) => MaterialPage(
          name: 'sign-in',
          child: SignInScreen(
            userRepository: userRepository,
            onUnverifiedSignIn: () {
              routerDelegate.push(_PathConstants.verifyOtpPath);
            },
            onSignUpTapped: () {
              routerDelegate.push(_PathConstants.signUpPath);
            },
            onSignInSuccess: () async {
              await routerDelegate.popRoute();
              signInSuccessVN.value = true;
            },
          ),
        ),
    _PathConstants.verifyOtpPath: (_) => MaterialPage(
          name: 'verify-otp',
          child: VerifyOtpScreen(
            userRepository: userRepository,
            onVerifyOtpSuccess: () async {
              await routerDelegate.popRoute();
              signInSuccessVN.value = true;
            },
          ),
        ),
    _PathConstants.homePath: (_) => MaterialPage(
          name: 'home',
          child: HomeScreen(
            userRepository: userRepository,
            onLogout: () => signInSuccessVN.value = false,
          ),
        ),

  };
}

class _PathConstants {
  const _PathConstants._();

  static String get initialPath => '/';

  static String get signUpPath => '${initialPath}sign-up';

  static String get signInPath => '${initialPath}sign-in';

  static String get homePath => '${initialPath}home';

  static String get verifyOtpPath => '${initialPath}verify-otp';

  static String get forgotPasswordPath => '${initialPath}forgot-password';

  static String get resetPasswordPath => '${initialPath}reset-password';
}
