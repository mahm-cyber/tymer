import 'package:accept_service_request/accept_service_request.dart';
import 'package:choose_service/choose_service.dart';
import 'package:disputes/disputes.dart';
import 'package:flutter/material.dart';
import 'package:forgot_password/forgot_password.dart';
import 'package:fulfill_service_request/fulfill_service_request.dart';
import 'package:home/home.dart';
import 'package:initial/initial.dart';
import 'package:order_history/order_history.dart';
import 'package:profile/profile.dart';
import 'package:provide_service/provide_service.dart';
import 'package:request_service/request_service.dart';
import 'package:reset_password/reset_password.dart';

import 'package:routemaster/routemaster.dart';
import 'package:service_repository/service_repository.dart';
import 'package:service_request_status/service_request_status.dart';
import 'package:sign_in/sign_in.dart';
import 'package:sign_up/sign_up.dart';
import 'package:tab_container/tab_container.dart';
import 'package:user_repository/user_repository.dart';
import 'package:verify_otp/verify_otp.dart';
import 'package:wallet/wallet.dart';

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required UserRepository userRepository,
  required ServiceRepository serviceRepository,
  required ValueNotifier<bool> signInSuccessVN,
  required ValueNotifier<bool> isUserUnAuthSC,
}) {
  routerDelegate.addListener(
    //print current route
    () {
      debugPrint('Current route: ${routerDelegate.currentConfiguration?.path}');
    },
  );
  isUserUnAuthSC.addListener(() {
    if (isUserUnAuthSC.value) {
      signInSuccessVN.value = false;
      routerDelegate.push(_PathConstants.signInPath);
    }
  });
  return {
    _PathConstants.initialPath: (_) => TabPage(
          backBehavior: TabBackBehavior.history,
          paths: [
            _PathConstants.homePath,
            _PathConstants.walletPath,
            _PathConstants.orderHistory,
            _PathConstants.profilePath,
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
            onRequestServiceTapped: () =>
                routerDelegate.push(_PathConstants.chooseServicePath),
            onProvideServiceTapped: () =>
                routerDelegate.push(_PathConstants.provideServicePath),
            onViewDisputesTapped: () =>
                routerDelegate.push(_PathConstants.disputesPath),
          ),
        ),
    _PathConstants.disputesPath: (_) => MaterialPage(
          name: 'disputes',
          child: DisputesScreen(
            userRepository: userRepository,
            serviceRepository: serviceRepository,
            onDisputeTapped: (disputeId) {
              routerDelegate.push(_PathConstants.disputesPath);
            },
          ),
        ),
    _PathConstants.walletPath: (_) => MaterialPage(
          name: 'wallet',
          child: WalletScreen(
            userRepository: userRepository,
            onRequestServiceTapped: () =>
                routerDelegate.push(_PathConstants.chooseServicePath),
            onProvideServiceTapped: () {},
          ),
        ),
    _PathConstants.orderHistory: (_) => MaterialPage(
          name: 'order-history',
          child: OrderHistoryScreen(
            userRepository: userRepository,
            serviceRepository: serviceRepository,
            onCheckServiceRequestStatusTapped: (requestId) =>
                routerDelegate.push(
              _PathConstants.serviceRequestStatusPath(requestId: requestId),
            ),
          ),
        ),
    _PathConstants.profilePath: (_) => MaterialPage(
          name: 'profile',
          child: ProfileScreen(
            userRepository: userRepository,
            onRequestServiceTapped: () =>
                routerDelegate.push(_PathConstants.chooseServicePath),
            onProvideServiceTapped: () =>
                routerDelegate.push(_PathConstants.provideServicePath),
            onLogout: () => signInSuccessVN.value = false,
          ),
        ),
    _PathConstants.forgotPasswordPath: (_) => MaterialPage(
          name: 'forgot-password',
          child: ForgotPasswordScreen(
            userRepository: userRepository,
            onForgotPasswordSuccess: () {
              routerDelegate.push(_PathConstants.resetPasswordPath);
            },
          ),
        ),
    _PathConstants.chooseServicePath: (_) => MaterialPage(
          name: 'choose-service',
          child: ChooseServiceScreen(
            userRepository: userRepository,
            serviceRepository: serviceRepository,
            onRequestServiceTapped: () =>
                routerDelegate.push(_PathConstants.requestServicePath),
          ),
        ),
    _PathConstants.resetPasswordPath: (_) => MaterialPage(
          name: 'reset-password',
          child: ResetPasswordScreen(
            userRepository: userRepository,
            onBackTapped: () => routerDelegate.popRoute(),
            onResetPasswordSuccess: () => routerDelegate.popRoute(),
          ),
        ),
    _PathConstants.requestServicePath: (_) => MaterialPage(
          name: 'request',
          child: RequestServiceScreen(
            userRepository: userRepository,
            serviceRepository: serviceRepository,
            onGoToWalletTapped: () =>
                routerDelegate.push(_PathConstants.walletPath),
            onServiceRequestSuccess: (int requestId) async {
              await routerDelegate.popRoute();
              routerDelegate.push(
                _PathConstants.serviceRequestStatusPath(requestId: requestId),
              );
            },
          ),
        ),
    _PathConstants.serviceRequestStatusPath(): (info) {
      final requestId = int.parse(
        info.pathParameters['requestId'] ?? '',
      );
      return MaterialPage(
        name: 'service-request-status',
        child: ServiceRequestStatusScreen(
          userRepository: userRepository,
          serviceRepository: serviceRepository,
          goBackHome: () async {
            await routerDelegate.pop();
          },
          requestId: requestId,
        ),
      );
    },
    _PathConstants.provideServicePath: (_) => MaterialPage(
          name: 'provide-service',
          child: ProvideServiceScreen(
            userRepository: userRepository,
            serviceRepository: serviceRepository,
            onServiceRequestDetailsTapped: () => routerDelegate
                .push(_PathConstants.acceptServiceRequestDetailsPath),
            navigateToFulfillServiceRequest: () async {
              await routerDelegate.popRoute();
              routerDelegate.push(_PathConstants.fulfillServiceRequestPath);
            },
          ),
        ),
    _PathConstants.acceptServiceRequestDetailsPath: (_) => MaterialPage(
          name: 'accept-service-request-details',
          child: AcceptServiceRequestScreen(
            serviceRepository: serviceRepository,
            onAcceptServiceRequestSuccess: () async {
              await routerDelegate.popRoute();
              await routerDelegate.popRoute();
              routerDelegate.push(_PathConstants.fulfillServiceRequestPath);
            },
          ),
        ),
    _PathConstants.fulfillServiceRequestPath: (_) => MaterialPage(
          name: 'fulfill-service-request',
          child: FulfillServiceRequestScreen(
            serviceRepository: serviceRepository,
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

  static String get disputesPath => '${initialPath}disputes';

  static String get walletPath => '${initialPath}wallet';

  static String get orderHistory => '${initialPath}order-history';

  static String get profilePath => '${initialPath}profile';

  static String get verifyOtpPath => '${initialPath}verify-otp';

  static String get forgotPasswordPath => '${initialPath}forgot-password';

  static String get resetPasswordPath => '${initialPath}reset-password';

  static String get chooseServicePath => '$homePath/choose-service';

  static String get requestServicePath => '$chooseServicePath/request';

  // static String filesPath({int? folderId}) {
  //   final completePath = '${tabContainerPath}folder/${folderId ?? ':folderId'}';
  //   return completePath;
  // }

  static String serviceRequestStatusPath({int? requestId}) =>
      '${initialPath}service-request-status/${requestId ?? ':requestId'}';

  static String get provideServicePath =>
      '${initialPath}provide-service/list-view';

  static String get acceptServiceRequestDetailsPath =>
      '$provideServicePath/accept-service-request';

  static String get fulfillServiceRequestPath =>
      '${initialPath}fulfill-service-request';
}
