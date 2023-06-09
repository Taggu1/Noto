import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/widgets/loading_widget.dart';

import '../../../../core/widgets/buttons/custom_elevated_button.dart';
import '../auth/auth_bloc.dart';

class SignUpOrLoginButton extends StatelessWidget {
  final bool isSignup;
  final void Function()? onPressed;
  const SignUpOrLoginButton(
      {super.key, required this.isSignup, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoadingAuthState) {
          return const LoadingWidget();
        }
        return CustomElevatedButton(
          onPressed: onPressed,
          child: Text(
            isSignup ? "Signup" : "Login",
          ),
        );
      },
    );
  }
}
