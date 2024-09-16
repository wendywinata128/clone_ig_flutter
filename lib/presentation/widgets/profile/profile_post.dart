import 'package:clone_ig_flutter/core/constants/url.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/presentation/providers/profile_provider.dart';
import 'package:flutter/material.dart';

class ProfilePost extends StatelessWidget {
  const ProfilePost({super.key});

  @override
  Widget build(BuildContext context) {
    var posts = getProvider<ProfileProvider>(context).profileDetails!.posts;

    return Container(
      padding: const EdgeInsets.only(top: 24),
      child: posts.isEmpty
          ? const Center(child: Text("No posts for this user yet"))
          : GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                ...posts.map(
                  (post) => Container(
                    height: 300,
                    color: Colors.grey,
                    child: Image.network(
                      ConstantURL.POST_IMAGE_URL + post.photoUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.red.shade600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
