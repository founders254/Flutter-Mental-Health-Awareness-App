class Resource {
  final String title;
  final String type; // e.g., "article", "video", "meditation"
  final String url;

  Resource({required this.title, required this.type, required this.url});

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      title: json['title'],
      type: json['type'],
      url: json['url'],
    );
  }
}
