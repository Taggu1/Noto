import 'package:flutter/material.dart';

class SheetTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final BorderSide borderSize;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;
  const SheetTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.borderSize = const BorderSide(),
    this.maxLength,
    this.maxLines,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Can't be empty";
        }
        return validator!(value);
      },
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderSide: borderSize,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        hintText: hintText,
      ),
      controller: controller,
    );
  }
}
