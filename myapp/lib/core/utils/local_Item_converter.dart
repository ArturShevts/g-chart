import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:myapp/db/services/exercises_service.dart';
import 'package:myapp/model/exercises.dart';
import 'package:myapp/model/list_item.dart';
import 'package:myapp/model/local_item.dart';

// ListItem ListItem({
//   int? id,
//   required int listInstanceId,
//   required int userId,
//   required int exerciseId,
//   int? sets,
//   int? quantity,
//   int? weight,
//   required bool isCompleted,
//   required int orderNum,
//   Exercise? exercise,

// class LocalItem {
//   String exerciseId;
//   String exerciseName;
//   String displayString;
//   String reps;
//   String weight;
//   String sets;
class LocalItemConverter {
  static final LocalItemConverter instance = LocalItemConverter._init();

  LocalItemConverter._init();

  List<ListItem> localItemToListItem(List<LocalItem> localItems, int listId) {
    List<ListItem> listItems = [];
    for (var i = 0; i < localItems.length; i++) {
      var item = localItems[i];
      if (item.exerciseId == '' ||
          !item.displayString.contains(item.exerciseName)) {
        continue;
      }
      listItems.add(ListItem(
        exerciseId: int.parse(item.exerciseId),
        quantity: int.parse(item.reps),
        weight: int.parse(item.weight),
        sets: int.parse(item.sets),
        listInstanceId: listId,
        userId: 1, //add user handling,
        isCompleted: false,
        orderNum: i,
      ));
    }

    return listItems;
  }

  Future<List<LocalItem>> listItemToLocalItem(List<ListItem> listItems) async {
    List<LocalItem> localItems = [];
    List<int> exerciseIds = listItems.map((e) => e.exerciseId).toList();
    List<Exercise> exercises = await ExercisesService.instance
        .readExercisesForListItemIds(exerciseIds);

    for (var i = 0; i < listItems.length; i++) {
      var item = listItems[i];

      Exercise exercise =
          exercises.firstWhere((element) => element.id == item.exerciseId);

      String displayString = exercise.name;
      if (item.sets != 0 && item.sets != null) {
        displayString += " ${item.sets} Sets";
      }
      if (item.quantity != 0 && item.quantity != null) {
        displayString += " ${item.quantity} Reps";
      }
      if (item.weight != 0 && item.weight != null) {
        displayString += " ${item.weight} Kg";
      }

      localItems.add(LocalItem(
        exerciseId: item.exerciseId.toString(),
        exerciseName: exercise.name,
        displayString: displayString,
        reps: item.quantity.toString(),
        weight: item.weight.toString(),
        sets: item.sets.toString(),
      ));
    }

    return localItems;
  }
}
