import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/data/models/post.dart';
import 'package:clone_ig_flutter/presentation/providers/post_provider.dart';
import 'package:clone_ig_flutter/presentation/widgets/create_comments/comments_dialog.dart';
import 'package:clone_ig_flutter/presentation/widgets/post/love_widget.dart';
import 'package:clone_ig_flutter/presentation/widgets/row_gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostLikes extends StatefulWidget {
  const PostLikes({super.key, required this.post});
  final Post post;

  @override
  State<PostLikes> createState() => _PostLikesState();
}

class _PostLikesState extends State<PostLikes> {
  var isLoved = false;

  @override
  void initState() {
    super.initState();

    isLoved = widget.post.userLikes > 0;
  }

  Future<void> onUserTapLike() async {
    setState(() {
      isLoved = !isLoved;
    });

    var result = await getProvider<PostProvider>(context, false)
        .likeComments(widget.post.id);

    if (!result) {
      setState(() {
        isLoved = !isLoved;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16),
      child: RowGap(
        gap: 16,
        children: [
          RowGap(
            gap: 6,
            children: [
              LoveWidget(
                onTap: onUserTapLike,
                isLoved: isLoved,
              ),
              if (widget.post.likes > 0)
                Text(
                  widget.post.likes.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: ConstantUI.FONT_SIZE_BASE,
                  ),
                ),
            ],
          ),
          GestureDetector(
            onTap: () => showCreateCommentDialog(context, widget.post.id),
            child: RowGap(
              gap: 6,
              children: [
                const FaIcon(FontAwesomeIcons.comment),
                if (widget.post.comments > 0)
                  Text(
                    widget.post.comments.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: ConstantUI.FONT_SIZE_BASE,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
