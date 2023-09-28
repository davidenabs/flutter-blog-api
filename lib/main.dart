import 'package:flutter/material.dart';
import 'package:todo_api/Screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'Todo App',
        home: Home(),
      );
}
