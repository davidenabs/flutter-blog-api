import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_api/Components/header.dart';
import 'package:todo_api/Controller/Post.dart';
import 'package:todo_api/Model/Post.dart';
import 'package:todo_api/Service/Api.dart';
import 'package:todo_api/constants.dart';

class CreatePost extends StatefulWidget {
  Post? post;
  CreatePost(this.post, {super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  @override
  Widget build(BuildContext context) {

    final postController = Provider.of<PostController>(context);

    if (widget.post != null) {
      postController.titleController.text = widget.post!.title;
      postController.bodyController.text = widget.post!.body;
    }

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
                      Header(title: 'Add a post', fontSize: 20),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Form(
                        key: postController.formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: postController.titleController,
                              decoration:
                                  const InputDecoration(labelText: 'Title'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a title';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: defaultMargin),
                            TextFormField(
                              controller: postController.bodyController,
                              maxLines: null,
                              decoration:
                                  const InputDecoration(labelText: 'Body'),
                            ),
                            const SizedBox(height: defaultMargin),
                            InkWell(
                              onTap: () {
                                if (widget.post != null) {
                                  postController.update(context);
                                } else {
                                  postController.save(context);
                                }
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(18),
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.brown,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: postController.isLoading
                                      ? const SizedBox(
                                          height: 17.5,
                                          width: 17.5,
                                          child: CircularProgressIndicator(
                                            color: lightColor,
                                            strokeWidth: 2.0,
                                          ))
                                      : Text(
                                          widget.post != null
                                              ? 'Update post'
                                              : 'Add a post',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
