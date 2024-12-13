class Mood {
  final DateTime date;
  final String mood;

  Mood({required this.date, required this.mood});

  factory Mood.fromJson(Map<String, dynamic> json) {
    return Mood(
      date: DateTime.parse(json['date']),
      mood: json['mood'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'mood': mood,
    };
  }
}