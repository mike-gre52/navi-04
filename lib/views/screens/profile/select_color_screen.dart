import 'package:flutter/material.dart';
import 'package:whats_for_dinner/views/widgets/profile/select_color.dart';

class SelectColorScreen extends StatelessWidget {
  const SelectColorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 80, left: 30, right: 30),
        child: Column(
          children: const [
            SelectColor(),
          ],
        ),
      ),
    );
  }
}
