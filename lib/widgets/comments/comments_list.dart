import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/comment_provider.dart';
import '../../models/comment.dart';

class CommentList extends StatefulWidget {
  final String taskId;
  const CommentList({Key? key, required this.taskId}) : super(key: key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final TextEditingController _controller = TextEditingController();
  var comments = [];

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  void _fetchComments() {
    Provider.of<CommentProvider>(context, listen: false)
        .fetchComments(widget.taskId);
  }

  void _addComment() {
    final content = _controller.text.trim();
    if (content.isNotEmpty) {
      final comment = Comment(taskId: widget.taskId, content: content);
      Provider.of<CommentProvider>(context, listen: false).addComment(comment);
      _controller.clear();
    }
  }

  void _deleteComment(String commentId) {
    Provider.of<CommentProvider>(context, listen: false)
        .deleteComment(widget.taskId, commentId);
  }

  @override
  Widget build(BuildContext context) {
    comments = Provider.of<CommentProvider>(context).comments;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    hintText: 'Enter comment',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _addComment,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: comments.length,
            reverse: true,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo.shade200, Colors.red.shade200],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comments[index].content,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteComment(comments[index].id!),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
