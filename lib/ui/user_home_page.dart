import 'package:flutter/material.dart';
import '../data/user_data.dart';
import '../api/json_service.dart';
import 'post_list_page.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late Future<List<User>> futureUsers;
  final JsonService jsonService = JsonService();

  @override
  void initState() {
    super.initState();
    futureUsers = jsonService.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comunidad de Bloggers', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.teal));
          } else if (snapshot.hasError) {
            return Center(child: Text('❌ Error al cargar: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay miembros en la comunidad.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              User user = snapshot.data![index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.shade100,
                    child: Text(user.name[0], style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                  ),
                  title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.email, style: TextStyle(color: Colors.grey.shade700)),
                      Text(user.phone, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostListPage(user: user),
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