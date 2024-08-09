import 'package:flutter/material.dart';
import 'package:placeholder_example/models/comment_model.dart';
import 'package:placeholder_example/provider/provider.dart';
import 'package:provider/provider.dart';

class CommentListScreen extends StatelessWidget {
  final int postId;

  CommentListScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Comments')),
      body: FutureBuilder(
        future: postProvider.fetchComments(postId),
        builder: (context, snapshot) {
        
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return ListView.builder(
            itemCount: postProvider.comments.length,
            itemBuilder: (context, index) {
              final comment = postProvider.comments[index];
              return ListTile(
                title: Text(comment.name ?? "No Name"),
                subtitle: Text(comment.body ?? "No Body"),
              );
            },
          );
        },
      ),
    );
  }
}
