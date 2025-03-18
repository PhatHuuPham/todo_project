import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:todo_app/dao/task_dao.dart';
import 'package:todo_app/models/task.dart';

part 'app_database.g.dart'; // File này sẽ được tạo tự động

@Database(version: 1, entities: [Task])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}
