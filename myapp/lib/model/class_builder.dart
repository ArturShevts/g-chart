// good for development, bad for speed

class ClassBuilder {}

mixin FromJson {
  fromJson(Map<String, Object?> json) => Object();
}

mixin ToJson {
  Map<String, Object?> toJson() => {};
}

mixin Copy {
  Map<String, Object?> toJson() => {};
}

class GenericDataClassFields {
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

class GenericDataClass {
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

  const GenericDataClass({
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

  GenericDataClass copy({
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
      GenericDataClass(
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

  fromJson(Map<String, Object?> json) => GenericDataClass(
        id: json[GenericDataClassFields.id] as int?,
        name: json[GenericDataClassFields.name] as String,
        aliases: json[GenericDataClassFields.aliases] as String?,
        primaryMuscles: json[GenericDataClassFields.primaryMuscles] as String?,
        secondaryMuscles:
            json[GenericDataClassFields.secondaryMuscles] as String?,
        force: json[GenericDataClassFields.force] as String?,
        level: json[GenericDataClassFields.level] as String,
        mechanic: json[GenericDataClassFields.mechanic] as String?,
        equipment: json[GenericDataClassFields.equipment] as String?,
        category: json[GenericDataClassFields.category] as String,
        instructions: json[GenericDataClassFields.instructions] as String?,
        description: json[GenericDataClassFields.description] as String?,
        tips: json[GenericDataClassFields.tips] as String?,
        dateUpdated: json[GenericDataClassFields.dateUpdated] != null
            ? DateTime.parse(json[GenericDataClassFields.dateUpdated] as String)
            : null,
        dateCreated: json[GenericDataClassFields.dateCreated] != null
            ? DateTime.parse(json[GenericDataClassFields.dateCreated] as String)
            : null,
      );

  Map<String, Object?> toJson() => {
        GenericDataClassFields.id: id,
        GenericDataClassFields.name: name,
        GenericDataClassFields.aliases: aliases,
        GenericDataClassFields.primaryMuscles: primaryMuscles,
        GenericDataClassFields.secondaryMuscles: secondaryMuscles,
        GenericDataClassFields.force: force,
        GenericDataClassFields.level: level,
        GenericDataClassFields.mechanic: mechanic,
        GenericDataClassFields.equipment: equipment,
        GenericDataClassFields.category: category,
        GenericDataClassFields.instructions: instructions,
        GenericDataClassFields.description: description,
        GenericDataClassFields.tips: tips,
        GenericDataClassFields.dateCreated: dateCreated?.toIso8601String(),
        GenericDataClassFields.dateUpdated: dateUpdated?.toIso8601String(),
      };
}
