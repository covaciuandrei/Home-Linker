import 'package:homelinker/data/remote/app_version/app_version_source.dart';
import 'package:homelinker/models/app_version.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppVersionService {
  AppVersionService(this._appVersionSource);

  final AppVersionSource _appVersionSource;

  Future<AppVersion> get() async {
    final appVersion = await _appVersionSource.get();
    return appVersion;
  }
}
