import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:user_data/data/model/get_users_response.dart';
import 'package:user_data/network/api/web.dart';
import 'package:user_data/network/api/web_impl.dart';

class UserViewmodel extends ChangeNotifier {
  WebImpl _webApi = WebImpl();

  List<Users> userList = [];
  List<Users> filteredUserList = [];
  Users userdetails = Users();

  //Get All Users
  Future<void> getUsers() async {
    EasyLoading.show(status: "Loading");
    _webApi
        .getUsers()
        .then((value) => _onFetchUserSuccess(value))
        .onError((error, stackTrace) => _onFetchUserError(error.toString()));
  }

  _onFetchUserSuccess(List<Users> response) {
    userList = response ?? [];
    notifyListeners();
    EasyLoading.showSuccess("Users Fetched");
  }

  _onFetchUserError(String message) {
    print(message);
    EasyLoading.showError(message);
  }

  //Get User Details
  Future<void> getUserDetails(id) async {
    EasyLoading.show(status: "Loading");
    _webApi
        .getUserDetails(id)
        .then((value) => _onFetchUserDetailsSuccess(value))
        .onError(
            (error, stackTrace) => _onFetchUserDetailsError(error.toString()));
  }

  _onFetchUserDetailsSuccess(Users response) {
    userdetails = response;
    notifyListeners();
    EasyLoading.showSuccess("User Details Fetched");
  }

  _onFetchUserDetailsError(String message) {
    print(message);
    EasyLoading.showError(message);
  }

  //Search user

  Future<void> searchUser(String query) async {
    if (query.isNotEmpty) {
      filteredUserList =
          userList.where((e) => e.name!.toLowerCase().contains(query)).toList();
      userList = filteredUserList;
    } else {
      getUsers();
    }
    notifyListeners();
  }
}
