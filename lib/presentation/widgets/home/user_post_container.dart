import 'package:clone_ig_flutter/presentation/providers/post_provider.dart';
import 'package:clone_ig_flutter/presentation/widgets/home/user_post_empty.dart';
import 'package:clone_ig_flutter/presentation/widgets/post/post_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeUserPostContainer extends StatelessWidget {
  const HomeUserPostContainer(
      {super.key,
      required this.onRefresh,
      required this.refreshController,
      required this.onFetchMore});

  final Future<void> Function() onRefresh;
  final Future<void> Function() onFetchMore;
  final RefreshController refreshController;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.grey.shade300)),
      ),
      child: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: onRefresh,
        onLoading: onFetchMore,
        child: SingleChildScrollView(
          child: Consumer<PostProvider>(
            builder: (contenxt, provider, _) => Column(
              children: [
                if (provider.posts.isEmpty) const UserPostEmpty(),
                ...provider.posts.map(
                  (post) => PostItem(
                    post: post,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
