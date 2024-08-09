import 'package:flutter/material.dart';
import 'package:placeholder_example/pages/list_comment.dart';
import 'package:placeholder_example/provider/provider.dart';
import 'package:provider/provider.dart';


class PostListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: FutureBuilder(
        future: postProvider.fetchPosts(),
        builder: (context, snapshot) {
         
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return ListView.builder(
            itemCount: postProvider.posts.length,
            itemBuilder: (context, index) {
              final post = postProvider.posts[index];
              return ListTile(
                title: Text(post.title ?? "No Title"),
                subtitle: Text(post.body ?? "No Body"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentListScreen(postId: post.id ?? 0),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
