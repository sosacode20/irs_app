import 'dart:io';
import 'package:flutter/material.dart';
import 'package:irs_app/irs_app.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  // Handling Windows Size
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    // Must add this line.
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(500, 720),
      center: true,
      // backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      minimumSize: Size(400, 600),
      maximumSize: Size(600, 1000),
      title: 'Everything',
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(IrsApp());
}
