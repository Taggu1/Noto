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
import 'package:note_app/core/widgets/loading_widget.dart';
import 'package:note_app/features/backup/domain/entities/backup_data.dart';
import 'package:note_app/features/backup/presentation/bloc/backup_bloc_bloc.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:note_app/features/note/presentation/widgets/app_drawer.dart';

import 'dart:io' show Platform;

import 'package:permission_handler/permission_handler.dart';

import '../../../../core/widgets/app_hamburger_button.dart';
import '../../../note/presentation/widgets/custom_backup_icon.dart';

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
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              onPressed: _backupButtonFunc,
              child: const Text("Backup"),
            ),
            addVerticalSpace(20),
            CustomElevatedButton(
              onPressed: _restoreButtonFunc,
              child: const Text("Restore"),
            ),
            addVerticalSpace(20),
          ],
        ),
      ),
    );
  }

  void _restoreButtonFunc() async {
    await _pickfileButtonFunc();
    if (file == null) {
      return;
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

  Future<void> _pickPathButtonFunc() async {
    selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory == null) {
      _showCustomSnackBar("You didn't choose a directory");
    }
  }

  void _backupButtonFunc() async {
    if (Platform.isAndroid) {
      final req = await Permission.manageExternalStorage.request();
    }
    await _pickPathButtonFunc();

    if (selectedDirectory == null || selectedDirectory!.isEmpty) {
      return;
    } else {
      BlocProvider.of<BackupBlocBloc>(context).add(
        BackupEvent(
          backUpData:
              BackUpData(backUpPath: "${selectedDirectory!}/NotoBackup.hive"),
        ),
      );
    }
  }

  Future<void> _pickfileButtonFunc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

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
