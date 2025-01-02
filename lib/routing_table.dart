import 'package:accept_service_request/accept_service_request.dart';
import 'package:change_language/change_language.dart';
import 'package:change_password/change_password.dart';
import 'package:change_phone/change_phone.dart';
import 'package:chat/chat.dart';
import 'package:choose_service/choose_service.dart';
import 'package:confirm_dispute/confirm_dispute.dart';
import 'package:dispute_repository/dispute_repository.dart';
import 'package:disputes/disputes.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:forgot_password/forgot_password.dart';
import 'package:fulfill_service_request/fulfill_service_request.dart';
import 'package:home/home.dart';
import 'package:initial/initial.dart';
import 'package:notifications_service/notifications_service.dart';
import 'package:order_history/order_history.dart';
import 'package:profile/profile.dart';
import 'package:provide_service/provide_service.dart';
import 'package:request_service/request_service.dart';

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
  required DisputeRepository disputeRepository,
  required ValueNotifier<bool> signInSuccessVN,
  required ValueNotifier<bool> isUserUnAuthSC,
}) {
  disputeRepository.changeNotifier.addListener(() {
    debugPrint(
        'Current disputeChatUserType: ${disputeRepository.changeNotifier.disputeChatUserType}');
  });

  routerDelegate.addListener(
    //print current route
    () {
      debugPrint('Current route: ${routerDelegate.currentConfiguration?.path}');
    },
  );
  isUserUnAuthSC.addListener(() async {
    if (isUserUnAuthSC.value) {
      signInSuccessVN.value = false;
      routerDelegate.push(_PathConstants.signInPath);
    } else {
      signInSuccessVN.value = true;
    }
  });

  NotificationsService.instance.init(
    goToFulfillServiceScreen: (int requestId) async {
      // If the current route is fulfill service, pop the current route and push again
      final isFulfillService = routerDelegate.currentConfiguration?.path
              .contains('fulfill-service-request') ==
          true;
      if (isFulfillService) await routerDelegate.pop();

      routerDelegate.push(_PathConstants.fulfillServiceRequestPath(requestId: requestId));
    },
    goToRequestStatusScreen: (int requestId) async {
      // If the current route is service request status, pop the current route and push again
      final isServiceRequestStatus = routerDelegate.currentConfiguration?.path
              .contains('service-request-status') ==
          true;
      if (isServiceRequestStatus) await routerDelegate.pop();

      routerDelegate
          .push(_PathConstants.serviceRequestStatusPath(requestId: requestId));
    },
    goToRequesterDisputeChatScreen: (int disputeId) async {
      // If the current route is the dispute chat for requester, pop the current route and push again
      final isDisputeChat =
          routerDelegate.currentConfiguration?.path.contains('disputes/') ==
              true;
      if (isDisputeChat) {
        await routerDelegate.popUntil(
          (route) => route.path == _PathConstants.disputesPath,
        );
        // if set to less than 350, and the current screen is a chat screen,
        // it causes an error because the userchaytype in the changenotifier
        // doesnt get enough time to be able to change the user type
        disputeRepository.changeNotifier.clearCurrentDispute();
        await Future.delayed(const Duration(milliseconds: 350));
      }
      routerDelegate.push(_PathConstants.disputesPath);
      disputeRepository.changeNotifier.setDisputeChatUserType(
        UserType.requester,
      );
      routerDelegate.push(
        _PathConstants.disputeChatPath(disputeId: disputeId),
      ); // Then push to specific dispute chat
    },
    goToProviderDisputeChatScreen: (int disputeId) async {
      // If the current route is the dispute chat for provider, pop the current route and push again
      final isDisputeChat =
          routerDelegate.currentConfiguration?.path.contains('disputes/') ==
              true;
      if (isDisputeChat) {
        await routerDelegate.popUntil(
          (route) => route.path == _PathConstants.disputesPath,
        );
        // if set to less than 350, and the current screen is a chat screen,
        // it causes an error because the userchaytype in the changenotifier
        // doesnt get enough time to be able to change the user type
        await disputeRepository.changeNotifier.clearCurrentDispute();
        await Future.delayed(const Duration(milliseconds: 350));
      }

      routerDelegate.push(_PathConstants.disputesPath);
      disputeRepository.changeNotifier.setDisputeChatUserType(
        UserType.provider,
      );

      routerDelegate.push(
        _PathConstants.disputeChatPath(disputeId: disputeId),
      ); // Then push to specific dispute chat
    },
  );

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
            onBackButtonPressed: () => routerDelegate.popRoute(),
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
            serviceRepository: serviceRepository,
            onUnverifiedSignIn: () {
              routerDelegate.push(_PathConstants.verifyOtpPath);
            },
            onSignUpTapped: () {
              routerDelegate.push(_PathConstants.signUpPath);
            },
            onSignInSuccess: () async {
              await routerDelegate.popRoute();
              signInSuccessVN.value = true;
              routerDelegate.push(_PathConstants.homePath);
            },
            onForgotPasswordTapped: () {
              routerDelegate.push(_PathConstants.forgotPasswordPath);
            },
          ),
        ),
    _PathConstants.verifyOtpPath: (_) => MaterialPage(
          name: 'verify-otp',
          child: VerifyOtpScreen(
            userRepository: userRepository,
            onBackTapped: () {
              routerDelegate.popRoute();
            },
            onRegistrationVerifyOtpSuccess: () async {
              await routerDelegate.popRoute();
              signInSuccessVN.value = true;
              routerDelegate.push(_PathConstants.homePath);
            },
            onResetPasswordVerifyOtpSuccess: () async {
              await routerDelegate.popRoute();
              await routerDelegate.popRoute();
            },
            onChangePhoneVerifyOtpSuccess: () async {
              await routerDelegate.popRoute();
              await routerDelegate.popRoute();
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
          ),
        ),
    _PathConstants.disputesPath: (_) => MaterialPage(
          name: 'disputes',
          child: DisputesScreen(
            userRepository: userRepository,
            disputeRepository: disputeRepository,
            onDisputeTapped: (disputeId) {
              routerDelegate
                  .push(_PathConstants.disputeChatPath(disputeId: disputeId));
            },
          ),
        ),
    _PathConstants.disputeChatPath(): (info) {
      final disputeId = int.parse(
        info.pathParameters['disputeId'] ?? '',
      );
      return MaterialPage(
        name: 'chat',
        child: ChatScreen(
          userRepository: userRepository,
          disputeRepository: disputeRepository,
          disputeId: disputeId,
        ),
      );
    },
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
            onViewDisputesTapped: () =>
                routerDelegate.push(_PathConstants.disputesPath),
            onCheckServiceRequestStatusTapped: (requestId) =>
                routerDelegate.push(
              _PathConstants.serviceRequestStatusPath(requestId: requestId),
            ),
            navigateToFulfillServiceRequest: (int requestId) async {
              routerDelegate.push(_PathConstants.fulfillServiceRequestPath(requestId: requestId));
            },
          ),
        ),
    _PathConstants.profilePath: (_) => MaterialPage(
          name: 'profile',
          child: Builder(builder: (context) {
            return ProfileScreen(
              userRepository: userRepository,
              onRequestServiceTapped: () =>
                  routerDelegate.push(_PathConstants.chooseServicePath),
              onProvideServiceTapped: () =>
                  routerDelegate.push(_PathConstants.provideServicePath),
              onLogoutSuccess: () => signInSuccessVN.value = false,
              onChangePasswordTapped: () {
                routerDelegate.push(_PathConstants.changePasswordPath);
              },
              onChangePhoneTapped: () {
                routerDelegate.push(_PathConstants.changePhonePath);
              },
              onChangeLanguageTapped: () => showModalBottomSheet(
                useRootNavigator: false,
                context: context,
                builder: (_) => ChangeLanguageBottomSheet(
                  userRepository: userRepository,
                  onBackButtonPressed: () => routerDelegate.pop(),
                ),
              ),
            );
          }),
        ),
    _PathConstants.changePasswordPath: (_) => MaterialPage(
          name: 'change-password',
          child: ChangePasswordScreen(
            userRepository: userRepository,
            onChangePasswordSuccess: () {
              routerDelegate.pop();
            },
          ),
        ),
    _PathConstants.changePhonePath: (_) => MaterialPage(
          name: 'change-phone',
          child: ChangePhoneScreen(
            userRepository: userRepository,
            onOtpSentSuccess: () {
              routerDelegate.push(_PathConstants.verifyOtpPath);
            },
          ),
        ),
    _PathConstants.forgotPasswordPath: (_) => MaterialPage(
          name: 'forgot-password',
          child: ForgotPasswordScreen(
            userRepository: userRepository,
            onForgotPasswordSuccess: () {
              routerDelegate.push(_PathConstants.verifyOtpPath);
            },
            onBackTapped: () {
              routerDelegate.popRoute();
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
    _PathConstants.requestServicePath: (_) => MaterialPage(
          name: 'request-service',
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
            onBackButtonPressed: routerDelegate.pop,
          ),
        ),
    _PathConstants.serviceRequestStatusPath(): (info) {
      final requestId = int.parse(
        info.pathParameters['requestId'] ?? '',
      );
      return MaterialPage(
        name: 'service-request-status',
        child: Builder(builder: (context) {
          return ServiceRequestStatusScreen(
            userRepository: userRepository,
            serviceRepository: serviceRepository,
            goBackHome: () async {
              await routerDelegate.pop();
            },
            requestId: requestId,
            onConfirmDisputeTapped: (Service service) {
              showModalBottomSheet(
                useRootNavigator: false,
                isDismissible: false,
                useSafeArea: true,
                context: context,
                builder: (context) {
                  return ConfirmDisputeBottomSheet(
                    disputeRepository: disputeRepository,
                    service: service,
                    onDisputeSuccess: (int disputeId) async {
                      await routerDelegate.popUntil(
                        (route) => route.path == _PathConstants.homePath,
                      );
                      routerDelegate.push(_PathConstants.orderHistory);
                      routerDelegate.push(_PathConstants.disputesPath);
                      routerDelegate.push(_PathConstants.disputeChatPath(
                        disputeId: disputeId,
                      ));
                    },
                  );
                },
              );
            },
          );
        }),
      );
    },
    _PathConstants.provideServicePath: (_) => MaterialPage(
          name: 'provide-service',
          child: ProvideServiceScreen(
            userRepository: userRepository,
            serviceRepository: serviceRepository,
            onServiceRequestDetailsTapped: () => routerDelegate
                .push(_PathConstants.acceptServiceRequestDetailsPath),
            navigateToFulfillServiceRequest: (int requestId) async {
              await routerDelegate.popRoute();
              routerDelegate.push(_PathConstants.fulfillServiceRequestPath(requestId: requestId));
            },
            popTillHome: () async {
              await routerDelegate.popUntil(
                (route) => route.path == _PathConstants.homePath,
              );
            },
          ),
        ),
    _PathConstants.acceptServiceRequestDetailsPath: (_) => MaterialPage(
          name: 'accept-service-request',
          child: AcceptServiceRequestScreen(
            serviceRepository: serviceRepository,
            userRepository: userRepository,
            onAcceptServiceRequestSuccess: (int requestId) async {
              await routerDelegate.popRoute();
              await routerDelegate.popRoute();
              routerDelegate.push(_PathConstants.fulfillServiceRequestPath(requestId: requestId));
            },
          ),
        ),
    _PathConstants.fulfillServiceRequestPath(): (info) {
      final requestId = int.parse(
        info.pathParameters['requestId'] ?? '',
      );
      return MaterialPage(
        name: 'fulfill-service-request',
        child: FulfillServiceRequestScreen(
          requestId: requestId,
          disputeRepository: disputeRepository,
          serviceRepository: serviceRepository,
          userRepository: userRepository,
          onNavigateToProvideService: () async {
            await routerDelegate
                .popUntil((route) => route.path == _PathConstants.homePath);
            routerDelegate.push(_PathConstants.provideServicePath);
          },
          onServiceDisputed: (int disputeId) async {
            await routerDelegate.popUntil(
              (route) => route.path == _PathConstants.homePath,
            );
            routerDelegate.push(_PathConstants.orderHistory);
            routerDelegate.push(_PathConstants.disputesPath);
            routerDelegate.push(_PathConstants.disputeChatPath(
              disputeId: disputeId,
            ));
          },
          onBackButtonPressed: routerDelegate.pop,
        ),
      );
    },
  };
}

class _PathConstants {
  const _PathConstants._();

  static String get initialPath => '/';

  static String get signUpPath => '${initialPath}sign-up';

  static String get signInPath => '${initialPath}sign-in';

  static String get homePath => '${initialPath}home';

  static String get disputesPath => '${initialPath}disputes';

  static String disputeChatPath({int? disputeId}) =>
      '$disputesPath/${disputeId ?? ':disputeId'}';

  static String get walletPath => '${initialPath}wallet';

  static String get orderHistory => '${initialPath}order-history';

  static String get profilePath => '${initialPath}profile';

  static String get changePasswordPath => '${initialPath}change-password';

  static String get changePhonePath => '${initialPath}change-phone';

  static String get verifyOtpPath => '${initialPath}verify-otp';

  static String get forgotPasswordPath => '${initialPath}forgot-password';

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


  static String  fulfillServiceRequestPath({int? requestId}) =>
      '${initialPath}fulfill-service-request/${requestId ?? ':requestId'}';
}
