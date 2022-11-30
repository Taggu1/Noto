import 'dart:math';

import 'package:colorpicker_flutter/colorpicker_flutter.dart';
import 'package:easy_color_picker/easy_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:note_app/core/utils/my_color_picker.dart';
import 'package:note_app/core/widgets/custom_iconbutton_widget.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:note_app/features/note/presentation/widgets/back_short_cut_handler.dart';

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
  bool _showThicknessToggler = false;
  double drawingPlattehight = 600;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        setState(
          () {
            drawingPlattehight += 300;
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BackShortcutHandler(
      onInvoke: () {
        setState(() {
          widget.painterController.undo();
        });
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: canScroll
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: drawingPlattehight,
                    child: Painter(widget.painterController, !canScroll),
                  ),
                ],
              ),
            ),
          ),
          DrawingActionsRaw(
            painterController: widget.painterController,
            onDrawingButtonLongPress: () {
              setState(() {
                _showThicknessToggler = !_showThicknessToggler;
              });
            },
          ),
          if (_showThicknessToggler) _buildThicknessSlider(),
          Positioned(
            bottom: 10,
            right: 10,
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
        ],
      ),
    );
  }

  Positioned _buildThicknessSlider() {
    return Positioned(
      left: 50,
      top: 60,
      child: Slider(
        min: 1,
        max: 20,
        value: widget.painterController.thickness,
        onChanged: (value) {
          setState(() {
            widget.painterController.thickness = value;
          });
        },
      ),
    );
  }
}

class DrawingActionsRaw extends StatefulWidget {
  final PainterController painterController;
  final VoidCallback onDrawingButtonLongPress;
  const DrawingActionsRaw(
      {super.key,
      required this.painterController,
      required this.onDrawingButtonLongPress});

  @override
  State<DrawingActionsRaw> createState() => _DrawingActionsRawState();
}

class _DrawingActionsRawState extends State<DrawingActionsRaw> {
  bool eraseMode = false;
  bool showColors = true;
  Color _selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              onPressed: () {
                widget.painterController.clear();
              },
              icon: Icons.delete,
            ),
            CustomIconButton(
              onLongPress: widget.onDrawingButtonLongPress,
              onPressed: () {
                eraseMode = !eraseMode;
                setState(() {
                  widget.painterController.eraseMode = eraseMode;
                });
              },
              icon: eraseMode ? FontAwesome5.eraser : FontAwesome5.pencil_alt,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomIconButton(
                    icon: Icons.color_lens,
                    onPressed: () async {
                      widget.painterController.drawColor =
                          await MyColorpickerState.colorChooseSingle(context);
                      setState(() {});
                    },
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
            ),
          ],
        ),
      ),
    );
  }
}
