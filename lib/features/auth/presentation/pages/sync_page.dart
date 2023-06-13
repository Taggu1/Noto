import 'package:flutter/material.dart';

import 'package:note_app/features/auth/presentation/widgets/auth_widget.dart';

class SyncPage extends StatelessWidget {
  static const routeName = '/sync-page';
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const AuthWidget(),
    );
  }
}
