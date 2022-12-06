class LocalItem {
  String exerciseId;
  String exerciseName;
  String displayString;
  String reps;
  String weight;
  String sets;

  LocalItem({
    required this.exerciseId,
    required this.displayString,
    required this.exerciseName,
    required this.reps,
    required this.weight,
    required this.sets,
  });

  LocalItem copy(
          {String? exerciseId,
          String? exerciseName,
          String? displayString,
          String? reps,
          String? weight,
          String? sets,
          bool? selected}) =>
      LocalItem(
        exerciseId: exerciseId ?? this.exerciseId,
        exerciseName: exerciseName ?? this.exerciseName,
        displayString: displayString ?? this.displayString,
        reps: reps ?? this.reps,
        weight: weight ?? this.weight,
        sets: sets ?? this.sets,
      );
}
