import 'package:flutter/material.dart';
import 'package:todo_api/Components/header.dart';
import 'package:todo_api/Model/Post.dart';
import 'package:todo_api/Screen/create.dart';
import 'package:todo_api/Screen/show.dart';
import 'package:todo_api/Service/Api.dart';
import 'package:todo_api/constants.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? selectedMenu;
  var postService = PostApiService();

  void _deletePost(Post post) async {
    try {
      final deletedPost = await postService.destroy(post.id);

      if (deletedPost == null) {
        print('Post deleted successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Deleted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
        postService.getAll();
      } else {
        print('Unexpected response: $deletedPost');
      }
    } catch (error) {
      print('Error deleting post: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.brown, borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreatePost(null)));
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add a post',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Container(
              margin: const EdgeInsets.all(defaultMargin),
              child: Stack(
                children: [
                  Header(title: 'Blog posts', fontSize: 30),
                  Container(
                    margin: const EdgeInsets.only(top: 70),
                    child: FutureBuilder<List<Post>>(
                        future: postService.getAll(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                                    color: primaryColor));
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No posts available.'));
                          } else {
                            final List<Post> posts = snapshot.data!;
                            return ListView.builder(
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                final post = posts[index];
                                return Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowTodo(post)));
                                    },
                                    title: Text(post.title),
                                    subtitle: Text(post.body),
                                    trailing: PopupMenuButton<int>(
                                      initialValue: 1,
                                      // Callback that sets the selected popup menu item.
                                      onSelected: (selected) async {
                                        if (selected == 1) {
                                          //   edit post
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreatePost(post)));
                                        } else if (selected == 2) {
                                          //   delete post
                                          _deletePost(post);
                                        }
                                      },
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<int>>[
                                        const PopupMenuItem<int>(
                                          value: 1,
                                          child: Text('Edit'),
                                        ),
                                        const PopupMenuItem<int>(
                                          value: 2,
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
