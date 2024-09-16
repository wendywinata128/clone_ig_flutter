import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/data/models/comment.dart';
import 'package:clone_ig_flutter/presentation/screens/profile_screen.dart';
import 'package:clone_ig_flutter/presentation/widgets/column_gap.dart';
import 'package:clone_ig_flutter/presentation/widgets/row_gap.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToWidget(
            context, ProfileScreen(username: comment.user.username));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: comment.isNew ? Colors.blue.shade100.withOpacity(0.6) : null,
        child: RowGap(
          gap: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(999),
              ),
              child: getAvatarOfUser(comment.user.avatar),
            ),
            Expanded(
              child: ColumnGap(
                gap: 3,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowGap(
                    gap: 6,
                    children: [
                      Text(
                        comment.user.username,
                        style: const TextStyle(
                          fontSize: ConstantUI.FONT_SIZE_XS,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        getTimeLeftConvert(comment.createddt),
                        style: const TextStyle(
                          fontSize: ConstantUI.FONT_SIZE_XS,
                        ),
                      )
                    ],
                  ),
                  Text(
                    comment.description,
                    style: const TextStyle(
                      fontSize: ConstantUI.FONT_SIZE_SM,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
