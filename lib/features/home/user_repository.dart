import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:seekhelpers_assignment/core/constants.dart';
import '../../core/models/user_model.dart';

class UserRepository {
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseURL/users'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
