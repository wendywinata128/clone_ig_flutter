import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/presentation/widgets/column_gap.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserPostEmpty extends StatelessWidget {
  const UserPostEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: ColumnGap(
        gap: 16,
        children: [
          FaIcon(
            FontAwesomeIcons.circleExclamation,
            size: 48,
            color: Colors.red,
          ),
          Text(
            "No posts to be displayed in your home, start by search and following someone!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ConstantUI.FONT_SIZE_SM,
            ),
          ),
        ],
      ),
    );
  }
}
