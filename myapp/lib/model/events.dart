// int? id,
//   int? templateId,
//   List<DateTime>? dates,
//   DateTime? startDate,
//   DateTime? endDate,
//   int? repeatInterval,
//   String? repeatDays,
//   List<DateTime>? exeptionUnassignedDates,

const String tableEvents = 'events';

class EventFields {
  static final List<String> values = [
    /// Add all fields
    id, templateId, dates, startDate, endDate, repeatInterval, repeatDays,
    exeptionUnassignedDates,
  ];

  static const String id = '_id';
  static const String templateId = 'templateId';
  static const String dates = 'dates';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
  static const String repeatInterval = 'repeatInterval';
  static const String repeatDays = 'repeatDays';
  static const String exeptionUnassignedDates = 'exeptionUnassignedDates';
}

class Event {
  final int? id;
  final int templateId;
  final List<DateTime>? dates;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? repeatInterval;
  final String? repeatDays;
  final List<DateTime>? exeptionUnassignedDates;

  Event({
    this.id,
    required this.templateId,
    this.dates,
    this.startDate,
    this.endDate,
    this.repeatInterval,
    this.repeatDays,
    this.exeptionUnassignedDates,
  });

  Event copy({
    int? id,
    int? templateId,
    List<DateTime>? dates,
    DateTime? startDate,
    DateTime? endDate,
    int? repeatInterval,
    String? repeatDays,
    List<DateTime>? exeptionUnassignedDates,
  }) =>
      Event(
        id: id ?? this.id,
        templateId: templateId ?? this.templateId,
        dates: dates ?? this.dates,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        repeatInterval: repeatInterval ?? this.repeatInterval,
        repeatDays: repeatDays ?? this.repeatDays,
        exeptionUnassignedDates:
            exeptionUnassignedDates ?? this.exeptionUnassignedDates,
      );

  static Event fromJson(Map<String, Object?> json) => Event(
        id: json[EventFields.id] as int?,
        templateId: json[EventFields.templateId] as int,
        dates: json[EventFields.dates] != null
            ? (json[EventFields.dates] as List)
                .map((e) => DateTime.parse(e as String))
                .toList()
            : null,
        startDate: json[EventFields.startDate] != null
            ? DateTime.parse(json[EventFields.startDate] as String)
            : null,
        endDate: json[EventFields.endDate] != null
            ? DateTime.parse(json[EventFields.endDate] as String)
            : null,
        repeatInterval: json[EventFields.repeatInterval] as int?,
        repeatDays: json[EventFields.repeatDays] as String?,
        exeptionUnassignedDates:
            json[EventFields.exeptionUnassignedDates] != null
                ? (json[EventFields.exeptionUnassignedDates] as List)
                    .map((e) => DateTime.parse(e as String))
                    .toList()
                : null,
      );

  Map<String, Object?> toJson() => {
        EventFields.id: id,
        EventFields.templateId: templateId,
        EventFields.dates: dates?.map((e) => e.toIso8601String()).toList(),
        EventFields.startDate: startDate?.toIso8601String(),
        EventFields.endDate: endDate?.toIso8601String(),
        EventFields.repeatInterval: repeatInterval,
        EventFields.repeatDays: repeatDays,
        EventFields.exeptionUnassignedDates:
            exeptionUnassignedDates?.map((e) => e.toIso8601String()).toList(),
      };
}
