import 'package:clone_ig_flutter/data/models/base_response.dart';
import 'package:clone_ig_flutter/data/models/story.dart';
import 'package:clone_ig_flutter/data/models/user.dart';
import 'package:clone_ig_flutter/data/models/user_detail.dart';
import 'package:clone_ig_flutter/data/services/base_service.dart';

class ProfileService extends BaseService {
  static final ProfileService _authService = ProfileService._internal();

  ProfileService._internal();

  static ProfileService getInstance() {
    return _authService;
  }

  Future<BasicResponse<List<User>?>> searchUser(String key) async {
    var result = await baseGet<List<User>>(
      url: "user/search/$key",
      mappedFunc: (contents) {
        List<User> user = [];

        contents.forEach((content) => user.add(User.fromJson(content)));

        return user;
      },
    );

    return result;
  }

  Future<BasicResponse<UserDetail?>> getUserDetail(String username) async {
    var result = await baseGet<UserDetail>(
      url: "user/$username",
      mappedFunc: (json) => UserDetail.fromJson(json),
    );

    return result;
  }

  Future<BasicResponse<List<Story>?>> getStories() async {
    var result = await baseGet<List<Story>>(
      url: "user/stories",
      mappedFunc: (contents) {
        List<Story> stories = [];

        contents.forEach((content) => stories.add(Story.fromJson(content)));

        return stories;
      },
    );

    return result;
  }

  Future<BasicResponse> follow(int id) async {
    var result = await basePost(
      url: "user/$id/follow",
    );

    return result;
  }

  Future<BasicResponse> unfollow(int id) async {
    var result = await baseDelete(
      url: "user/$id/unfollow",
    );

    return result;
  }
}
