import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/presentation/providers/profile_provider.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_layout.dart';
import 'package:clone_ig_flutter/presentation/widgets/home/bottom_navigation.dart';
import 'package:clone_ig_flutter/presentation/widgets/profile/profile_app_bar.dart';
import 'package:clone_ig_flutter/presentation/widgets/profile/profile_info.dart';
import 'package:clone_ig_flutter/presentation/widgets/profile/profile_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.username});

  final String username;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getProvider<ProfileProvider>(context, false)
        .getUserDetails(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      padding: EdgeInsets.zero,
      appBar: const ProfileAppBar(),
      bottomNavigationBar: const HomeBottomNavigation(index: 2),
      child: Consumer<ProfileProvider>(
        builder: (ctx, provider, _) => provider.isLoadingUser
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : provider.profileDetails == null
                ? const Center(
                    child: Text('Something went wrong, please try again'),
                  )
                : const SingleChildScrollView(
                    child: Column(
                      children: [
                        ProfileInfo(),
                        ProfilePost(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
