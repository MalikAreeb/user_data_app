import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_data/ui/users/vm/user_viewmodel.dart';

import '../../app_commons/text_view.dart';

class UserDetailScreen extends StatefulWidget {
  final String userId;
  const UserDetailScreen({super.key, required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

UserViewmodel userViewmodel = UserViewmodel();

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    userViewmodel.getUserDetails(widget.userId);
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
          title: Consumer<UserViewmodel>(
            builder: (context, vm, child) => TextView(
              text: vm.userdetails.name ?? "N/A",
              color: Colors.white,
              size: 21,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Card(
              elevation: 5,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 150,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer<UserViewmodel>(
                    builder: (context, vm, child) => SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Column(
                        children: [
                          buildProfileDetailRowElements(
                            label: 'Name :',
                            value: "${vm.userdetails.name}",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: buildDividerForProfileSetion(),
                          ),
                          buildProfileDetailRowElements(
                            label: 'Company :',
                            value: "${vm.userdetails.company?.name}",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: buildDividerForProfileSetion(),
                          ),
                          buildProfileDetailRowElements(
                            label: 'Address :',
                            value: "${vm.userdetails.address?.street}",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: buildDividerForProfileSetion(),
                          ),
                          buildProfileDetailRowElements(
                            label: 'Phone No :',
                            value: "${vm.userdetails.phone}",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: buildDividerForProfileSetion(),
                          ),
                          buildProfileDetailRowElements(
                            label: 'Email :',
                            value: "${vm.userdetails.email}",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: buildDividerForProfileSetion(),
                          ),
                          buildProfileDetailRowElements(
                            label: 'Zipcode :',
                            value: "${vm.userdetails.address?.zipcode}",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: buildDividerForProfileSetion(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit_document,
                      color: Colors.black,
                      size: 25,
                    ),
                    label: Text(
                      "EDIT PROFILE",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete_sharp,
                      color: Colors.red,
                      size: 25,
                    ),
                    label: Text(
                      "DELETE ACCOUNT",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildProfileDetailRowElements(
      {required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              maxLines: 1,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 3,
            child: Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: value,
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDividerForProfileSetion() {
    return Divider(
      color: Colors.red.withOpacity(.7),
    );
  }
}
