import 'package:bloc_app/bloc/state/data_state.dart';
import 'package:bloc_app/data/model/user.dart';
import 'package:bloc_app/data/repository/user_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Cubit<DataState<List<User>>> {
  UserBloc() : super(DataStateEmpty()) {
    loadUserList();
  }

  void loadUserList() {
    print("Load user...");
    emit(DataStateLoading());
    UserRepository().getUserList().then((value) => emit(value));
  }
}
