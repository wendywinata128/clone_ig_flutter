import 'dart:typed_data';

import 'package:clone_ig_flutter/data/models/base_response.dart';
import 'package:clone_ig_flutter/data/models/comment.dart';
import 'package:clone_ig_flutter/data/models/page.dart';
import 'package:clone_ig_flutter/data/models/post.dart';
import 'package:clone_ig_flutter/data/services/base_service.dart';
import 'package:dio/dio.dart';

class PostService extends BaseService {
  static final PostService _postService = PostService._internal();

  PostService._internal();

  static PostService getInstance() {
    return _postService;
  }

  Future<BasicResponse> createPost(Uint8List images, String description) async {
    final result = await basePost(
        url: "posts/",
        data: FormData.fromMap({
          "photo": MultipartFile.fromBytes(images, filename: "upload.jpg"),
          "description": description,
        }));

    return result;
  }

  Future<BasicResponse<Page<Post>?>> getUserHomePostData({
    int page = 1,
    int size = 10,
  }) async {
    final result = await baseGet(
      url: "posts/home?page=$page&size=$size&sort=createddt,desc",
      mappedFunc: (result) => Page.fromJson(
        result,
        mappedContent: (content) => Post.fromJson(
          content,
        ),
      ),
    );

    return result;
  }

  Future<BasicResponse<List<Comment>?>> getPostCommentData(
      {required int id}) async {
    final result = await baseGet<List<Comment>>(
      url: "comments/$id",
      mappedFunc: (result) {
        var comments = <Comment>[];

        result.forEach((r) {
          comments.add(Comment.fromJson(r));
        });

        return comments;
      },
    );

    return result;
  }

  Future<BasicResponse<Comment?>> addPostComment(
      {required int id, required String description}) async {
    final result = await basePost<Comment>(
      url: "comments/$id",
      data: {
        "description": description,
      },
      mappedFunc: (content) => Comment.fromJson(content),
    );

    return result;
  }

  Future<BasicResponse> likePost({required int id}) async {
    final result = await basePatch<String>(
      url: "posts/$id/likes",
    );

    return result;
  }
}
