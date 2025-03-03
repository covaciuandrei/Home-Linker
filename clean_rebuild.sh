flutter clean
rm ios/Podfile.lock pubspec.lock
rm -rf ios/Pods ios/Runner.xcworkspace
flutter pub get
dart run build_runner build --delete-conflicting-outputs

if [ -f "lib/core/app_router.gr.dart" ]; then
  sed -i '' "1i\\
import 'package:google_maps_flutter/google_maps_flutter.dart';\\
" lib/core/app_router.gr.dart
  echo "Added import to app_router.gr.dart"
else
  echo "app_router.gr.dart not found"
fi

flutter gen-l10n