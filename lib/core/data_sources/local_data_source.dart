import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/core/constants/strings.dart';
import 'package:note_app/features/habits/domain/models/habit.dart';
import 'package:note_app/features/note/domain/entities/folder.dart';
import 'package:note_app/features/note/domain/entities/note.dart';

import '../../features/todo/domain/entities/task.dart';
import '../errors/exceptions.dart';

abstract class LocalDataSource<T> {
  Future<Unit> removeItem({required String itemId});
  Future<Unit> addItem({required T item});
  Future<List<T>> fetchItems();
}

class LocalDataSourceImpl<T> implements LocalDataSource<T> {
  Box<T> hiveBox;

  LocalDataSourceImpl(this.hiveBox);

  @override
  Future<Unit> addItem({required T item}) {
    late String id;

    switch (item) {
      case Habit():
        id = item.id;
      case AppTask():
        id = item.id;
      case Note():
        id = item.id;
      case Folder():
        id = item.id;
    }

    try {
      hiveBox.put(id, item);
      return Future.value(unit);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<Unit> removeItem({required String itemId}) {
    try {
      hiveBox.delete(itemId);
      return Future.value(unit);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<T>> fetchItems() async {
    late String boxName;

    switch (T) {
      case Habit():
        boxName = kHabitBoxName;
      case AppTask():
        boxName = kTasksBoxName;
      case Note():
        boxName = kNotesBoxName;
      case Theme():
        boxName = kThemeBoxName;
      case Folder():
        boxName = kFolderBoxName;
    }

    if (!hiveBox.isOpen) {
      hiveBox = await Hive.openBox(boxName);
    }
    try {
      return Future.value(hiveBox.values.toList());
    } catch (e) {
      throw DatabaseException();
    }
  }
}
