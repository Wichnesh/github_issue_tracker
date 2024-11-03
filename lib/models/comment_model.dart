class Comment {
  final String author;
  final String createdAt;
  final String body;

  Comment({
    required this.author,
    required this.createdAt,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      author: json['user']['login'],
      createdAt: json['created_at'],
      body: json['body'],
    );
  }
}
