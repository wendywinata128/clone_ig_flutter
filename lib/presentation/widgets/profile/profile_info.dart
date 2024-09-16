import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/data/models/user.dart';
import 'package:clone_ig_flutter/presentation/providers/auth_provider.dart';
import 'package:clone_ig_flutter/presentation/providers/profile_provider.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_button.dart';
import 'package:clone_ig_flutter/presentation/widgets/column_gap.dart';
import 'package:clone_ig_flutter/presentation/widgets/row_gap.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    User user = getProvider<ProfileProvider>(context).profileDetails!.user;
    String? authUsername =
        getProvider<AuthProvider>(context).userData?.username;
    bool isAuthProfile = authUsername == user.username;

    var userProvider = getProvider<ProfileProvider>(context, false);

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
      child: ColumnGap(
        gap: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: RowGap(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              gap: 12,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: getAvatarOfUser(user.avatar),
                ),
                Expanded(
                  child: RowGap(
                    mainAxisSize: MainAxisSize.min,
                    gap: 0,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              user.posts.toString(),
                              style: const TextStyle(
                                  fontSize: ConstantUI.FONT_SIZE_LG,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text("posts")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              user.followers.toString(),
                              style: const TextStyle(
                                  fontSize: ConstantUI.FONT_SIZE_LG,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text("followers")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              user.following.toString(),
                              style: const TextStyle(
                                  fontSize: ConstantUI.FONT_SIZE_LG,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text("following")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ColumnGap(
            gap: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: ConstantUI.FONT_SIZE_SM,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!isAuthProfile)
                BaseButton(
                  title: user.isFollow ? "Followed" : "Follow this person",
                  type: ButtonType.OUTLINED,
                  textSize: ConstantUI.FONT_SIZE_XS,
                  borderRadius: BorderRadius.circular(4),
                  onPressed: () => user.isFollow
                      ? userProvider.unfollow(user.id)
                      : userProvider.follow(user.id),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
