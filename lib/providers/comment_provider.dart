import 'package:flutter/material.dart';
import '../models/comment.dart';
import '../services/comments_service.dart';

class CommentProvider extends ChangeNotifier {
  final CommentsService _apiService = CommentsService();

  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Future<void> fetchComments(String taskId) async {
    _comments = await _apiService.fetchComments(taskId);
    notifyListeners();
  }

  Future<void> addComment(Comment comment) async {
    await _apiService.addComment(comment);
    fetchComments(comment.taskId);
  }

  Future<void> deleteComment(String taskId, String commentId) async {
    await _apiService.deleteComment(commentId);
    fetchComments(taskId);
  }
}
