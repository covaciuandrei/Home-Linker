import 'package:equatable/equatable.dart';

class AppVersion extends Equatable {
  const AppVersion({
    required this.appVersion,
    required this.releaseDate,
  });

  final String appVersion;
  final DateTime releaseDate;

  @override
  List<Object?> get props => [appVersion, releaseDate];
}
