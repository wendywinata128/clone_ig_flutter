import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/presentation/providers/post_provider.dart';
import 'package:clone_ig_flutter/presentation/providers/profile_provider.dart';
import 'package:clone_ig_flutter/presentation/screens/search_screen.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_layout.dart';
import 'package:clone_ig_flutter/presentation/widgets/home/bottom_navigation.dart';
import 'package:clone_ig_flutter/presentation/widgets/home/user_post_container.dart';
import 'package:clone_ig_flutter/presentation/widgets/home/user_stories.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostProvider provider;
  ScrollController scrollController = ScrollController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    provider = getProvider<PostProvider>(context, false);
    provider.fetchUserPost();
    getProvider<ProfileProvider>(context, false).fetchUserStories();
  }

  void onGoToSearchUser() {
    navigateToWidget(context, const SearchScreen());
  }

  Future<void> onRefreshPost() async {
    await provider.fetchUserPost();
    refreshController.refreshCompleted();
  }

  Future<void> onFetchMore() async {
    await provider.fetchMoreUser();
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      padding: EdgeInsets.zero,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Instagram",
          style: TextStyle(
            fontSize: ConstantUI.FONT_SIZE_LG,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: onGoToSearchUser,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                size: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const HomeBottomNavigation(index: 0),
      child: Column(
        children: [
          const UserStories(),
          Expanded(
            child: HomeUserPostContainer(
              onRefresh: onRefreshPost,
              onFetchMore: onFetchMore,
              refreshController: refreshController,
            ),
          ),
        ],
      ),
    );
  }
}
