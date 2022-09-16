import 'package:connect/presentation/auth/login_screen.dart';
import 'package:connect/presentation/avatar/avatar.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AvatarScreen(),
    );
  }
}
