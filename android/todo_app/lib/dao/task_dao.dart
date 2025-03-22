import 'package:floor/floor.dart';
import 'package:todo_app/models/task.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM Task')
  Future<List<Task>> findAllTasks();

  @Query('SELECT * FROM Task WHERE id = :id')
  Future<Task?> findTaskById(int id);

  @Query('SELECT * FROM Task WHERE status = :status')
  Future<List<Task>> findTasksByStatus(String status);

  @Query('DELETE FROM Task')
  Future<void> deleteAllTasks();

  @insert
  Future<void> insertTask(Task task);

  @insert
  Future<void> insertTasks(List<Task> tasks);

  @update
  Future<void> updateTask(Task task);

  @delete
  Future<void> deleteTask(Task task);

  @Query('DELETE FROM Task WHERE id = :id')
  Future<void> deleteTaskById(int id);

  @Query(
      'SELECT * FROM Task WHERE due_date >= :startDate AND due_date <= :endDate')
  Future<List<Task>> findTasksByDateRange(int startDate, int endDate);

  @Query('SELECT * FROM Task WHERE priority = :priority')
  Future<List<Task>> findTasksByPriority(String priority);

  @Query('UPDATE Task SET status = :status WHERE id = :id')
  Future<void> updateTaskStatus(int id, String status);
}
