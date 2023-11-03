import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todo_api/Model/Post.dart';
import 'package:todo_api/Screen/create.dart';
import 'package:todo_api/Service/Api.dart';
import 'package:todo_api/Service/Navigation.dart';

class PostController extends ChangeNotifier {
  final NavigationService navigationService;

  PostController(this.navigationService) {
    fetchPost();
  }

  List<Post> posts = [];

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  _clearFields() {
    titleController.clear();
    bodyController.clear();
  }

  _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }

  // crud functions

  fetchPost() async {
    navigationService.loader();
    posts = await  PostApiService().getAll();
    navigationService.back();
    notifyListeners();
  }

  // This function handle the posting to the api
  save(BuildContext context) async {

    // loader
    navigationService.loader();

    if (formKey.currentState!.validate()) {
      isLoading = true;

      try {
        // Create a new Post object
        final newPost = Post(
          id: '101',
          title: titleController.text,
          body: bodyController.text,
        );

        await PostApiService().create(newPost);

        _showSnackBar(context,'Post added successfully!');

        posts.add(newPost);
        notifyListeners();

        _clearFields();

      } catch (error) {
        print('Error creating post: $error');
        _showSnackBar(context, 'Something went wrong!');
      } finally {
        isLoading = false;
        navigationService.back();
      }
    }
  }

  // This function handle the updating to the api
  Future<void> update(BuildContext context) async {


    if (formKey.currentState!.validate()) {
      // loader
      navigationService.loader();

      try {
        // Create a new Post object
        final newPost = Post(
          id: '1',
          title: titleController.text,
          body: bodyController.text,
        );

        await PostApiService().update(newPost);

        _showSnackBar(context, 'Post updated successfully!');

        _clearFields();
      } catch (error) {
        print('Error updating post: $error');
        _showSnackBar(context, 'Something went wrong!');
      } finally {
        navigationService.back();
      }
    }
  }

  deletePost(BuildContext context, Post post, index) async {
    // loader
    navigationService.loader();
    try {
      final deletedPost = await PostApiService().destroy(post.id);

      if (deletedPost == null) {
        print('Post deleted successfully');
        _showSnackBar(context, 'Deleted successfully!');
        posts.removeAt(index);
      } else {
        print('Unexpected response: $deletedPost');
        _showSnackBar(context, 'Something went wrong!');
      }
    } catch (error) {
      print('Error deleting post: $error');
    } finally {
      navigationService.back();
    }
  }

  // Route navigation
  create(context) {
    navigationService.navigate(CreatePost(null));
  }

  edit(context, Post post) {
    navigationService.navigate(CreatePost(post));
  }
}
