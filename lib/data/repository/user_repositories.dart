import 'dart:convert';

import '/bloc/state/data_state.dart';
import '/data/api/api_service.dart';
import '/data/model/user.dart';

class UserRepository {
  Future<DataState<List<User>>> getUserList() async {
    final response = await ApiService().getList();

    print(response.body);
    if (response.statusCode < 200 ||
        response.statusCode > 300 ||
        !response.body.startsWith('[')) {
      return DataStateError(message: response.body);
    } else {
      final List<dynamic> userJson = json.decode(response.body);
      return DataStateSuccess(
          data: userJson.map((tt) => User.fromJson(tt)).toList());
    }
  }
}
