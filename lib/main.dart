import 'dart:io';
import 'dart:ui';
import 'package:accept_service_request/accept_service_request.dart';
import 'package:change_language/change_language.dart';
import 'package:change_password/change_password.dart';
import 'package:change_phone/change_phone.dart';
import 'package:delete_account/delete_account.dart';
import 'package:dio/dio.dart';
import 'package:dispute_chat/dispute_chat.dart';
import 'package:choose_service/choose_service.dart';
import 'package:choose_top_up_method/choose_top_up_method.dart';
import 'package:choose_withdraw_method/choose_withdraw_method.dart';
import 'package:component_library/component_library.dart';
import 'package:confirm_dispute/confirm_dispute.dart';
import 'package:dispute_repository/dispute_repository.dart';
import 'package:disputes/disputes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forgot_password/forgot_password.dart';
import 'package:fulfill_service_request/fulfill_service_request.dart';
import 'package:home/home.dart';
import 'package:initial/initial.dart';

import 'package:key_value_storage/key_value_storage.dart';
import 'package:monitoring/monitoring.dart';
import 'package:online_payment/online_payment.dart';
import 'package:order_history/order_history.dart';
import 'package:payment_history/payment_history.dart';
import 'package:profile/profile.dart';
import 'package:provide_service/provide_service.dart';
import 'package:request_service/request_service.dart';
import 'package:service_repository/service_repository.dart';
import 'package:service_request_status/service_request_status.dart';
import 'package:sign_up/sign_up.dart';
import 'package:support_chat/support_chat.dart';
import 'package:support_repository/support_repository.dart';
import 'package:top_up_confirmation/top_up_confirmation.dart';
import 'package:top_up_information/top_up_information.dart';
import 'package:tymer/firebase_options.dart';
import 'package:tymer/routing_table.dart';

import 'package:routemaster/routemaster.dart';
import 'package:sign_in/sign_in.dart';
import 'package:tab_container/tab_container.dart';

import 'package:user_repository/user_repository.dart';
import 'package:verify_otp/verify_otp.dart';
import 'package:wallet/wallet.dart';
import 'package:wallet_repository/wallet_repository.dart';
import 'package:withdraw/withdraw.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final errorReportingService = ErrorReportingService();
  FlutterError.onError = (errorDetails) {
    errorReportingService.recordFlutterError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    errorReportingService.recordError(error, stack, fatal: true);
    return true;
  };
  FlutterError.onError = errorReportingService.recordFlutterError;

  return runApp(
    const Tymer(),
  );
}

class Tymer extends StatefulWidget {
  const Tymer({
    super.key,
  });

  @override
  TymerState createState() => TymerState();
}

class TymerState extends State<Tymer> with WidgetsBindingObserver {
  Brightness? _appBrightness;
  final ValueNotifier<bool> _unAuthenticatedAccessVN = ValueNotifier(false);
  final ValueNotifier<bool> _signInSuccessVN = ValueNotifier(false);
  final ValueNotifier<InternetConnectionTymerException?>
      _internetConnectionErrorVN = ValueNotifier(null);
  String? fontFamily;
  late final dynamic _connectInApi = TymerApi(
    userTokenSupplier: () => _userRepository.getUserToken(),
    unAuthenticatedAccessVN: _unAuthenticatedAccessVN,
    internetConnectionErrorVN: _internetConnectionErrorVN,
    dio: Dio(),
    urlBuilder: UrlBuilder(),
  );

  late final _userRepository = UserRepository(
    remoteApi: _connectInApi,
    noSqlStorage: _keyValueStorage,
  );
  late final _serviceRepository = ServiceRepository(
    remoteApi: _connectInApi,
    noSqlStorage: _keyValueStorage,
  );

  late final _disputeRepository = DisputeRepository(
    remoteApi: _connectInApi,
    noSqlStorage: _keyValueStorage,
  );
  late final _supportRepository = SupportRepository(
    remoteApi: _connectInApi,
  );
  late final _walletRepository = WalletRepository(
    remoteApi: _connectInApi,
  );

  final _keyValueStorage = KeyValueStorage();

  final _analyticsService = AnalyticsService();

  @override
  void initState() {
    super.initState();
    _userRepository.getUser().first.then((user) {
      _signInSuccessVN.value = user != null;
    });
    _userRepository.getSettings(FetchPolicy.networkOnly);
    WidgetsBinding.instance.addObserver(this);
  }

  // This callback is invoked every time the platform brightness changes.
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    // Get the brightness.
    setState(() {
      _appBrightness = View.of(context).platformDispatcher.platformBrightness;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _walletRepository.checkAndSyncPendingTransactions();
    }
  }

