import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/auth/presentation/widgets/signup_or_login_button.dart';

import '../../../../core/utils/auth_utils.dart';
import '../../../../core/utils/widgets_extentions.dart';
import '../../../todo/presentation/widgets/sheet_text_field.dart';
import '../auth/auth_bloc.dart';
import 'auth_form_title.dart';

class SignUpOrLoginForm extends StatefulWidget {
  const SignUpOrLoginForm({super.key});

  @override
  State<SignUpOrLoginForm> createState() => _SignUpOrLoginFormState();
}

class _SignUpOrLoginFormState extends State<SignUpOrLoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool isSignup = true;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm(context);
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: _buildFields(),
        ),
      ),
    );
  }

  Column _buildFields() {
    return Column(
      children: [
        AuthFormTitle(
          isSignup: isSignup,
          onChanged: (value) => setState(() {
            isSignup = value;
          }),
        ),
        addVerticalSpace(30),
        SheetTextField(
          hintText: 'Enter your email',
          maxLines: 1,
          controller: _emailController,
          validator: validateEmail,
        ),
        addVerticalSpace(30),
        SheetTextField(
          hintText: 'Enter your password',
          maxLines: 1,
          controller: _passwordController,
          validator: validatePassword,
        ),
        addVerticalSpace(30),
        if (isSignup)
          SheetTextField(
            hintText: 'Confirm your password',
            maxLines: 1,
            controller: _confirmPasswordController,
            validator: (value) {
              if (value != _passwordController.text) {
                return "Passwords are not the same";
              }
              return null;
            },
          ),
        addVerticalSpace(30),
        SignUpOrLoginButton(
          isSignup: isSignup,
          onPressed: _save,
        ),
      ],
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      BlocProvider.of<AuthBloc>(context).add(
        isSignup
            ? SignInAuthEvent(
                email: email,
                password: password,
              )
            : LogInAuthEvent(
                password: password,
                email: email,
              ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
