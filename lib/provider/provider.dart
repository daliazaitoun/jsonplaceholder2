import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:placeholder_example/models/comment_model.dart';
import 'package:placeholder_example/models/post_model.dart';


class PostProvider with ChangeNotifier {
  final Dio _dio = Dio();
  List<Post> _posts = [];
  List<Comment> _comments = [];

  List<Post> get posts => _posts;
  List<Comment> get comments => _comments;

  Future<void> fetchPosts() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');
      List<dynamic> data = response.data;
      _posts = data.map((json) => Post.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }

  Future<void> fetchComments(int postId) async {
    try {
      final response = await _dio
          .get('https://jsonplaceholder.typicode.com/posts/$postId/comments');
      List<dynamic> data = response.data;
      _comments = data.map((json) => Comment.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }
}
