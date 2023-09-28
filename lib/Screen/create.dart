import 'package:flutter/material.dart';
import 'package:todo_api/Components/header.dart';
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
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }

  void _clearFields() {
    titleController.clear();
    bodyController.clear();
  }

  // This function handle the posting to the api
  Future<void> _save() async {
    if (isLoading) {
      return;
    }
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        // Create a new Post object
        final newPost = Post(
          id: '',
          title: titleController.text,
          body: bodyController.text,
        );

        await PostApiService().create(newPost);

        _showSnackBar('Post added successfully!');

        _clearFields();
      } catch (error) {
        print('Error creating post: $error');
        _showSnackBar('Something went wrong!');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // This function handle the updating to the api
  Future<void> _update() async {
    if (isLoading) {
      return;
    }
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        // Create a new Post object
        final newPost = Post(
          id: '1',
          title: titleController.text,
          body: bodyController.text,
        );

        await PostApiService().update(newPost);

        _showSnackBar('Post updated successfully!');

        _clearFields();
      } catch (error) {
        print('Error updating post: $error');
        _showSnackBar('Something went wrong!');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.post != null) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
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
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: titleController,
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
                              controller: bodyController,
                              maxLines: null,
                              decoration:
                                  const InputDecoration(labelText: 'Body'),
                            ),
                            const SizedBox(height: defaultMargin),
                            InkWell(
                              onTap: () {
                                if (widget.post != null) {
                                  _update();
                                } else {
                                  _save();
                                }
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(18),
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.brown,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: isLoading
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
