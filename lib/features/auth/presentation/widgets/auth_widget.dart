import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/constants/strings.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/core/utils/auth_utils.dart';
import 'package:note_app/core/utils/widgets_extentions.dart';
import 'package:note_app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:note_app/core/widgets/custom_snackbar.dart';
import 'package:note_app/features/auth/presentation/auth/auth_bloc.dart';
import 'package:note_app/features/auth/presentation/widgets/auth_form_title.dart';
import 'package:note_app/features/auth/presentation/widgets/authed_widget.dart';
import 'package:note_app/features/auth/presentation/widgets/sign_up_or_login_form.dart';
import 'package:note_app/features/todo/presentation/widgets/sheet_title_text.dart';
import 'package:note_app/features/todo/presentation/widgets/sheet_text_field.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: _buildWidget(context),
    );
  }

  Widget _buildWidget(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(
            22,
          ),
        ),
        width: 600,
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ErrorAuthState) {
              customSnackBar(
                content: state.message,
                context: context,
              );
            }
          },
          builder: (context, state) {
            switch (state) {
              case AuthenticatedAuthState():
                return AuthedWidget(
                  user: state.user,
                );
              case NotAuthenticatedAuthState() ||
                    ErrorAuthState() ||
                    LoadingAuthState():
                return const SignUpOrLoginForm();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
