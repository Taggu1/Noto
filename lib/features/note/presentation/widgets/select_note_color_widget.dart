import 'package:flutter/material.dart';
import 'package:note_app/core/constants/colors.dart';

class SelectColorWidget extends StatefulWidget {
  final Function(Color color) onColorTapped;
  final Color? selectedColor;
  const SelectColorWidget(
      {super.key, required this.onColorTapped, required this.selectedColor});

  @override
  State<SelectColorWidget> createState() => _SelectColorWidgetState();
}

class _SelectColorWidgetState extends State<SelectColorWidget> {
  late Color? selectedColor;

  @override
  void initState() {
    super.initState();

    selectedColor = widget.selectedColor;
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: SizedBox(
        height: 120,
        child: Column(
          children: [
            const Text(
              "Color",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: designColors
                    .map(
                      (color) => Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                            });
                            widget.onColorTapped(color);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(30),
                              border: selectedColor == color
                                  ? Border.all(
                                      width: 4,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
