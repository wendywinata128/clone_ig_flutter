import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/presentation/providers/profile_provider.dart';
import 'package:clone_ig_flutter/presentation/widgets/home/stories_add.dart';
import 'package:clone_ig_flutter/presentation/widgets/home/stories_item.dart';
import 'package:clone_ig_flutter/presentation/widgets/row_gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserStories extends StatelessWidget {
  const UserStories({super.key});

  @override
  Widget build(BuildContext context) {
    var stories = getProvider<ProfileProvider>(context).stories;

    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: RowGap(
          gap: 12,
          children: [
            const StoriesAdd(),
            ...stories.map(
              (story) => StoriesItem(
                avatar: story.avatar,
                username: story.username,
              ),
            )
          ],
        ),
      ),
    );
  }
}
