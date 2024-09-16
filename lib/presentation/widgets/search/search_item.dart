import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/data/models/user.dart';
import 'package:clone_ig_flutter/presentation/widgets/row_gap.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key, required this.user, required this.onTapUser});

  final User user;

  final Function(User) onTapUser;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapUser(user),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: RowGap(
          gap: 16,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(999),
              ),
              child: getAvatarOfUser(user.avatar),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: const TextStyle(
                    fontSize: ConstantUI.FONT_SIZE_XS,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: ConstantUI.FONT_SIZE_SM,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
