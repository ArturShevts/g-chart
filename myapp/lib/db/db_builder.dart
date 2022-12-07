import 'package:myapp/db/db_migrate.dart';
import 'package:myapp/model/events.dart';
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

    _database = await _initDB('notes60.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print("inti db _______ $path");
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS $tableNotes');
    await db.execute('DROP TABLE IF EXISTS $tableExercises');
    await db.execute('DROP TABLE IF EXISTS $tableListInstances');
    await db.execute('DROP TABLE IF EXISTS $tableListItems');
    await db.execute('DROP TABLE IF EXISTS $tableUsers');

    await db.execute(foreignKeysOn);
    await db.execute(notesCreateQuery);
    await db.execute(usersCreateQuery);
    await db.execute(exercisesCreateQuery);
    await db.execute(listInstanceCreateQuery);
    await db.execute(listItemCreateQuery);
    await db.execute(eventsCreateQuery);
    // await db.execute(listInstanceFillWithDummyDataQuery);
    await db.execute(listItemFillWithDummyDataQuery);
    await db.execute(exercisesInsertDataQuery);
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

  final String foreignKeysOn = 'PRAGMA foreign_keys = ON';

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
  ${ListInstanceFields.repeatEvery} INTEGER,
  FOREIGN KEY (${ListInstanceFields.userId}) REFERENCES $tableUsers(${UserFields.id}) ON DELETE CASCADE
)
''';

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
  ${ListItemFields.orderNum} INTEGER NOT NULL,
  FOREIGN KEY (${ListItemFields.userId}) REFERENCES $tableUsers(${UserFields.id}) ON DELETE CASCADE,
  FOREIGN KEY (${ListItemFields.listInstanceId}) REFERENCES $tableListInstances(${ListInstanceFields.id}) ON DELETE CASCADE,
  FOREIGN KEY (${ListItemFields.exerciseId}) REFERENCES $tableExercises(${ExerciseFields.id}) ON DELETE SET DEFAULT
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

// delete table exercises if exists then create it
  final String exercisesCreateQuery = '''
 CREATE TABLE $tableExercises (
  ${ExerciseFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${ExerciseFields.name} TEXT NOT NULL,
  ${ExerciseFields.aliases} TEXT,
  ${ExerciseFields.primaryMuscles} TEXT,
  ${ExerciseFields.secondaryMuscles} TEXT,
  ${ExerciseFields.force} TEXT,
  ${ExerciseFields.level} TEXT NOT NULL,
  ${ExerciseFields.mechanic} TEXT,
  ${ExerciseFields.equipment} TEXT,
  ${ExerciseFields.category} TEXT NOT NULL,
  ${ExerciseFields.instructions} TEXT,
  ${ExerciseFields.description} TEXT,
  ${ExerciseFields.tips} TEXT,
  ${ExerciseFields.dateCreated} TEXT,
  ${ExerciseFields.dateUpdated} TEXT
)
''';

  final String eventsCreateQuery = '''
CREATE TABLE $tableEvents (
  ${EventFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${EventFields.templateId} INTEGER NOT NULL,
  ${EventFields.dates} TEXT,
  ${EventFields.startDate} TEXT,
  ${EventFields.endDate} TEXT,
  ${EventFields.repeatInterval} INTEGER,
  ${EventFields.repeatDays} TEXT,
  ${EventFields.exeptionUnassignedDates} TEXT,
  FOREIGN KEY (${EventFields.templateId}) REFERENCES $tableListInstances(${ListInstanceFields.id}) ON DELETE CASCADE
)
''';
}
