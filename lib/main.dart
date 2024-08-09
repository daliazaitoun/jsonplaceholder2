import 'package:flutter/material.dart';
import 'package:placeholder_example/pages/list_post.dart';
import 'package:placeholder_example/provider/provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(providers:  [
     ChangeNotifierProvider<PostProvider>(create: (_) => PostProvider())
  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: PostListScreen(),
      ),
    );
  }
}
