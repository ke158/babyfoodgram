import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'utils/device_preview_screenshot_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(
      child: DevicePreview(
    enabled: !kReleaseMode,
    tools: const [
      ...DevicePreview.defaultTools,
      DevicePreviewScreenshot(
        onScreenshot: onScreenshot,
      ),
    ],
    builder: (context) => App(), // Wrap your app
  )));
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(ProviderScope(child: const App()));
// }
