import 'dart:async';

import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/core/utils/logger.dart';
import 'package:clone_ig_flutter/data/models/story.dart';
import 'package:clone_ig_flutter/data/models/user.dart';
import 'package:clone_ig_flutter/data/models/user_detail.dart';
import 'package:clone_ig_flutter/data/services/profile_service.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  ProfileService profileService = ProfileService.getInstance();
  List<User> users = [];
  bool isLoadingSearchUser = false;

  UserDetail? profileDetails;
  bool isLoadingUser = false;

  List<Story> stories = [];

  Timer? t;
  onSearchProfiles(String key) async {
    if (t != null) {
      t!.cancel();
    }
    isLoadingSearchUser = true;
    notifyListeners();

    List<User> usersTemp = [...users];
    users.clear();

    // do debounce
    t = Timer(const Duration(seconds: 1), () async {
      var result = await profileService.searchUser(key);
      if (result.status == 200 && result.data != null) {
        users.addAll(result.data!);
        logger.info(result.data!.length);
      } else {
        //  if failed, return back the suers
        users.addAll(usersTemp);
      }

      isLoadingSearchUser = false;
      notifyListeners();
    });
  }

  getUserDetails(String username) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isLoadingUser = true;
      profileDetails = null;
      notifyListeners();
    });

    var result = await profileService.getUserDetail(username);

    if (result.status == 200) {
      logger.info(result.data?.posts.length);
      profileDetails?.posts.clear();
      profileDetails = result.data;
    }

    isLoadingUser = false;
    notifyListeners();
  }

  Future<void> fetchUserStories() async {
    doSomethingAfterWidgetsReady(() {
      stories.clear();
      notifyListeners();
    });

    var result = await profileService.getStories();

    if (result.status == 200) {
      stories.addAll(result.data ?? []);
    }

    notifyListeners();
  }

  Future<void> follow(int id) async {
    var result = await profileService.follow(id);

    if (result.status == 200) {
      profileDetails?.user.isFollow = true;
      notifyListeners();
    }
  }

  Future<void> unfollow(int id) async {
    var result = await profileService.unfollow(id);

    if (result.status == 200) {
      profileDetails?.user.isFollow = false;
      notifyListeners();
    }
  }
}
