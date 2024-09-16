import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/data/models/post.dart';
import 'package:clone_ig_flutter/presentation/providers/auth_provider.dart';
import 'package:clone_ig_flutter/presentation/widgets/create_comments/comments_dialog.dart';
import 'package:clone_ig_flutter/presentation/widgets/expandable_text.dart';
import 'package:clone_ig_flutter/presentation/widgets/row_gap.dart';
import 'package:flutter/material.dart';

class PostComment extends StatefulWidget {
  const PostComment({super.key, required this.post});
  final Post post;

  @override
  State<PostComment> createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  bool isExpanded = false;

  onClickExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? avatarUser = getProvider<AuthProvider>(context).userData?.avatar;

    return DefaultTextStyle.merge(
      style: const TextStyle(
        fontSize: ConstantUI.FONT_SIZE_SM,
        fontWeight: FontWeight.w500,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandableText(
              text: "${widget.post.username}  ${widget.post.description}",
              maxLines: 2,
              onClickExpand: onClickExpand,
              isExpanded: isExpanded,
              widget: RichText(
                maxLines: isExpanded ? 999 : 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: ConstantUI.FONT_SIZE_BASE),
                  text: '${widget.post.username} ',
                  children: [
                    TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade800),
                      text: widget.post.description,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () => showCreateCommentDialog(context, widget.post.id),
              child: Text(
                "View all comments",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () => showCreateCommentDialog(context, widget.post.id),
              child: RowGap(
                gap: 8,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: getAvatarOfUser(avatarUser, size: 10),
                  ),
                  Text(
                    'Add a comment...',
                    style: TextStyle(color: Colors.grey.shade600),
                  )
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              formatDateFromString(widget.post.createddt),
              style: TextStyle(
                fontSize: ConstantUI.FONT_SIZE_SM,
                color: Colors.grey.shade600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
