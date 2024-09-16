import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/data/models/user.dart';
import 'package:clone_ig_flutter/presentation/providers/auth_provider.dart';
import 'package:clone_ig_flutter/presentation/widgets/home/stories_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StoriesAdd extends StatelessWidget {
  const StoriesAdd({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = getProvider<AuthProvider>(context).userData;

    return Column(
      children: [
        Stack(
          children: [
            StoriesItem(
              avatar: user?.avatar,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: ConstantUI.PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  alignment: Alignment.center,
                  child: const FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Text(
          "Your story",
          style: TextStyle(fontSize: ConstantUI.FONT_SIZE_SM),
        )
      ],
    );
  }
}
