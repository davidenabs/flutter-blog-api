import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_api/Controller/Post.dart';
import 'package:todo_api/Model/Post.dart';
import 'package:todo_api/Screen/home.dart';
import 'package:todo_api/Service/Navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider<PostController>(create: (_)
        => PostController(NavigationService.instance))
    ],
    child: MaterialApp(
      navigatorKey: NavigationService.instance.navigationKey,
          title: 'Todo App',
          home: Home(),
        ),
  );
}
