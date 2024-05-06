import 'package:homelinker/data/remote/app_version/app_version_dto.dart';
import 'package:homelinker/models/app_version.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppVersionMapper {
  AppVersion mapAppVersionDto(AppVersionDto dto) => AppVersion(
        appVersion: dto.appVersion,
        releaseDate: dto.releaseDate,
      );
}
