import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:homelinker/core/app_router.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/home/home_cubit.dart';
import 'package:homelinker/cubit/introductive/introductive_cubit.dart';
import 'package:homelinker/cubit/login/login_cubit.dart';
import 'package:homelinker/cubit/profile/profile_cubit.dart';
import 'package:homelinker/cubit/property/property_cubit.dart';
import 'package:homelinker/cubit/settings/settings_cubit.dart';
import 'package:homelinker/cubit/signup/signup_cubit.dart';
import 'package:intl/intl.dart';

void main() async {
  configureDependencies();
  await getIt.allReady();
  getIt.registerSingleton<AppRouter>(AppRouter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IntroductiveCubit>(
            create: (context) => getIt<IntroductiveCubit>()),
        BlocProvider<LoginCubit>(create: (context) => getIt<LoginCubit>()),
        BlocProvider<SignupCubit>(create: (context) => getIt<SignupCubit>()),
        BlocProvider<HomeCubit>(create: (context) => getIt<HomeCubit>()),
        BlocProvider<PropertyCubit>(
            create: (context) => getIt<PropertyCubit>()),
        BlocProvider<ProfileCubit>(create: (context) => getIt<ProfileCubit>()),
        BlocProvider<SettingsCubit>(
            create: (context) => getIt<SettingsCubit>()),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
        title: 'HomeLinker',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          Locale result;
          if (locale == null) {
            result = supportedLocales.first;
          } else {
            final Locale? supportedLocale = supportedLocales.firstWhereOrNull(
                (element) => element.languageCode == locale.languageCode);
            result = supportedLocale ?? supportedLocales.first;
          }

          Intl.defaultLocale = result.languageCode;

          return result;
        },
      ),
    );
  }
}
