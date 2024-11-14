import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_data/app_commons/search_bar.dart';
import 'package:user_data/app_commons/text_view.dart';
import 'package:user_data/data/model/get_users_response.dart';
import 'package:user_data/ui/users/user_details.dart';
import 'package:user_data/ui/users/vm/user_viewmodel.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

UserViewmodel userViewmodel = UserViewmodel();

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    userViewmodel.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userViewmodel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: TextView(
            text: "User data",
            color: Colors.white,
            size: 21,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              Consumer<UserViewmodel>(
                builder: (context, vm, child) => AppSearchBar(
                  onSearch: (value) {
                    vm.searchUser(value);
                  },
                  title: "Search user",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Consumer<UserViewmodel>(
                builder: (context, vm, child) => Expanded(
                  child: RefreshIndicator(
                    onRefresh: onRefresh,
                    child: ListView.builder(
                      itemCount: vm.userList.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          navigateToUserDetailScreen(
                            vm.userList[index].id.toString(),
                          );
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.account_circle_outlined,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        TextView(
                                          text: vm.userList[index].name ?? "",
                                          color: Colors.black,
                                          size: 17,
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListTile(
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            TextView(
                                              text: vm.userList[index].phone ??
                                                  "",
                                              size: 12,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.email,
                                              color: Colors.red,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            TextView(
                                              text:
                                                  "${vm.userList[index].email}",
                                              size: 12,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_pin,
                                              color: Colors.red,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            TextView(
                                              text:
                                                  "${vm.userList[index].address?.street},${vm.userList[index].address?.zipcode}",
                                              size: 12,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  navigateToUserDetailScreen(id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserDetailScreen(userId: id)),
    );
  }

  Future<void> onRefresh() async {
    userViewmodel.getUsers();
  }
}
