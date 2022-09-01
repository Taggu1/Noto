import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController bodyController,
  })  : _formKey = formKey,
        _titleController = titleController,
        _bodyController = bodyController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _titleController;
  final TextEditingController _bodyController;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: _titleController,
              hintText: 'Title',
              maxLines: 1,
              alignLabelWithHint: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Some text';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _bodyController,
              hintText: 'type something...',
              maxLines: 8,
              alignLabelWithHint: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Some text';
                }
                return null;
              },
            ),
          ],
        ));
  }
}
