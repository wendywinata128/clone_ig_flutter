import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/presentation/providers/auth_provider.dart';
import 'package:clone_ig_flutter/presentation/providers/post_provider.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_input.dart';
import 'package:clone_ig_flutter/presentation/widgets/column_gap.dart';
import 'package:clone_ig_flutter/presentation/widgets/create_comments/comment_item.dart';
import 'package:clone_ig_flutter/presentation/widgets/row_gap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

showCreateCommentDialog(BuildContext context, int postId) {
  getProvider<PostProvider>(context, false).fetchUserComments(postId);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => CommentsDialog(
      postId: postId,
    ),
  );
}

class CommentsDialog extends StatelessWidget {
  const CommentsDialog({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.8 -
            MediaQuery.of(context).viewInsets.bottom,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 8),
        child: ColumnGap(
          gap: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 6,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const Text(
              "Comments",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => getProvider<PostProvider>(context, false)
                    .fetchUserComments(postId),
                child: SingleChildScrollView(
                  child: Consumer<PostProvider>(
                    builder: (ctx, provider, widget) {
                      if (provider.isLoadingComment) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (provider.comments.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              'No comments available so far, begin a comment from the chat box at the bottom',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ConstantUI.FONT_SIZE_SM,
                              ),
                            ),
                          ),
                        );
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...provider.comments.map(
                            (comment) => CommentItem(
                              comment: comment,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade400))),
              padding: const EdgeInsets.all(16),
              child: RowGap(
                gap: 8,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: getAvatarOfUser(
                        getProvider<AuthProvider>(context, false)
                            .userData
                            ?.avatar),
                  ),
                  Expanded(
                    child: BaseInput(
                      title: 'Type your comment',
                      style: const TextStyle(fontSize: ConstantUI.FONT_SIZE_SM),
                      onSubmitted: (val) {
                        if (val?.isNotEmpty ?? false) {
                          getProvider<PostProvider>(context, false)
                              .addNewComment(postId, val!);
                        }
                      },
                      // isNoBorder: true,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
