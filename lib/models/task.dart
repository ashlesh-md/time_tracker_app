class Task {
  String? id;
  String? content;
  String? description;
  bool? isCompleted;
  int? commentCount;
  String? createdAt;
  int timespent;

  Task({
    this.id,
    this.content,
    this.description,
    this.isCompleted,
    this.commentCount,
    this.createdAt,
    this.timespent = 0,
  });

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        description = json['description'],
        isCompleted = json['is_completed'],
        commentCount = json['comment_count'],
        createdAt = json['created_at'],
        timespent =
            json['timespent'] ?? 0; // Initialize from JSON or default to 0

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['description'] = description;
    data['is_completed'] = isCompleted;
    data['comment_count'] = commentCount;
    data['created_at'] = createdAt;
    data['timespent'] = timespent;
    return data;
  }
}
