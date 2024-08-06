import 'package:flutter/material.dart';
import 'package:placeholder_example/comments_page.dart';
import 'api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSONPlaceholder Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PostsPage(),
    );
  }
}

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> posts;

  @override
  void initState() {
    super.initState();
    posts = apiService.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: FutureBuilder<List<dynamic>>(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts found.'));
          }

          final postList = snapshot.data!;

          return ListView.builder(
            itemCount: postList.length,
            itemBuilder: (context, index) {
              final post = postList[index];
              return ListTile(
                title: Text(post['title']),
                subtitle: Text(post['body']),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentsPage(postId: post['id']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
