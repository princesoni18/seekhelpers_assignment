import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/models/user_model.dart';

class UserRepository {
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
   print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
