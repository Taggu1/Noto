import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/core/utils/widgets_extentions.dart';
import 'package:note_app/core/widgets/buttons/app_back_button.dart';
import 'package:note_app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:note_app/core/widgets/custom_snackbar.dart';
import 'package:note_app/features/backup/domain/entities/backup_data.dart';
import 'package:note_app/features/backup/presentation/bloc/backup_bloc_bloc.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';

class BackupPage extends StatefulWidget {
  static const routeName = '/backupPage';
  const BackupPage({super.key});

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  String? selectedDirectory = "";
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        backgroundColor: kBlackColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomElevatedButton(
                  onPressed: _backupButtonFunc,
                  child: const Text("Backup"),
                ),
                CustomElevatedButton(
                  onPressed: _pickPathButtonFunc,
                  child: const Text("Pick path"),
                ),
              ],
            ),
            addVerticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomElevatedButton(
                  onPressed: _restoreButtonFunc,
                  child: const Text("Restore"),
                ),
                CustomElevatedButton(
                  onPressed: _pickfileButtonFunc,
                  child: const Text("pick file"),
                ),
              ],
            ),
            addVerticalSpace(20),
          ],
        ),
      ),
    );
  }

  void _restoreButtonFunc() async {
    if (file == null) {
      _showCustomSnackBar("please choose a valid file");
    } else {
      BlocProvider.of<BackupBlocBloc>(context).add(
        RestoreEvent(
          backUpData: BackUpData(backUpPath: file!.path),
        ),
      );
      Future.delayed(const Duration(milliseconds: 300)).then(
        (value) => BlocProvider.of<NoteBloc>(context).add(FetchNotesEvent()),
      );
    }
  }

  void _pickPathButtonFunc() async {
    selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory == null) {
      _showCustomSnackBar("You didn't choose a directory");
    }
  }

  void _backupButtonFunc() {
    if (selectedDirectory == null || selectedDirectory!.isEmpty) {
      _showCustomSnackBar("Please choose a valid directory");
    } else {
      BlocProvider.of<BackupBlocBloc>(context).add(
        BackupEvent(
          backUpData:
              BackUpData(backUpPath: "${selectedDirectory!}/NotoBackup.hive"),
        ),
      );
    }
  }

  void _pickfileButtonFunc() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowedExtensions: ["hive"], type: FileType.custom);

    if (result != null) {
      file = File(result.files.single.path!);
      print(file!.path);
    } else {
      _showCustomSnackBar("You didn't choose a file");
    }
  }

  void _showCustomSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(content: message),
    );
  }
}
