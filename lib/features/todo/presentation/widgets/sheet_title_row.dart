import 'package:flutter/material.dart';

import 'sheet_title_text.dart';

class SheetTitleRow extends StatelessWidget {
  final String text;
  final Function(BuildContext context, bool pop) add;
  const SheetTitleRow({
    super.key,
    required this.text,
    required this.add,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SheetTitleText(text: text),
          IconButton(
            onPressed: () => add(context, true),
            icon: const Icon(
              Icons.check,
            ),
          ),
        ],
      ),
    );
  }
}
