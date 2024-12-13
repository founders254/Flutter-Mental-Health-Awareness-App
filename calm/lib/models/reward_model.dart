class Reward {
  final String name;
  final int points;

  Reward({required this.name, required this.points});

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      name: json['name'],
      points: json['points'],
    );
  }
}
