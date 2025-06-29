import '../../../core/models/user_model.dart';

abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class SearchUsers extends UserEvent {
  final String query;
  SearchUsers(this.query);
}

class AddUser extends UserEvent {
  final String name;
  final String email;
  final String phone;
  AddUser(this.name, this.email, this.phone);
}
