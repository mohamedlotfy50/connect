import 'dart:async';

import 'package:connect/presentation/avatar/avatar.dart';
import 'package:connect/presentation/wave/wave_screen.dart';
import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';

void main() {
  runApp(const MyApp());
}

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
