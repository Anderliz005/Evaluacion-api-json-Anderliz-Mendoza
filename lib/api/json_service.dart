import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/user_data.dart';
import '../data/post_data.dart';

class JsonService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => User.fromJson(item)).toList();
    } else {
      throw Exception('Error de conexión al cargar usuarios');
    }
  }

  Future<List<Post>> fetchPostsByUserId(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts?userId=$userId'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Error al cargar publicaciones del usuario $userId');
    }
  }
}