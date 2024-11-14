import 'package:user_data/data/model/get_users_response.dart';

abstract class WebApi {
  Future<List<Users>> getUsers();
  Future<Users> getUserDetails(id);
}
