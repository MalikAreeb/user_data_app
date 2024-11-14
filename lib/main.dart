import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:user_data/ui/users/user_list.dart';
import 'package:user_data/ui/users/vm/user_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          UserViewmodel(), // Provide the ViewModel to the entire app
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      title: 'Fetch user',
      color: Colors.white,
      theme: ThemeData(
          useMaterial3: false,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          })),
      home: UserListScreen(),
    );
  }
}
