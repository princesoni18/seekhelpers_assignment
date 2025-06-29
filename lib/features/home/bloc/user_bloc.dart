import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/user_model.dart';
import '../user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  List<UserModel> _allUsers = [];

  UserBloc(this.repository) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        _allUsers = await repository.fetchUsers();
        emit(UserLoaded(_allUsers));
      } catch (e) {
        emit(UserError('Failed to fetch users'));
      }
    });

    on<SearchUsers>((event, emit) {
      final filtered = _allUsers
          .where((user) =>
              user.name.toLowerCase().contains(event.query.toLowerCase()) ||
              user.username.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(UserLoaded(filtered));
    });

    on<AddUser>((event, emit) {
      final id = _allUsers.isNotEmpty ? _allUsers.last.id + 1 : 1;
      final username = event.name.toLowerCase().replaceAll(' ', '_');
      UserModel newUser = UserModel(
        id: id, 
        name: event.name, 
        username: username, 
        email: event.email,
        phone: event.phone,
      );
      _allUsers.add(newUser);
      emit(UserLoaded(List.from(_allUsers)));
    });
  }
}
