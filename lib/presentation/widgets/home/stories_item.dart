import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:flutter/material.dart';

class StoriesItem extends StatelessWidget {
  const StoriesItem({super.key, this.avatar, this.username});

  final String? avatar;
  final String? username;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(999),
            ),
            child: getAvatarOfUser(avatar, size: 20),
          ),
        ),
        if (username != null)
          SizedBox(
            width: 60,
            child: Text(
              username!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: ConstantUI.FONT_SIZE_SM),
            ),
          ),
      ],
    );
  }
}
