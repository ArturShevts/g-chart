// exercises
// int? id;
// String name;
// int? sets;
// int? quantity;
// int? weight;
// int? restTime;
// String? description;
// String? videoUrl;
// String? primaryMuscleGroup;
// String? secondaryMuscleGroup;
// String? TertiaryMuscleGroup;
// String? equipment;
// String? level;
// String? type;

const String tableExercises = 'exercises';

class ExerciseFields {
  static final List<String> values = [
    /// Add all fields
    id, name, sets, quantity, weight, restTime, description, videoUrl,
    primaryMuscleGroup, secondaryMuscleGroup, tertiaryMuscleGroup, equipment,
    level, type
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String sets = 'sets';
  static const String quantity = 'quantity';
  static const String weight = 'weight';
  static const String restTime = 'restTime';
  static const String description = 'description';
  static const String videoUrl = 'videoUrl';
  static const String primaryMuscleGroup = 'primaryMuscleGroup';
  static const String secondaryMuscleGroup = 'secondaryMuscleGroup';
  static const String tertiaryMuscleGroup = 'TertiaryMuscleGroup';
  static const String equipment = 'equipment';
  static const String level = 'level';
  static const String type = 'type';
}

class Exercise {
  final int? id;
  final String name;
  final int? sets;
  final int? quantity;
  final int? weight;
  final int? restTime;
  final String? description;
  final String? videoUrl;
  final String? primaryMuscleGroup;
  final String? secondaryMuscleGroup;
  final String? tertiaryMuscleGroup;
  final String? equipment;
  final String? level;
  final String? type;

  const Exercise({
    this.id,
    required this.name,
    this.sets,
    this.quantity,
    this.weight,
    this.restTime,
    this.description,
    this.videoUrl,
    this.primaryMuscleGroup,
    this.secondaryMuscleGroup,
    this.tertiaryMuscleGroup,
    this.equipment,
    this.level,
    this.type,
  });

  Exercise copy({
    int? id,
    String? name,
    int? sets,
    int? quantity,
    int? weight,
    int? restTime,
    String? description,
    String? videoUrl,
    String? primaryMuscleGroup,
    String? secondaryMuscleGroup,
    String? tertiaryMuscleGroup,
    String? equipment,
    String? level,
    String? type,
  }) =>
      Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        sets: sets ?? this.sets,
        quantity: quantity ?? this.quantity,
        weight: weight ?? this.weight,
        restTime: restTime ?? this.restTime,
        description: description ?? this.description,
        videoUrl: videoUrl ?? this.videoUrl,
        primaryMuscleGroup: primaryMuscleGroup ?? this.primaryMuscleGroup,
        secondaryMuscleGroup: secondaryMuscleGroup ?? this.secondaryMuscleGroup,
        tertiaryMuscleGroup: tertiaryMuscleGroup ?? this.tertiaryMuscleGroup,
        equipment: equipment ?? this.equipment,
        level: level ?? this.level,
        type: type ?? this.type,
      );

  static Exercise fromJson(Map<String, Object?> json) => Exercise(
        id: json[ExerciseFields.id] as int?,
        name: json[ExerciseFields.name] as String,
        sets: json[ExerciseFields.sets] as int?,
        quantity: json[ExerciseFields.quantity] as int?,
        weight: json[ExerciseFields.weight] as int?,
        restTime: json[ExerciseFields.restTime] as int?,
        description: json[ExerciseFields.description] as String?,
        videoUrl: json[ExerciseFields.videoUrl] as String?,
        primaryMuscleGroup: json[ExerciseFields.primaryMuscleGroup] as String?,
        secondaryMuscleGroup:
            json[ExerciseFields.secondaryMuscleGroup] as String?,
        tertiaryMuscleGroup:
            json[ExerciseFields.tertiaryMuscleGroup] as String?,
        equipment: json[ExerciseFields.equipment] as String?,
        level: json[ExerciseFields.level] as String?,
        type: json[ExerciseFields.type] as String?,
      );

  Map<String, Object?> toJson() => {
        ExerciseFields.id: id,
        ExerciseFields.name: name,
        ExerciseFields.sets: sets,
        ExerciseFields.quantity: quantity,
        ExerciseFields.weight: weight,
        ExerciseFields.restTime: restTime,
        ExerciseFields.description: description,
        ExerciseFields.videoUrl: videoUrl,
        ExerciseFields.primaryMuscleGroup: primaryMuscleGroup,
        ExerciseFields.secondaryMuscleGroup: secondaryMuscleGroup,
        ExerciseFields.tertiaryMuscleGroup: tertiaryMuscleGroup,
        ExerciseFields.equipment: equipment,
        ExerciseFields.level: level,
        ExerciseFields.type: type,
      };
}
