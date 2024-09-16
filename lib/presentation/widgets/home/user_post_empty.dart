import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:flutter/material.dart';

class UserPostEmpty extends StatelessWidget {
  const UserPostEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        "No posts to be displayed in your home, start by search and following someone!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: ConstantUI.FONT_SIZE_SM,
        ),
      ),
    );
  }
}
