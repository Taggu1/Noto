import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/utils/widgets_extentions.dart';
import 'package:note_app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:note_app/core/widgets/custom_text_button.dart';
import 'package:note_app/features/auth/domain/models/app_user.dart';
import 'package:note_app/features/auth/presentation/auth/auth_bloc.dart';

class AuthedWidget extends StatelessWidget {
  final AppUser user;
  const AuthedWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 100,
          child: Column(
            children: [
              Text(
                "You are signed in as ${user.email!}  🎉",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              addVerticalSpace(30),
              CustomElevatedButton(
                onPressed: () => signout(context),
                child: Text(
                  "SignOut",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signout(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      SignOutAuthEvent(),
    );
  }
}
