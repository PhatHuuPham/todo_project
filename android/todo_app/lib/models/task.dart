import 'package:floor/floor.dart';

@entity
class Task {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int? userId;
  final String title;
  final String description;
  final int? categoryId;

  @ColumnInfo(name: 'due_date')
  final int? dueDate; // Lưu timestamp trong SQLite

  final String status;
  final String priority;

  final bool? isSynced;

  @ColumnInfo(name: 'created_at')
  final int? createdAt; // Lưu timestamp trong SQLite

  @ColumnInfo(name: 'updated_at')
  final int? updatedAt; // Lưu timestamp trong SQLite

  Task({
    this.id,
    this.userId,
    this.title = '',
    this.description = '',
    this.categoryId,
    this.dueDate,
    this.status = 'pending',
    this.priority = 'medium',
    this.isSynced = false,
    this.createdAt,
    this.updatedAt,
  });

  // Chuyển từ JSON (API) về object Task
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      categoryId: json['category_id'],
      dueDate: json['due_date'] != null
          ? DateTime.parse(json['due_date']).millisecondsSinceEpoch
          : null,
      status: json['status'],
      priority: json['priority'],
      isSynced: json['is_synced'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at']).millisecondsSinceEpoch
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at']).millisecondsSinceEpoch
          : null,
    );
  }

  // Chuyển từ object Task thành JSON (API)
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'category_id': categoryId,
      'due_date': dueDate != null
          ? DateTime.fromMillisecondsSinceEpoch(dueDate!).toIso8601String()
          : null,
      'status': status,
      'priority': priority,
      'is_synced': isSynced,
      'created_at': createdAt != null
          ? DateTime.fromMillisecondsSinceEpoch(createdAt!).toIso8601String()
          : null,
      'updated_at': updatedAt != null
          ? DateTime.fromMillisecondsSinceEpoch(updatedAt!).toIso8601String()
          : null,
    };
  }
}
