// exercises
// int? id;
// String name;
// String? aliases;
// String? primaryMuscles;
// String? secondaryMuscles;
// String? force;
// String level;
// String? mechanic;
// String? equipment;
// String category;
// String? instructions;
// String? description;
// String? tips;
// DateTime dateCreated;
//  DateTime dateUpdated;

const String tableExercises = 'exercises';

class ExerciseFields {
  static final List<String> values = [
    /// Add all fields
    id, name, aliases, primaryMuscles, secondaryMuscles, force, level, mechanic,
    equipment, category, instructions, description, tips, dateCreated,
    dateUpdated
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String aliases = 'aliases';
  static const String primaryMuscles = 'primaryMuscles';
  static const String secondaryMuscles = 'secondaryMuscles';
  static const String force = 'force';
  static const String level = 'level';
  static const String mechanic = 'mechanic';
  static const String equipment = 'equipment';
  static const String category = 'category';
  static const String instructions = 'instructions';
  static const String description = 'description';
  static const String tips = 'tips';
  static const String dateCreated = 'dateCreated';
  static const String dateUpdated = 'dateUpdated';
}

class Exercise {
  final int? id;
  final String name;
  final String? aliases;
  final String? primaryMuscles;
  final String? secondaryMuscles;
  final String? force;
  final String level;
  final String? mechanic;
  final String? equipment;
  final String category;
  final String? instructions;
  final String? description;
  final String? tips;
  final DateTime? dateCreated;
  final DateTime? dateUpdated;

  const Exercise({
    this.id,
    required this.name,
    this.aliases,
    this.primaryMuscles,
    this.secondaryMuscles,
    this.force,
    required this.level,
    this.mechanic,
    this.equipment,
    required this.category,
    this.instructions,
    this.description,
    this.tips,
    this.dateCreated,
    this.dateUpdated,
  });

  Exercise copy({
    int? id,
    String? name,
    String? aliases,
    String? primaryMuscles,
    String? secondaryMuscles,
    String? force,
    String? level,
    String? mechanic,
    String? equipment,
    String? category,
    String? instructions,
    String? description,
    String? tips,
    DateTime? dateCreated,
    DateTime? dateUpdated,
  }) =>
      Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        aliases: aliases ?? this.aliases,
        primaryMuscles: primaryMuscles ?? this.primaryMuscles,
        secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
        force: force ?? this.force,
        level: level ?? this.level,
        mechanic: mechanic ?? this.mechanic,
        equipment: equipment ?? this.equipment,
        category: category ?? this.category,
        instructions: instructions ?? this.instructions,
        description: description ?? this.description,
        tips: tips ?? this.tips,
        dateCreated: dateCreated ?? this.dateCreated,
        dateUpdated: dateUpdated ?? this.dateUpdated,
      );

  static Exercise fromJson(Map<String, Object?> json) => Exercise(
        id: json[ExerciseFields.id] as int?,
        name: json[ExerciseFields.name] as String,
        aliases: json[ExerciseFields.aliases] as String?,
        primaryMuscles: json[ExerciseFields.primaryMuscles] as String?,
        secondaryMuscles: json[ExerciseFields.secondaryMuscles] as String?,
        force: json[ExerciseFields.force] as String?,
        level: json[ExerciseFields.level] as String,
        mechanic: json[ExerciseFields.mechanic] as String?,
        equipment: json[ExerciseFields.equipment] as String?,
        category: json[ExerciseFields.category] as String,
        instructions: json[ExerciseFields.instructions] as String?,
        description: json[ExerciseFields.description] as String?,
        tips: json[ExerciseFields.tips] as String?,
        dateUpdated: json[ExerciseFields.dateUpdated] != null
            ? DateTime.parse(json[ExerciseFields.dateUpdated] as String)
            : null,
        dateCreated: json[ExerciseFields.dateCreated] != null
            ? DateTime.parse(json[ExerciseFields.dateCreated] as String)
            : null,
      );

  Map<String, Object?> toJson() => {
        ExerciseFields.id: id,
        ExerciseFields.name: name,
        ExerciseFields.aliases: aliases,
        ExerciseFields.primaryMuscles: primaryMuscles,
        ExerciseFields.secondaryMuscles: secondaryMuscles,
        ExerciseFields.force: force,
        ExerciseFields.level: level,
        ExerciseFields.mechanic: mechanic,
        ExerciseFields.equipment: equipment,
        ExerciseFields.category: category,
        ExerciseFields.instructions: instructions,
        ExerciseFields.description: description,
        ExerciseFields.tips: tips,
        ExerciseFields.dateCreated: dateCreated?.toIso8601String(),
        ExerciseFields.dateUpdated: dateUpdated?.toIso8601String(),
      };
}
