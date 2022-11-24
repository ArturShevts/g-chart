import 'package:myapp/db/db_builder.dart';
import 'package:myapp/db/services/exercises_service.dart';
import 'package:myapp/db/services/list_item_service.dart';
import 'package:myapp/model/exercises.dart';
import 'package:myapp/model/list_item.dart';
import '../../model/list_instance.dart';

class ListInstancesService {
  static final ListInstancesService instance = ListInstancesService._init();

  ListInstancesService._init();

  Future<ListInstance> create(ListInstance listInstance) async {
    final db = await DatabaseBuilder.instance.database;
    final id = await db.insert(tableListInstances, listInstance.toJson());
    return listInstance.copy(id: id);
  }

  Future<ListInstance> readListInstance(int id) async {
    final db = await DatabaseBuilder.instance.database;

    final maps = await db.query(
      tableListInstances,
      columns: ListInstanceFields.values,
      where: '${ListInstanceFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ListInstance.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ListInstance>> readAllListInstances() async {
    final db = await DatabaseBuilder.instance.database;

    const orderBy = '${ListInstanceFields.createdTime} ASC';

    final result = await db.query(tableListInstances, orderBy: orderBy);

    return result.map((json) => ListInstance.fromJson(json)).toList();
  }

  Future<List<ListInstance>> readAllAssignedListInstances() async {
    final db = await DatabaseBuilder.instance.database;

    const orderBy = '${ListInstanceFields.createdTime} ASC';
    const where = '${ListInstanceFields.assignedTime} IS NOT NULL';

    final result =
        await db.query(tableListInstances, orderBy: orderBy, where: where);

    return result.map((json) => ListInstance.fromJson(json)).toList();
  }

  Future<ListInstance> readPopulatedListInstance(int listInstanceId) async {
    final db = await DatabaseBuilder.instance.database;

    ListInstance listInstance = await readListInstance(listInstanceId);
    List<ListItem> listItems =
        await ListItemsService.instance.readListItemsForListId(listInstanceId);
    listInstance.listItems = [];

    for (var listItem in listItems) {
      final exercises =
          await ExercisesService.instance.readExercise(listItem.id!);
      listItem.exercise = exercises;
      listInstance.listItems!.add(listItem);
    }

    return listInstance;
  }

  Future<int> update(ListInstance listInstance) async {
    final db = await DatabaseBuilder.instance.database;

    return db.update(
      tableListInstances,
      listInstance.toJson(),
      where: '${ListInstanceFields.id} = ?',
      whereArgs: [listInstance.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseBuilder.instance.database;

    return await db.delete(
      tableListInstances,
      where: '${ListInstanceFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await DatabaseBuilder.instance.database;

    db.close();
  }
}
