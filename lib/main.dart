import 'dart:io';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forgot_password/forgot_password.dart';
import 'package:home/home.dart';
import 'package:initial/initial.dart';

import 'package:key_value_storage/key_value_storage.dart';
import 'package:reset_password/reset_password.dart';
import 'package:sign_up/sign_up.dart';
import 'package:tymer/firebase_options.dart';
import 'package:tymer/routing_table.dart';
import 'package:tymer_api/tymer_api.dart';

import 'package:routemaster/routemaster.dart';
import 'package:sign_in/sign_in.dart';
import 'package:tab_container/tab_container.dart';

import 'package:user_repository/user_repository.dart';
import 'package:verify_otp/verify_otp.dart';

String? fontFamily;

final ValueNotifier<bool> _isUserUnAuthSC = ValueNotifier(false);
final ValueNotifier<InternetConnectionTymerException?>
    _internetConnectionErrorVN = ValueNotifier(null);
final ValueNotifier<bool> _signInSuccessVN = ValueNotifier(false);

final dynamic _connectInApi = TymerApi(
  userTokenSupplier: () => _userRepository.getUserToken(),
  isUserUnAuthenticatedVN: _isUserUnAuthSC,
  internetConnectionErrorVN: _internetConnectionErrorVN,
);

final _userRepository = UserRepository(
  remoteApi: _connectInApi,
  noSqlStorage: _keyValueStorage,
);

final _keyValueStorage = KeyValueStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

  @override
  void initState() {
    super.initState();
    _userRepository.getUser().first.then((user) {
      _signInSuccessVN.value = user?.phone != null;
    });
    // _userRepository.upsertLocalePreference(LocalePreferenceDM.arabic);
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
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  late final dynamic _routerDelegate = RoutemasterDelegate(
    routesBuilder: (context) {
      return RouteMap(
        routes: buildRoutingTable(
          routerDelegate: _routerDelegate,
          userRepository: _userRepository,
          signInSuccessVN: _signInSuccessVN,
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
                  child: InternetErrorIndicator(
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
                VerifyOtpLocalizations.delegate,
                ForgotPasswordLocalizations.delegate,
                ResetPasswordLocalizations.delegate,

                TabContainerLocalizations.delegate,
                InitialLocalizations.delegate,
                HomeLocalizations.delegate,
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

class InternetErrorIndicator extends StatefulWidget {
  const InternetErrorIndicator({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<InternetErrorIndicator> createState() => _InternetErrorIndicatorState();
}

class _InternetErrorIndicatorState extends State<InternetErrorIndicator> {
  @override
  void initState() {
    super.initState();
    _internetConnectionErrorVN.addListener(
      () {
        if (_internetConnectionErrorVN.value != null) {
          showSnackBar(
            context: context,
            snackBar: const InternetErrorSnackBar(),
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
