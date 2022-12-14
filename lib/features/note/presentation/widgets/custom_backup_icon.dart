import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rive/rive.dart';

class CustomBackupButtonIcon extends StatefulWidget {
  const CustomBackupButtonIcon({super.key});

  @override
  State<CustomBackupButtonIcon> createState() => _CustomBackupButtonIconState();
}

class _CustomBackupButtonIconState extends State<CustomBackupButtonIcon> {
  SMITrigger? _bump;
  late RiveAnimationController _controller;

  void _togglePlay() =>
      setState(() => _controller.isActive = !_controller.isActive);

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('idle');
  }

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _bump = controller.findInput<bool>('Pressed') as SMITrigger;
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/loading-bars.riv',
      fit: BoxFit.fitHeight,
      onInit: _onRiveInit,
    );
  }
}
