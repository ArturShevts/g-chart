import 'package:myapp/model/exercises.dart';
import 'package:myapp/model/list_instance.dart';
import 'package:myapp/model/list_item.dart';
import 'package:myapp/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/note.dart';

class DatabaseBuilder {
  static final DatabaseBuilder instance = DatabaseBuilder._init();
  static Database? _database;

  DatabaseBuilder._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes24.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print("inti db __ $path");
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(notesCreateQuery);
    await db.execute(listInstanceCreateQuery);
    await db.execute(listItemCreateQuery);
    await db.execute(usersCreateQuery);
    await db.execute(exercisesCreateQuery);
    await db.execute(listInstanceFillWithDummyDataQuery);
    await db.execute(listItemFillWithDummyDataQuery);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      _createDB(db, newVersion);
      await db.execute(
          '''ALTER TABLE $tableNotes ADD COLUMN ${NoteFields.isImportant} BOOLEAN NOT NULL DEFAULT 0''');
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  final String notesCreateQuery = '''
CREATE TABLE $tableNotes (
  ${NoteFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${NoteFields.isImportant} BOOLEAN NOT NULL DEFAULT 0,
  ${NoteFields.number} INTEGER NOT NULL,
  ${NoteFields.title} TEXT NOT NULL,
  ${NoteFields.description} TEXT NOT NULL,
  ${NoteFields.time} TEXT NOT NULL
)
''';

  final String listInstanceCreateQuery = '''
CREATE TABLE $tableListInstances (
  ${ListInstanceFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${ListInstanceFields.title} TEXT NOT NULL,
  ${ListInstanceFields.description} TEXT NOT NULL,
  ${ListInstanceFields.userId} INTEGER NOT NULL,
  ${ListInstanceFields.createdTime} TEXT NOT NULL,
  ${ListInstanceFields.assignedTime} TEXT,
  ${ListInstanceFields.startedTime} TEXT,
  ${ListInstanceFields.finishedTime} TEXT,
  ${ListInstanceFields.isCompleted} BOOLEAN NOT NULL DEFAULT 0,
  ${ListInstanceFields.isPublic} BOOLEAN NOT NULL DEFAULT 0,
  ${ListInstanceFields.isTemplate} BOOLEAN NOT NULL DEFAULT 0,
  ${ListInstanceFields.repeatOn} TEXT,
  ${ListInstanceFields.repeatEvery} INTEGER
)
''';

  final String listInstanceFillWithDummyDataQuery = '''
INSERT INTO  $tableListInstances (
  ${ListInstanceFields.userId},
  ${ListInstanceFields.title},
  ${ListInstanceFields.description},
  ${ListInstanceFields.createdTime},
  ${ListInstanceFields.assignedTime},
  ${ListInstanceFields.startedTime},
  ${ListInstanceFields.finishedTime},
  ${ListInstanceFields.isCompleted},
  ${ListInstanceFields.isPublic},
  ${ListInstanceFields.isTemplate},
  ${ListInstanceFields.repeatOn},
  ${ListInstanceFields.repeatEvery}
) VALUES (
  1,
  'Back',
  'Test List Description',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  false,
  false,
  0,
  '6',
  null
), (
  2,
  'Chest',
  'Test List Description',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  false,
  false,
  0,
  '6',
  null
),
 (
  3,
  'Arms',
  'Test List Description',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  false,
  false,
  0,
  '36',
  null
),
 (
  4,
  'Legs',
  'Test List Description',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  '2021-01-01 00:00:00',
  false,
  false,
  0,
  '13',
  null
)
''';
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
  final String listItemCreateQuery = '''
CREATE TABLE $tableListItems (
  ${ListItemFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${ListItemFields.listInstanceId} INTEGER NOT NULL,
  ${ListItemFields.listItemId} INTEGER NOT NULL,
  ${ListItemFields.userId} INTEGER NOT NULL,
  ${ListItemFields.exerciseId} INTEGER NOT NULL,
  ${ListItemFields.sets} INTEGER,
  ${ListItemFields.quantity} INTEGER,
  ${ListItemFields.weight} INTEGER,
  ${ListItemFields.isCompleted} BOOLEAN NOT NULL DEFAULT 0,
  ${ListItemFields.orderNum} INTEGER NOT NULL
)
''';

  final String listItemFillWithDummyDataQuery = '''
INSERT INTO  $tableListItems (
  ${ListItemFields.listInstanceId},
  ${ListItemFields.listItemId},
  ${ListItemFields.userId},
  ${ListItemFields.exerciseId},
  ${ListItemFields.sets},
  ${ListItemFields.quantity},
  ${ListItemFields.weight},
  ${ListItemFields.isCompleted},
  ${ListItemFields.orderNum}

) VALUES (
  1,
  1,
  1,
  1,
  3,
  10,
  15,
  false,
  1
), (
  1,
  2,
  1,
  2,
  3,
  20,
  10,
  false,
  2
), (
  1,
  3,
  1,
  3,
  3,
  12,
  10,
  false,
  3
), (
  2,  
  4,
  2,
  4,
  3,
  10,
  15,
  false,
  4
), (
  2,
  5,
  2,
  5,
  3,
  20,
  10,
  false,
  5
  )
''';

  final String usersCreateQuery = '''
CREATE TABLE $tableUsers (
  ${UserFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${UserFields.name} TEXT NOT NULL,
  ${UserFields.email} TEXT NOT NULL,
  ${UserFields.password} TEXT NOT NULL,
  ${UserFields.username} TEXT NOT NULL,
  ${UserFields.createdAt} TEXT NOT NULL,
  ${UserFields.updatedAt} TEXT NOT NULL,
  ${UserFields.deletedAt} TEXT,
  ${UserFields.profilePicture} TEXT
)
''';

  final String exercisesCreateQuery = '''
CREATE TABLE exercises (
  ${ExerciseFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${ExerciseFields.name} TEXT NOT NULL,
  ${ExerciseFields.sets} INTEGER,
  ${ExerciseFields.quantity} INTEGER,
  ${ExerciseFields.weight} INTEGER,
  ${ExerciseFields.restTime} INTEGER,
  ${ExerciseFields.description} TEXT,
  ${ExerciseFields.videoUrl} TEXT,
  ${ExerciseFields.primaryMuscleGroup} TEXT,
  ${ExerciseFields.secondaryMuscleGroup} TEXT,
  ${ExerciseFields.tertiaryMuscleGroup} TEXT,
  ${ExerciseFields.equipment} TEXT,
  ${ExerciseFields.level} TEXT,
  ${ExerciseFields.type} TEXT
)
''';
}
