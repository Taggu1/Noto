import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_app/core/constants/theme_constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool alignLabelWithHint;
  final Function validator;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.maxLines,
    required this.alignLabelWithHint,
    required this.validator,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Material(
          color: Colors.transparent,
          child: TextFormField(
            validator: (value) => widget.validator(value),
            controller: widget.controller,
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              border: InputBorder.none,
              labelText: widget.hintText,
              alignLabelWithHint: widget.alignLabelWithHint,
            ),
            maxLines: widget.maxLines,
          ),
        ),
      ),
    );
  }
}
