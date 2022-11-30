import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingsTile extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final Widget? trailing;
  final VoidCallback? onbuttonTap;
  const SettingsTile({
    super.key,
    required this.titleText,
    required this.subTitleText,
    this.onbuttonTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(titleText),
      subtitle: Text(subTitleText),
      trailing: trailing,
      onTap: onbuttonTap,
    );
  }
}
