class UserProfile{
  final String uid;
  final String name;
  final String email;
  final String goal;


  UserProfile({required this.uid, required this.name, required this.email, required this.goal});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      goal: json['goal'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'uid':uid,
      'name': name,
      'email': email,
      'goal': goal,
    };
  }
}