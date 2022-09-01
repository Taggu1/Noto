import 'package:flutter/material.dart';
import 'package:note_app/core/widgets/custom_iconbutton_widget.dart';
import 'package:painter/painter.dart';

class DrawingWidget extends StatelessWidget {
  final PainterController painterController;
  const DrawingWidget({
    super.key,
    required this.painterController,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Stack(children: [
        Container(
          color: Colors.white,
          width: size.width,
          height: 300,
          child: Painter(painterController),
        ),
        CustomIconButton(
          onPressed: () {
            painterController.clear();
          },
          icon: Icons.delete,
        )
      ]),
    );
  }
}
