import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/data/models/post.dart';
import 'package:clone_ig_flutter/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class PostUser extends StatelessWidget {
  const PostUser({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToWidget(context, ProfileScreen(username: post.username));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(999),
              ),
              child: getAvatarOfUser(post.avatar),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                Text(
                  post.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
