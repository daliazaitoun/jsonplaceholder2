import 'package:flutter/material.dart';
import 'api_service.dart';
class CommentsPage extends StatelessWidget {
  final int postId;

  CommentsPage({required this.postId});

  final  apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments for Post $postId')),
      body: FutureBuilder<List<dynamic>>(
        future: apiService.fetchComments(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No comments found.'));
          }

          final commentsList = snapshot.data!;

          return ListView.builder(
            itemCount: commentsList.length,
            itemBuilder: (context, index) {
              final comment = commentsList[index];
              return ListTile(
                title: Text(comment['name']),
                subtitle: Text(comment['body']),
              );
            },
          );
        },
      ),
    );
  }
}
