import 'dart:math';

import 'package:easy_color_picker/easy_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:note_app/core/widgets/custom_iconbutton_widget.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../../../../core/painter/painter.dart';

class DrawingWidget extends StatefulWidget {
  final PainterController painterController;
  const DrawingWidget({
    super.key,
    required this.painterController,
  });

  @override
  State<DrawingWidget> createState() => _DrawingWidgetState();
}

class _DrawingWidgetState extends State<DrawingWidget> {
  bool canScroll = false;
  double drawingPlattehight = 600;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SingleChildScrollView(
          physics: canScroll
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Column(
              children: [
                DrawingActionsRaw(
                  painterController: widget.painterController,
                ),
                Container(
                  width: size.width,
                  height: drawingPlattehight,
                  child: Painter(widget.painterController, !canScroll),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: CustomIconButton(
            onPressed: () {
              setState(
                () {
                  canScroll = !canScroll;
                },
              );
            },
            icon: canScroll ? FontAwesome5.scroll : Typicons.edit,
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: CustomIconButton(
            onPressed: () {
              print("s");
              setState(
                () {
                  drawingPlattehight += 300;
                },
              );
            },
            icon: Icons.add,
          ),
        ),
      ],
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
            icon: eraseMode ? FontAwesome5.eraser : FontAwesome5.pencil_alt,
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
