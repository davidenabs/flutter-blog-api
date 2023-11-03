import 'package:flutter/material.dart';
import 'package:todo_api/Components/header.dart';
import 'package:todo_api/Model/Post.dart';
import 'package:todo_api/constants.dart';

class ShowTodo extends StatelessWidget {
  Post post;
  ShowTodo(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Container(
              margin: const EdgeInsets.all(defaultMargin),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Header(title: 'Post detail', fontSize: 20,),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        Text(post.body, style: const TextStyle(fontSize: 16),),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
