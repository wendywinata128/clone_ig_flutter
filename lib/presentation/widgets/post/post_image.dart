import 'dart:math';

import 'package:clone_ig_flutter/core/constants/url.dart';
import 'package:clone_ig_flutter/data/models/post.dart';
import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {
  const PostImage({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Container(
      color: Colors.grey,
      width: min(mediaQuery.width, 600),
      height: min(mediaQuery.width, 600),
      child: Image.network(
        ConstantURL.POST_IMAGE_URL + post.photoUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.red.shade600,
        ),
      ),
    );
  }
}
