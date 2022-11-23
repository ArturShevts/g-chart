import 'package:myapp/db/db_builder.dart';
import 'package:myapp/model/user.dart';

class UsersService {
  static final UsersService instance = UsersService._init();

  UsersService._init();

  Future<User> create(User user) async {
    final db = await DatabaseBuilder.instance.database;
    final id = await db.insert(tableUsers, user.toJson());
    return user.copy(id: id);
  }

  Future<User> readUser(int id) async {
    final db = await DatabaseBuilder.instance.database;

    final maps = await db.query(
      tableUsers,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<User>> readAllUsers() async {
    final db = await DatabaseBuilder.instance.database;

    const orderBy = '${UserFields.name} ASC';

    final result = await db.query(tableUsers, orderBy: orderBy);

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> update(User user) async {
    final db = await DatabaseBuilder.instance.database;

    return db.update(
      tableUsers,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseBuilder.instance.database;

    return await db.delete(
      tableUsers,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await DatabaseBuilder.instance.database;

    db.close();
  }
}
