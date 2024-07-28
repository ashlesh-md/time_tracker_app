import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/comment.dart';

class CommentsService {
  static const String _baseUrl = 'https://api.todoist.com/rest/v2/comments';
  static const String _token = 'c14ea7233c5c099a9ec5b2832a593470c737491a';

  Future<List<Comment>> fetchComments(String taskId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?task_id=$taskId'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      log(json.toString());
      log(taskId);
      return json.map((e) => Comment.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<void> addComment(Comment comment) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(comment.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add comment');
    }
  }

  Future<void> deleteComment(String commentId) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$commentId'),
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete comment');
    }
  }
}
