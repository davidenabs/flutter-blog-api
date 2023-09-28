import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:todo_api/Model/Post.dart';

class PostApiService {

  Future<List<Post>> getAll() async {
    const url = 'https://jsonplaceholder.typicode.com/posts';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Posts fetched!!');
      final List<dynamic> jsonList = json.decode(response.body);
      final List<Post> posts = jsonList.map((json) => Post.fromJson(json)).toList();
      return posts;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Post> create(Post post) async {
    const url = 'https://jsonplaceholder.typicode.com/posts';
    final response = await http.post(Uri.parse(url), body: post.toJson());

    if (response.statusCode == 201) {
      print('Post added successfully');
      return Post.fromJson(json.decode(response.body));
    } else {
    }
      throw Exception('Failed to add post');
  }

  Future<Post> show(String postId) async {
    final url = 'https://jsonplaceholder.typicode.com/posts/$postId';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 201) {
      print('');
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add post');
    }
  }

  Future<Post> update(Post post) async {
    final url = 'https://jsonplaceholder.typicode.com/posts/${post.id}';
    final response = await http.put(Uri.parse(url), body: post.toJson());

    if (response.statusCode == 200) {
      print('Post updated successfully');
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<Post?>? destroy(postId) async {
    final url = 'https://jsonplaceholder.typicode.com/posts/$postId';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Deleted successfully') ;
      return null;
    } else {
      throw Exception('Failed to delete post');
    }
  }
}