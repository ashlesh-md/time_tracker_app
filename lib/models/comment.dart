class Comment {
  final String? id;
  final String taskId;
  final String content;

  Comment({this.id, required this.taskId, required this.content});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      taskId: json['task_id'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'content': content,
    };
  }
}
