import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:note_app/features/backup/domain/entities/backup_data.dart';
import '../../../note/domain/entities/note.dart';

abstract class BackupLocalDataSource {
  Future<Unit> backup({required BackUpData backUpData});
  Future<Unit> restore({required BackUpData backUpData});
}

class BackupLocalDataSourceImpl implements BackupLocalDataSource {
  Box<Note> hiveBox;

  BackupLocalDataSourceImpl({required this.hiveBox});
  @override
  Future<Unit> backup({required BackUpData backUpData}) async {
    await File(hiveBox.path!).copy(backUpData.backUpPath);
    // Adding this to show some animations
    await Future.delayed(
      const Duration(seconds: 4),
    );

    return unit;
  }

  @override
  Future<Unit> restore({required BackUpData backUpData}) async {
    final boxPath = hiveBox.path;
    await hiveBox.close();

    await File(boxPath!).delete();
    await File(backUpData.backUpPath).copy(boxPath);
    hiveBox = await Hive.openBox("notes");

    return Future.value(unit);
  }
}
