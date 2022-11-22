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

const String tableListInstances = 'listInstances';

class ListInstanceFields {
  static final List<String> values = [
    /// Add all fields
    id, userId, createdTime, assignedTime, startedTime, finishedTime,
    isCompleted, isPublic, isTemplate
  ];

  static const String id = '_id';
  static const String userId = 'userId';
  static const String createdTime = 'createdTime';
  static const String assignedTime = 'assignedTime';
  static const String startedTime = 'startedTime';
  static const String finishedTime = 'finishedTime';
  static const String isCompleted = 'isCompleted';
  static const String isPublic = 'isPublic';
  static const String isTemplate = 'isTemplate';
}

class ListInstance {
  final int? id;
  final int userId;
  final DateTime createdTime;
  final DateTime? assignedTime;
  final DateTime? startedTime;
  final DateTime? finishedTime;
  final bool isCompleted;
  final bool isPublic;
  final bool isTemplate;

  const ListInstance({
    this.id,
    required this.userId,
    required this.createdTime,
    this.assignedTime,
    this.startedTime,
    this.finishedTime,
    required this.isCompleted,
    required this.isPublic,
    required this.isTemplate,
  });

  ListInstance copy({
    int? id,
    int? userId,
    DateTime? createdTime,
    DateTime? assignedTime,
    DateTime? startedTime,
    DateTime? finishedTime,
    bool? isCompleted,
    bool? isPublic,
    bool? isTemplate,
  }) =>
      ListInstance(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        createdTime: createdTime ?? this.createdTime,
        assignedTime: assignedTime ?? this.assignedTime,
        startedTime: startedTime ?? this.startedTime,
        finishedTime: finishedTime ?? this.finishedTime,
        isCompleted: isCompleted ?? this.isCompleted,
        isPublic: isPublic ?? this.isPublic,
        isTemplate: isTemplate ?? this.isTemplate,
      );

  static ListInstance fromJson(Map<String, Object?> json) => ListInstance(
        id: json[ListInstanceFields.id] as int?,
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
      );

  Map<String, Object?> toJson() => {
        ListInstanceFields.id: id,
        ListInstanceFields.userId: userId,
        ListInstanceFields.createdTime: createdTime.toIso8601String(),
        ListInstanceFields.assignedTime: assignedTime?.toIso8601String(),
        ListInstanceFields.startedTime: startedTime?.toIso8601String(),
        ListInstanceFields.finishedTime: finishedTime?.toIso8601String(),
        ListInstanceFields.isCompleted: isCompleted ? 1 : 0,
        ListInstanceFields.isPublic: isPublic ? 1 : 0,
        ListInstanceFields.isTemplate: isTemplate ? 1 : 0,
      };
}


 


// listItem
// int? id;
// int listInstanceId;
// int listItemId;
// int userId;
// int exerciseId;
// int? sets;
// int? quantity;
// int? weight;
// bool isCompleted;
 