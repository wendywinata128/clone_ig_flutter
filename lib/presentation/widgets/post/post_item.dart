import 'package:clone_ig_flutter/data/models/post.dart';
import 'package:clone_ig_flutter/presentation/widgets/post/post_comment.dart';
import 'package:clone_ig_flutter/presentation/widgets/post/post_image.dart';
import 'package:clone_ig_flutter/presentation/widgets/post/post_likes.dart';
import 'package:clone_ig_flutter/presentation/widgets/post/post_user.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostUser(post: post),
        PostImage(post: post),
        PostLikes(post: post),
        PostComment(post: post),
      ],
    );
  }
}
