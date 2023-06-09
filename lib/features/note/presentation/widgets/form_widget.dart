import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    TextEditingController? bodyController,
    required this.withBody,
  })  : _formKey = formKey,
        _titleController = titleController,
        _bodyController = bodyController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _titleController;
  final TextEditingController? _bodyController;
  final bool withBody;

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
              maxLength: 40,
              alignLabelWithHint: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter a Title';
                }
                return null;
              },
            ),
            if (withBody)
              CustomTextField(
                controller: _bodyController!,
                hintText: 'type something...',
                maxLines: 23,
                maxLength: null,
                alignLabelWithHint: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter a Body';
                  }
                  return null;
                },
              ),
          ],
        ));
  }
}
