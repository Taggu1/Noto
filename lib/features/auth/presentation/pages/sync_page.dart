import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/widgets/custom_snackbar.dart';
import 'package:note_app/core/widgets/loading_widget.dart';
import 'package:note_app/features/auth/presentation/widgets/auth_widget.dart';

import '../auth/auth_bloc.dart';

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
