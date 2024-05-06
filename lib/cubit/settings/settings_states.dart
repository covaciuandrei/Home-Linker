part of 'package:homelinker/cubit/settings/settings_cubit.dart';

class AccountDeletedSuccessfullyState extends BaseState {}

class LoggedOutSuccessfullyState extends BaseState {}

class SettingsPageLoadedState extends BaseState {
  SettingsPageLoadedState({
    required this.appVersion,
  });

  final AppVersion appVersion;
}
