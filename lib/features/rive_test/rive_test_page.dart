import 'package:flutter/material.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:rive/rive.dart';

class RiveTest extends StatefulWidget {
  const RiveTest({super.key});

  @override
  State<RiveTest> createState() => _RiveTestState();
}

class _RiveTestState extends State<RiveTest> {
  SMITrigger? _bump;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _bump = controller.findInput<bool>('Package') as SMITrigger;
  }

  void _hitBump() => _bump?.fire();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Center(
        child: IconButton(
          onPressed: _hitBump,
          icon: RiveAnimation.asset(
            'assets/delivery.riv',
            fit: BoxFit.contain,
            onInit: _onRiveInit,
          ),
        ),
      ),
    );
  }
}
