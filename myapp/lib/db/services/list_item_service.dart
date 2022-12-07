import 'package:myapp/db/db_builder.dart';
import 'package:myapp/model/exercises.dart';
import 'package:myapp/model/list_item.dart';

class ListItemsService {
  static final ListItemsService instance = ListItemsService._init();

  ListItemsService._init();

  Future<ListItem> create(ListItem listItem) async {
    print("create ListItem service ${listItem.toJson()}");

    final db = await DatabaseBuilder.instance.database;
    final id = await db.insert(tableListItems, listItem.toJson());
    print("create ListItem service ${id}");

    return listItem.copy(id: id);
  }

  Future<ListItem> readListItem(int id) async {
    final db = await DatabaseBuilder.instance.database;

    final maps = await db.query(
      tableListItems,
      columns: ListItemFields.values,
      where: '${ListItemFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ListItem.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ListItem>> readAllListItems() async {
    final db = await DatabaseBuilder.instance.database;

    const orderBy = '${ListItemFields.orderNum} ASC';

    final result = await db.query(tableListItems, orderBy: orderBy);

    return result.map((json) => ListItem.fromJson(json)).toList();
  }

  Future<List<ListItem>> readListItemsForListId(int listId) async {
    final db = await DatabaseBuilder.instance.database;

    const orderBy = '${ListItemFields.orderNum} ASC';

    final where = '${ListItemFields.listInstanceId} = $listId';

    final result =
        await db.query(tableListItems, orderBy: orderBy, where: where);

    return result.map((json) => ListItem.fromJson(json)).toList();
  }

  Future<int> update(ListItem listItem) async {
    final db = await DatabaseBuilder.instance.database;

    return db.update(
      tableListItems,
      listItem.toJson(),
      where: '${ListItemFields.id} = ?',
      whereArgs: [listItem.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseBuilder.instance.database;

    return await db.delete(
      tableListItems,
      where: '${ListItemFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await DatabaseBuilder.instance.database;

    db.close();
  }
}
