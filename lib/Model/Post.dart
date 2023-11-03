import 'package:flutter/cupertino.dart';

class Post {

  final String? id;
  final String title;
  final String body;

  Post({
    this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      id: json['id'].toString(),
      title: json['title'],
      body: json['body']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body
  };
}