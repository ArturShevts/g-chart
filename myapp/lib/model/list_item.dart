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
// int orderNum;
// Exercise? exercise;  // This is not in the database

import 'package:myapp/model/exercises.dart';

const String tableListItems = 'listItems';

class ListItemFields {
  static final List<String> values = [
    /// Add all fields
    id, listInstanceId, listItemId, userId, exerciseId, sets, quantity, weight,
    isCompleted, orderNum
  ];

  static const String id = '_id';
  static const String listInstanceId = 'listInstanceId';
  static const String listItemId = 'listItemId';
  static const String userId = 'userId';
  static const String exerciseId = 'exerciseId';
  static const String sets = 'sets';
  static const String quantity = 'quantity';
  static const String weight = 'weight';
  static const String isCompleted = 'isCompleted';
  static const String orderNum = 'orderNum';
}

class ListItem {
  final int? id;
  final int listInstanceId;
  final int listItemId;
  final int userId;
  final int exerciseId;
  final int? sets;
  final int? quantity;
  final int? weight;
  final bool isCompleted;
  final int orderNum;
  late Exercise? exercise;

  ListItem(
      {this.id,
      required this.listInstanceId,
      required this.listItemId,
      required this.userId,
      required this.exerciseId,
      this.sets,
      this.quantity,
      this.weight,
      required this.isCompleted,
      required this.orderNum,
      this.exercise});

  ListItem copy({
    int? id,
    int? listInstanceId,
    int? listItemId,
    int? userId,
    int? exerciseId,
    int? sets,
    int? quantity,
    int? weight,
    bool? isCompleted,
    int? orderNum,
    Exercise? exercise,
  }) =>
      ListItem(
        id: id ?? this.id,
        listInstanceId: listInstanceId ?? this.listInstanceId,
        listItemId: listItemId ?? this.listItemId,
        userId: userId ?? this.userId,
        exerciseId: exerciseId ?? this.exerciseId,
        sets: sets ?? this.sets,
        quantity: quantity ?? this.quantity,
        weight: weight ?? this.weight,
        isCompleted: isCompleted ?? this.isCompleted,
        orderNum: orderNum ?? this.orderNum,
        exercise: exercise ?? this.exercise,
      );

  static ListItem fromJson(Map<String, Object?> json) => ListItem(
        id: json[ListItemFields.id] as int?,
        listInstanceId: json[ListItemFields.listInstanceId] as int,
        listItemId: json[ListItemFields.listItemId] as int,
        userId: json[ListItemFields.userId] as int,
        exerciseId: json[ListItemFields.exerciseId] as int,
        sets: json[ListItemFields.sets] as int?,
        quantity: json[ListItemFields.quantity] as int?,
        weight: json[ListItemFields.weight] as int?,
        isCompleted: json[ListItemFields.isCompleted] == 1,
        orderNum: json[ListItemFields.orderNum] as int,
      );

  Map<String, Object?> toJson() => {
        ListItemFields.id: id,
        ListItemFields.listInstanceId: listInstanceId,
        ListItemFields.listItemId: listItemId,
        ListItemFields.userId: userId,
        ListItemFields.exerciseId: exerciseId,
        ListItemFields.sets: sets,
        ListItemFields.quantity: quantity,
        ListItemFields.weight: weight,
        ListItemFields.isCompleted: isCompleted ? 1 : 0,
        ListItemFields.orderNum: orderNum,
      };
}
