import 'package:flutter/material.dart';
import '../data/user_data.dart';
import '../data/post_data.dart';
import '../api/json_service.dart';
import 'post_detail_page.dart';

class PostListPage extends StatefulWidget {
  final User user;

  const PostListPage({super.key, required this.user});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  late Future<List<Post>> futurePosts;
  final JsonService jsonService = JsonService();

  @override
  void initState() {
    super.initState();
    futurePosts = jsonService.fetchPostsByUserId(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicaciones de ${widget.user.name}', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.teal));
          } else if (snapshot.hasError) {
            return Center(child: Text('❌ Error de red: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Este usuario no ha publicado nada.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Post post = snapshot.data![index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                child: ListTile(
                  title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                  trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.teal),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(post: post),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}