  @override
  void dispose() {

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  late final dynamic _routerDelegate = RoutemasterDelegate(
    observers: [
      ScreenViewObserver(
        analyticsService: _analyticsService,
      ),
    ],
    routesBuilder: (context) {
      return RouteMap(
        routes: buildRoutingTable(
          routerDelegate: _routerDelegate,
          userRepository: _userRepository,
          serviceRepository: _serviceRepository,
          disputeRepository: _disputeRepository,
          supportRepository: _supportRepository,
          unAuthenticatedAccessVN: _unAuthenticatedAccessVN,
          signInSuccessVN: _signInSuccessVN,
          walletRepository: _walletRepository,
        ),
      );
    },
  );
  final _lightTheme = LightTymerThemeData();
  final _darkTheme = DarkTymerThemeData();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalePreferenceDM?>(
      stream: _userRepository.getLocalePreference(),
      builder: (context, snapshot) {
        final localePreference = snapshot.data;

        final isArabic = localePreference?.toLocale() == const Locale('ar');
        if (Platform.isAndroid) {
          fontFamily = isArabic ? 'Tajawal' : 'Montserrat';
        } else if (Platform.isIOS) {
          fontFamily = isArabic ? 'Tajawal' : null;
        }
        return TymerTheme(
          context: context,
          lightTheme: _lightTheme,
          darkTheme: _darkTheme,
          child: AnnotatedRegion(
            // To control the system nav bar when it is changed
            // and when the widget first initializes
            value: _appBrightness == Brightness.dark ||
                    SchedulerBinding
                            .instance.platformDispatcher.platformBrightness ==
                        Brightness.dark
                ? SystemUiOverlayStyle.light.copyWith(
                    systemNavigationBarIconBrightness: Brightness.light,
                    systemNavigationBarColor: Colors.black,
                  )
                : SystemUiOverlayStyle.light.copyWith(
                    systemNavigationBarIconBrightness: Brightness.dark,
                    systemNavigationBarColor: Colors.white,
                  ),
            child: MaterialApp.router(
              title: 'Tymer',
              theme: _lightTheme.materialThemeData.copyWith(
                textTheme: _lightTheme.materialThemeData.textTheme.apply(
                  fontFamily: fontFamily,
                ),
              ),
              darkTheme: _darkTheme.materialThemeData.copyWith(
                textTheme: _darkTheme.materialThemeData.textTheme.apply(
                  fontFamily: fontFamily,
                ),
              ),
              themeMode: ThemeMode.light,
              builder: (context, child) {
                return Directionality(
                  textDirection:
                      isArabic ? TextDirection.rtl : TextDirection.ltr,
                  child: AppWideErrorIndicator(
                    unAuthenticatedAccessVN: _unAuthenticatedAccessVN,
                    internetConnectionErrorVN: _internetConnectionErrorVN,
                    child: child!,
                  ),
                );
              },
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                // Global Localizations
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                ComponentLibraryLocalizations.delegate,

                // Authentication
                SignInLocalizations.delegate,
                SignUpLocalizations.delegate,
                ChangePasswordLocalizations.delegate,
                ChangePhoneLocalizations.delegate,
                VerifyOtpLocalizations.delegate,
                ForgotPasswordLocalizations.delegate,
                TabContainerLocalizations.delegate,
                InitialLocalizations.delegate,
                HomeLocalizations.delegate,
                ChangeLanguageLocalizations.delegate,

                // Request service
                ChooseServiceLocalizations.delegate,
                RequestServiceLocalizations.delegate,
                ServiceRequestStatusLocalizations.delegate,
                ProvideServiceLocalizations.delegate,
                AcceptServiceRequestLocalizations.delegate,
                FulfillServiceRequestLocalizations.delegate,

                OrderHistoryLocalizations.delegate,

                ProfileLocalizations.delegate,
                WalletLocalizations.delegate,
                DisputesLocalizations.delegate,
                ConfirmDisputeLocalizations.delegate,
                DisputeChatLocalizations.delegate,
                WithdrawLocalizations.delegate,
                ChooseTopUpMethodLocalizations.delegate,
                TopUpInformationLocalizations.delegate,
                TopUpConfirmationLocalizations.delegate,
                ChooseWithdrawMethodLocalizations.delegate,
                PaymentHistoryLocalizations.delegate,
                SupportChatLocalizations.delegate,
                DeleteAccountLocalizations.delegate,
                OnlinePaymentLocalizations.delegate,
              ],
              locale: localePreference?.toLocale(),
              supportedLocales: const [
                Locale('en', ''),
                Locale('ar', ''),
              ],
              routerDelegate: _routerDelegate,
              routeInformationParser: const RoutemasterParser(),
            ),
          ),
        );
      },
    );
  }
}

class AppWideErrorIndicator extends StatefulWidget {
  const AppWideErrorIndicator({
    super.key,
    required this.child,
    required this.unAuthenticatedAccessVN,
    required this.internetConnectionErrorVN,
  });

  final Widget child;
  final ValueNotifier<bool?> unAuthenticatedAccessVN;
  final ValueNotifier<InternetConnectionTymerException?>
      internetConnectionErrorVN;

  @override
  State<AppWideErrorIndicator> createState() => _AppWideErrorIndicatorState();
}

class _AppWideErrorIndicatorState extends State<AppWideErrorIndicator> {
  @override
  void initState() {
    super.initState();
    widget.internetConnectionErrorVN.addListener(
      () {
        if (widget.internetConnectionErrorVN.value != null) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
                context: context,
                message: ComponentLibraryLocalizations.of(context)
                    .noInternetConnectionSnackBarErrorMessage),
          );
        }
      },
    );

    widget.unAuthenticatedAccessVN.addListener(
      () {
        final unAuthenticatedAccess = widget.unAuthenticatedAccessVN.value;
        if (unAuthenticatedAccess == true) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: ComponentLibraryLocalizations.of(context)
                  .unAuthSnackBarErrorMessage,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
    );
  }
}

extension on LocalePreferenceDM {
  Locale toLocale() {
    switch (this) {
      case LocalePreferenceDM.english:
        return const Locale('en');
      case LocalePreferenceDM.arabic:
        return const Locale('ar');
    }
  }
}
