import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BackShortcutHandler extends StatelessWidget {
  final Widget child;
  final VoidCallback onInvoke;
  const BackShortcutHandler(
      {super.key, required this.child, required this.onInvoke});

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyZ, control: true): onInvoke,
      },
      child: Focus(autofocus: true, child: child),
    );
  }
}
