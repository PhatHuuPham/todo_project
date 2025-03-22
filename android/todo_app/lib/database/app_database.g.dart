// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TaskDao? _taskDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Task` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `categoryId` INTEGER, `due_date` INTEGER, `status` TEXT NOT NULL, `priority` TEXT NOT NULL, `created_at` INTEGER, `updated_at` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'Task',
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'title': item.title,
                  'description': item.description,
                  'categoryId': item.categoryId,
                  'due_date': item.dueDate,
                  'status': item.status,
                  'priority': item.priority,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _taskUpdateAdapter = UpdateAdapter(
            database,
            'Task',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'title': item.title,
                  'description': item.description,
                  'categoryId': item.categoryId,
                  'due_date': item.dueDate,
                  'status': item.status,
                  'priority': item.priority,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _taskDeletionAdapter = DeletionAdapter(
            database,
            'Task',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'userId': item.userId,
                  'title': item.title,
                  'description': item.description,
                  'categoryId': item.categoryId,
                  'due_date': item.dueDate,
                  'status': item.status,
                  'priority': item.priority,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Task> _taskInsertionAdapter;

  final UpdateAdapter<Task> _taskUpdateAdapter;

  final DeletionAdapter<Task> _taskDeletionAdapter;

  @override
  Future<List<Task>> findAllTasks() async {
    return _queryAdapter.queryList('SELECT * FROM Task',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            userId: row['userId'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            categoryId: row['categoryId'] as int?,
            dueDate: row['due_date'] as int?,
            status: row['status'] as String,
            priority: row['priority'] as String,
            createdAt: row['created_at'] as int?,
            updatedAt: row['updated_at'] as int?));
  }

  @override
  Future<Task?> findTaskById(int id) async {
    return _queryAdapter.query('SELECT * FROM Task WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            userId: row['userId'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            categoryId: row['categoryId'] as int?,
            dueDate: row['due_date'] as int?,
            status: row['status'] as String,
            priority: row['priority'] as String,
            createdAt: row['created_at'] as int?,
            updatedAt: row['updated_at'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<Task>> findTasksByStatus(String status) async {
    return _queryAdapter.queryList('SELECT * FROM Task WHERE status = ?1',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            userId: row['userId'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            categoryId: row['categoryId'] as int?,
            dueDate: row['due_date'] as int?,
            status: row['status'] as String,
            priority: row['priority'] as String,
            createdAt: row['created_at'] as int?,
            updatedAt: row['updated_at'] as int?),
        arguments: [status]);
  }

  @override
  Future<void> deleteAllTasks() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Task');
  }

  @override
  Future<void> deleteTaskById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Task WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<List<Task>> findTasksByDateRange(
    int startDate,
    int endDate,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Task WHERE due_date >= ?1 AND due_date <= ?2',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            userId: row['userId'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            categoryId: row['categoryId'] as int?,
            dueDate: row['due_date'] as int?,
            status: row['status'] as String,
            priority: row['priority'] as String,
            createdAt: row['created_at'] as int?,
            updatedAt: row['updated_at'] as int?),
        arguments: [startDate, endDate]);
  }

  @override
  Future<List<Task>> findTasksByPriority(String priority) async {
    return _queryAdapter.queryList('SELECT * FROM Task WHERE priority = ?1',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            userId: row['userId'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            categoryId: row['categoryId'] as int?,
            dueDate: row['due_date'] as int?,
            status: row['status'] as String,
            priority: row['priority'] as String,
            createdAt: row['created_at'] as int?,
            updatedAt: row['updated_at'] as int?),
        arguments: [priority]);
  }

  @override
  Future<void> updateTaskStatus(
    int id,
    String status,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Task SET status = ?2 WHERE id = ?1',
        arguments: [id, status]);
  }

  @override
  Future<void> insertTask(Task task) async {
    await _taskInsertionAdapter.insert(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertTasks(List<Task> tasks) async {
    await _taskInsertionAdapter.insertList(tasks, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTask(Task task) async {
    await _taskUpdateAdapter.update(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTask(Task task) async {
    await _taskDeletionAdapter.delete(task);
  }
}
