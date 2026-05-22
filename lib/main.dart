import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/data/secure_storage/secure_storage_keys.dart';
import 'package:homelinker/data/secure_storage/secure_storage_source.dart';
import 'package:intl/intl.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureDependencies();
  FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);
  await getIt.allReady();
  getIt.registerSingleton<AppRouter>(AppRouter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
  static MyAppState of(BuildContext context) => context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppState extends State<MyApp> {
  final appRouter = getIt<AppRouter>();

  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _initializeLocale();
  }

  Future<void> _initializeLocale() async {
    final language = await getIt<SecureStorageSource>().get(SecureStorageKeys.language);

    if (language != null) {
      setState(() {
        _locale = Locale.fromSubtags(languageCode: language);
      });
    }
  }

  Future<void> setLocale(Locale newLanguage) async {
    await getIt<SecureStorageSource>().set(SecureStorageKeys.language, newLanguage.languageCode);

    setState(() {
      _locale = newLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      title: 'HomeLinker',
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        if (_locale != null) {
          return _locale;
        }

        _locale = supportedLocales.first;
        final languageCode = _locale!.languageCode;

        Intl.defaultLocale = _locale!.languageCode;

        getIt<SecureStorageSource>().set(SecureStorageKeys.language, languageCode);

        return _locale;
      },
    );
  }
}

// @override
// void onChange(Change<BaseState> change) {
//   super.onChange(change);
//   print('State changed: ${change.currentState} -> ${change.nextState}');
// }
