// listInstance
// int? id;
// int userId;
// DateTime createdTime;
// DateTime? assignedTime;
// DateTime? startedTime;
// DateTime? finishedTime;
// bool isCompleted;
// bool isPublic;
// bool isTemplate;
// String? repeatOn;
// int? repeatEvery;
// List<ListItem> listItems; // this is not in the database

import 'package:myapp/model/list_item.dart';

const String tableListInstances = 'listInstances';

class ListInstanceFields {
  static final List<String> values = [
    /// Add all fields
    id, title, description, userId, createdTime, assignedTime, startedTime,
    finishedTime,
    isCompleted, isPublic, isTemplate, repeatOn, repeatEvery,
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String userId = 'userId';
  static const String createdTime = 'createdTime';
  static const String assignedTime = 'assignedTime';
  static const String startedTime = 'startedTime';
  static const String finishedTime = 'finishedTime';
  static const String isCompleted = 'isCompleted';
  static const String isPublic = 'isPublic';
  static const String isTemplate = 'isTemplate';
  static const String repeatOn = 'repeatOn';
  static const String repeatEvery = 'repeatEvery';
}

class ListInstance {
  final int? id;
  final int userId;
  final String title;
  final String? description;
  final DateTime createdTime;
  final DateTime? assignedTime;
  final DateTime? startedTime;
  final DateTime? finishedTime;
  final bool isCompleted;
  final bool isPublic;
  final bool isTemplate;
  final String? repeatOn;
  final int? repeatEvery;
  late List<ListItem>? listItems;

  ListInstance({
    this.id,
    required this.title,
    this.description,
    required this.userId,
    required this.createdTime,
    this.assignedTime,
    this.startedTime,
    this.finishedTime,
    required this.isCompleted,
    required this.isPublic,
    required this.isTemplate,
    required this.repeatOn,
    required this.repeatEvery,
    this.listItems,
  });

  ListInstance copy({
    int? id,
    String? title,
    String? description,
    int? userId,
    DateTime? createdTime,
    DateTime? assignedTime,
    DateTime? startedTime,
    DateTime? finishedTime,
    bool? isCompleted,
    bool? isPublic,
    bool? isTemplate,
    String? repeatOn,
    int? repeatEvery,
    List<ListItem>? listItems,
  }) =>
      ListInstance(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        userId: userId ?? this.userId,
        createdTime: createdTime ?? this.createdTime,
        assignedTime: assignedTime ?? this.assignedTime,
        startedTime: startedTime ?? this.startedTime,
        finishedTime: finishedTime ?? this.finishedTime,
        isCompleted: isCompleted ?? this.isCompleted,
        isPublic: isPublic ?? this.isPublic,
        isTemplate: isTemplate ?? this.isTemplate,
        repeatOn: repeatOn ?? this.repeatOn,
        repeatEvery: repeatEvery ?? this.repeatEvery,
        listItems: listItems ?? this.listItems,
      );

  static ListInstance fromJson(Map<String, Object?> json) => ListInstance(
        id: json[ListInstanceFields.id] as int?,
        title: json[ListInstanceFields.title] as String,
        description: json[ListInstanceFields.description] as String?,
        userId: json[ListInstanceFields.userId] as int,
        createdTime:
            DateTime.parse(json[ListInstanceFields.createdTime] as String),
        assignedTime: json[ListInstanceFields.assignedTime] != null
            ? DateTime.parse(json[ListInstanceFields.assignedTime] as String)
            : null,
        startedTime: json[ListInstanceFields.startedTime] != null
            ? DateTime.parse(json[ListInstanceFields.startedTime] as String)
            : null,
        finishedTime: json[ListInstanceFields.finishedTime] != null
            ? DateTime.parse(json[ListInstanceFields.finishedTime] as String)
            : null,
        isCompleted: json[ListInstanceFields.isCompleted] == 1,
        isPublic: json[ListInstanceFields.isPublic] == 1,
        isTemplate: json[ListInstanceFields.isTemplate] == 1,
        repeatOn: json[ListInstanceFields.repeatOn] as String?,
        repeatEvery: json[ListInstanceFields.repeatEvery] as int?,
      );

  Map<String, Object?> toJson() => {
        ListInstanceFields.id: id,
        ListInstanceFields.title: title,
        ListInstanceFields.description: description,
        ListInstanceFields.userId: userId,
        ListInstanceFields.createdTime: createdTime.toIso8601String(),
        ListInstanceFields.assignedTime: assignedTime?.toIso8601String(),
        ListInstanceFields.startedTime: startedTime?.toIso8601String(),
        ListInstanceFields.finishedTime: finishedTime?.toIso8601String(),
        ListInstanceFields.isCompleted: isCompleted ? 1 : 0,
        ListInstanceFields.isPublic: isPublic ? 1 : 0,
        ListInstanceFields.isTemplate: isTemplate ? 1 : 0,
        ListInstanceFields.repeatOn: repeatOn,
        ListInstanceFields.repeatEvery: repeatEvery,
      };
}
