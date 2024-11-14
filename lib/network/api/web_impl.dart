import 'package:flutter/foundation.dart';
import 'package:user_data/data/model/get_users_response.dart';
import 'package:user_data/network/api/web.dart';
import 'package:user_data/network/api_endpoints.dart';
import 'package:user_data/network/services/base_api_services.dart';
import 'package:user_data/network/services/network_api_services.dart';

class WebImpl implements WebApi {
  final BaseApiService _apiService = NetworkApiService();

  //GET USERS
  @override
  Future<List<Users>> getUsers() async {
    try {
      dynamic response = await _apiService.getResponse(ApiEndPoints.users);
      if (kDebugMode) {
        print("Fetched Response form get Request -----> ${response}");
      }
      List<Users> userlist = [];
      for (Map<String, dynamic> i in response) {
        userlist.add(Users.fromJson(i)); // Convert each map to a Users object
      }
      if (kDebugMode) {
        print("After Parser -----> ${userlist}");
      }
      return userlist;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Users> getUserDetails(id) async {
    try {
      dynamic response = await _apiService.getResponse(ApiEndPoints.users,
          queryString: 'id=${id}');
      Users userdetails = Users();
      for (Map<String, dynamic> i in response) {
        userdetails = Users.fromJson(i); // Convert each map to a Users object
      }
      return userdetails;
    } catch (e) {
      rethrow;
    }
  }
}
