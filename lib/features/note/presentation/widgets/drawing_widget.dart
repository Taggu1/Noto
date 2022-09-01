import 'dart:math';

import 'package:easy_color_picker/easy_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:note_app/core/widgets/custom_iconbutton_widget.dart';
import 'package:painter/painter.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

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
      child: size.width > 800
          ? Column(children: [
              DrawingActionsRaw(
                painterController: painterController,
              ),
              Container(
                color: Colors.white,
                width: size.width,
                height: 300,
                child: Painter(painterController),
              ),
            ])
          : Stack(
              children: [
                Container(
                  color: Colors.white,
                  width: size.width,
                  height: size.height * 0.6,
                  child: Painter(painterController),
                ),
                DrawingActionsRaw(
                  painterController: painterController,
                ),
              ],
            ),
    );
  }
}

class DrawingActionsRaw extends StatefulWidget {
  final PainterController painterController;
  const DrawingActionsRaw({super.key, required this.painterController});

  @override
  State<DrawingActionsRaw> createState() => _DrawingActionsRawState();
}

class _DrawingActionsRawState extends State<DrawingActionsRaw> {
  bool eraseMode = false;
  bool showColors = true;
  Color _selectedColor = Colors.red;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          CustomIconButton(
            onPressed: () {
              widget.painterController.clear();
            },
            icon: Icons.delete,
          ),
          CustomIconButton(
            onPressed: () {
              eraseMode = !eraseMode;
              setState(() {
                widget.painterController.eraseMode = eraseMode;
              });
            },
            icon: eraseMode ? Icons.delete_outlined : Icons.draw_outlined,
          ),
          CustomIconButton(
            onPressed: () {
              setState(() {
                showColors = !showColors;
              });
            },
            icon: showColors ? Icons.arrow_right : Icons.arrow_left,
          ),
          if (showColors)
            Expanded(
              child: EasyColorPicker(
                  colors: const [Colors.black, Colors.purple],
                  selected: _selectedColor,
                  onChanged: (color) {
                    setState(() {
                      _selectedColor = color;
                      widget.painterController.drawColor = _selectedColor;
                    });
                  }),
            ),
          CustomIconButton(
            onPressed: () {
              setState(() {
                widget.painterController.undo();
              });
            },
            icon: Icons.undo,
          ),
        ],
      ),
    );
  }
}
