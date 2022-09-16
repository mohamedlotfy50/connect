import 'package:flutter/material.dart';

class ScreenAdapter extends StatelessWidget {
  final double _watch = 300, _mobile = 768, _tablet = 992;
  const ScreenAdapter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Container();
      },
    );
  }
}
