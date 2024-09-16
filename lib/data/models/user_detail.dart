import 'package:clone_ig_flutter/data/models/post.dart';
import 'package:clone_ig_flutter/data/models/user.dart';

class UserDetail {
  late final User user;
  late final List<Post> posts;

  UserDetail.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);

    posts = [];

    json['posts'].forEach((post) {
      posts.add(Post.fromJson(post));
    });
  }
}
