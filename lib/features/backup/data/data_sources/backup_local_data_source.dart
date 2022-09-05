import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/features/backup/domain/entities/backup_data.dart';
import '../../../note/domain/entities/note.dart';
import '../../../../injection_container.dart' as di;
import '../../../note/presentation/note/note_bloc.dart';

abstract class BackupLocalDataSource {
  Unit backup({required BackUpData backUpData});
  Future<Unit> restore({required BackUpData backUpData});
}

class BackupLocalDataSourceImpl implements BackupLocalDataSource {
  Box<Note> hiveBox;

  BackupLocalDataSourceImpl({required this.hiveBox});
  @override
  Unit backup({required BackUpData backUpData}) {
    File(hiveBox.path!).copy(backUpData.backUpPath);
    return unit;
  }

  @override
  Future<Unit> restore({required BackUpData backUpData}) async {
    final boxPath = hiveBox.path;
    await hiveBox.close();
    File(backUpData.backUpPath).copy(boxPath!);
    hiveBox = await Hive.openBox("notes");

    return Future.value(unit);
  }
}
