class WeeklyHabitData {
  final String weekday;
  final int dayIndex; // 0 = Monday, 6 = Sunday
  final double completionPercentage; // 0-100%
  final DateTime date;
  final int completedHabits;
  final int totalHabits;
  final List<String> completedHabitNames;

  WeeklyHabitData({
    required this.weekday,
    required this.dayIndex,
    required this.completionPercentage,
    required this.date,
    required this.completedHabits,
    required this.totalHabits,
    required this.completedHabitNames,
  });

  factory WeeklyHabitData.fromJson(Map<String, dynamic> json) {
    return WeeklyHabitData(
      weekday: json['weekday'] as String,
      dayIndex: json['dayIndex'] as int,
      completionPercentage: json['completionPercentage'] as double,
      date: DateTime.parse(json['date'] as String),
      completedHabits: json['completedHabits'] as int,
      totalHabits: json['totalHabits'] as int,
      completedHabitNames: List<String>.from(json['completedHabitNames'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weekday': weekday,
      'dayIndex': dayIndex,
      'completionPercentage': completionPercentage,
      'date': date.toIso8601String(),
      'completedHabits': completedHabits,
      'totalHabits': totalHabits,
      'completedHabitNames': completedHabitNames,
    };
  }

  WeeklyHabitData copyWith({
    String? weekday,
    int? dayIndex,
    double? completionPercentage,
    DateTime? date,
    int? completedHabits,
    int? totalHabits,
    List<String>? completedHabitNames,
  }) {
    return WeeklyHabitData(
      weekday: weekday ?? this.weekday,
      dayIndex: dayIndex ?? this.dayIndex,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      date: date ?? this.date,
      completedHabits: completedHabits ?? this.completedHabits,
      totalHabits: totalHabits ?? this.totalHabits,
      completedHabitNames: completedHabitNames ?? this.completedHabitNames,
    );
  }
}