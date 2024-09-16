import 'dart:typed_data';

import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/core/utils/logger.dart';
import 'package:clone_ig_flutter/core/utils/toast.dart';
import 'package:clone_ig_flutter/data/models/comment.dart';
import 'package:clone_ig_flutter/data/models/post.dart';
import 'package:clone_ig_flutter/data/services/post_service.dart';
import 'package:clone_ig_flutter/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  List<Post> posts = [];
  int page = 0;
  int size = 10;
  var isLoading = false;

  List<Comment> comments = [];
  var isLoadingComment = false;

  PostService postService = PostService.getInstance();

  fetchUserPost({page = 0, size = 10, bool fetchMore = false}) async {
    this.page = page;
    this.size = size;

    final result =
        await postService.getUserHomePostData(page: page, size: size);

    if (result.status == 200) {
      if (!fetchMore) {
        posts.clear();
      }
      posts.addAll(result.data!.content);
      notifyListeners();
    }
  }

  fetchMoreUser() {
    return fetchUserPost(page: page + 1, fetchMore: true);
  }

  Future<void> createNewPost(
      BuildContext context, Uint8List image, String description) async {
    isLoading = true;
    notifyListeners();

    var result = await postService.createPost(image, description);

    if (result.status == 200) {
      showToastMessage("Post Created Successfully");
      navigateToWidget(
        context,
        const HomeScreen(),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUserComments(int postId) async {
    comments.clear();
    isLoadingComment = true;

    var result = await postService.getPostCommentData(
      id: postId,
    );

    if (result.status == 200) {
      comments = result.data ?? [];
    }

    isLoadingComment = false;
    notifyListeners();
  }

  Future<void> addNewComment(int postId, String description) async {
    var result =
        await postService.addPostComment(id: postId, description: description);

    if (result.status == 200 && result.data != null) {
      Comment newComment = result.data!;
      newComment.isNew = true;
      logger.info(newComment);

      comments.insert(0, newComment);
      notifyListeners();
    }
  }

  Future<bool> likeComments(int postId) async {
    var result = await postService.likePost(id: postId);

    if (result.status == 200) {
      for (var post in posts) {
        if (post.id == postId) {
          if (result.data.toString().contains("Unlike")) {
            post.likes--;
          } else {
            post.likes++;
          }
          break;
        }
      }

      notifyListeners();
      return true;
    }

    return false;
  }
}
