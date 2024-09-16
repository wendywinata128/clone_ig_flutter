// ignore_for_file: prefer_const_constructors

import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/data/models/user.dart';
import 'package:clone_ig_flutter/presentation/providers/profile_provider.dart';
import 'package:clone_ig_flutter/presentation/screens/profile_screen.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_layout.dart';
import 'package:clone_ig_flutter/presentation/widgets/search/search_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onUserClicked(User user) {
      navigateToWidget(
          context,
          ProfileScreen(
            username: user.username,
          ));
    }

    return BaseLayout(
      appBar: AppBar(
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TextField(
            style: TextStyle(fontSize: ConstantUI.FONT_SIZE_SM),
            decoration: InputDecoration(
              filled: true,
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              border: InputBorder.none,
              hintText: "Search User",
            ),
            onChanged: (val) {
              if (val.isNotEmpty) {
                getProvider<ProfileProvider>(context, false)
                    .onSearchProfiles(val);
              }
            },
          ),
        ),
      ),
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: Consumer<ProfileProvider>(
          builder: (ctx, provider, widget) => provider.isLoadingSearchUser
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    if (provider.users.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text("No users found"),
                        ),
                      ),
                    ...provider.users.map(
                      (user) => Material(
                        borderRadius: BorderRadius.circular(8),
                        child: SearchItem(
                          user: user,
                          onTapUser: onUserClicked,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
