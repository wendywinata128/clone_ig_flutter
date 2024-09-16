// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/presentation/providers/auth_provider.dart';
import 'package:clone_ig_flutter/presentation/screens/create_post_screen.dart';
import 'package:clone_ig_flutter/presentation/screens/home_screen.dart';
import 'package:clone_ig_flutter/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_manager/photo_manager.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final user = getProvider<AuthProvider>(context).userData;

    Future<void> onTapNavigation(int idx) async {
      if (idx == 0 && index != 0) {
        navigateToWidget(context, const HomeScreen());
      } else if (idx == 1) {
        final PermissionState ps = await PhotoManager.requestPermissionExtend();

        if (ps.hasAccess) {
          navigateToWidget(context, const CreatePostScreen());
        }
      } else if (idx == 2 && index != 2) {
        navigateToWidget(
          context,
          ProfileScreen(
            username: user!.username,
          ),
        );
      }
    }

    return SizedBox(
      child: BottomNavigationBar(
        elevation: 0,
        currentIndex: index,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: onTapNavigation,
        items: [
          const BottomNavigationBarItem(
            tooltip: 'Create new Post',
            icon: Icon(
              Icons.home,
              size: 32,
            ),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.circlePlus,
              size: 28,
            ),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: Colors.grey,
              ),
              child: getAvatarOfUser(user?.avatar),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
