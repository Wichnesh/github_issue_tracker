class Issue {
  final String title;
  final int number;
  final String createdAt;
  final String author;
  final String? closedAt;
  final String url;

  Issue({
    required this.title,
    required this.number,
    required this.createdAt,
    required this.author,
    this.closedAt,
    required this.url,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      title: json['title'],
      number: json['number'],
      createdAt: json['created_at'],
      author: json['user']['login'],
      closedAt: json['closed_at'],
      url: json['html_url'],
    );
  }
}
