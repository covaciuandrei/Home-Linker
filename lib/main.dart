import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:homelinker/core/app_router.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/home/home_cubit.dart';
import 'package:homelinker/cubit/introductive/introductive_cubit.dart';
import 'package:homelinker/cubit/listing/listing_cubit.dart';
import 'package:homelinker/cubit/login/login_cubit.dart';
import 'package:homelinker/cubit/new_property/new_property_cubit.dart';
import 'package:homelinker/cubit/profile/profile_cubit.dart';
import 'package:homelinker/cubit/reset_password/forgot_password_cubit.dart';
import 'package:homelinker/cubit/reset_password/reset_password_cubit.dart';
import 'package:homelinker/cubit/settings/settings_cubit.dart';
import 'package:homelinker/cubit/signup/signup_cubit.dart';
import 'package:homelinker/cubit/splash/splash_cubit.dart';
import 'package:homelinker/data/secure_storage/secure_storage_keys.dart';
import 'package:homelinker/data/secure_storage/secure_storage_source.dart';
import 'package:intl/intl.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  await FlutterConfig.loadEnvVariables();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(create: (context) => getIt<SplashCubit>()),
        BlocProvider<IntroductiveCubit>(create: (context) => getIt<IntroductiveCubit>()),
        BlocProvider<LoginCubit>(create: (context) => getIt<LoginCubit>()),
        BlocProvider<SignupCubit>(create: (context) => getIt<SignupCubit>()),
        BlocProvider<HomeCubit>(create: (context) => getIt<HomeCubit>()),
        BlocProvider<ProfileCubit>(create: (context) => getIt<ProfileCubit>()),
        BlocProvider<SettingsCubit>(create: (context) => getIt<SettingsCubit>()),
        BlocProvider<NewPropertyCubit>(create: (context) => getIt<NewPropertyCubit>()),
        BlocProvider<ForgotPasswordCubit>(create: (context) => getIt<ForgotPasswordCubit>()),
        BlocProvider<ResetPasswordCubit>(create: (context) => getIt<ResetPasswordCubit>()),
        BlocProvider<ListingCubit>(create: (context) => getIt<ListingCubit>()),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
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
      ),
    );
  }
}
