import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformAwareWidget extends StatelessWidget {
  final Widget? androidWidget;
  final Widget? windowsWidget;
  final Widget? linuxWidget;
  final Widget? macOsWidget;
  final Widget? iosWidgett;
  const PlatformAwareWidget({
    super.key,
    this.androidWidget,
    this.windowsWidget,
    this.linuxWidget,
    this.macOsWidget,
    this.iosWidgett,
  });

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidWidget ?? const Placeholder();
      case TargetPlatform.fuchsia:
        return androidWidget ?? const Placeholder();

      case TargetPlatform.iOS:
        return iosWidgett ?? const Placeholder();

      case TargetPlatform.linux:
        return linuxWidget ?? const Placeholder();

      case TargetPlatform.macOS:
        return macOsWidget ?? const Placeholder();

      case TargetPlatform.windows:
        return windowsWidget ?? const Placeholder();
    }
  }
}
