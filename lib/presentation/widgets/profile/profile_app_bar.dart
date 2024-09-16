import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/data/models/user.dart';
import 'package:clone_ig_flutter/presentation/providers/auth_provider.dart';
import 'package:clone_ig_flutter/presentation/providers/profile_provider.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = getProvider<ProfileProvider>(context).profileDetails?.user;
    String? authUsername =
        getProvider<AuthProvider>(context).userData?.username;

    bool isAuthProfile = authUsername == user?.username;

    return AppBar(
      automaticallyImplyLeading: !isAuthProfile,
      title: Text(
        user?.username ?? "Username",
        style: const TextStyle(
          fontSize: ConstantUI.FONT_SIZE_LG,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (isAuthProfile)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
                onPressed: () =>
                    getProvider<AuthProvider>(context, false).logout(context),
                icon: const Icon(Icons.logout)),
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
