import 'dart:math';

import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/presentation/widgets/column_gap.dart';
import 'package:clone_ig_flutter/presentation/widgets/row_gap.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpandableText extends StatelessWidget {
  const ExpandableText(
      {super.key,
      required this.text,
      required this.widget,
      required this.maxLines,
      required this.onClickExpand,
      required this.isExpanded});

  final String text;
  final Widget widget;
  final int maxLines;
  final Function() onClickExpand;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    var textpainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade800,
        ),
      ),
    );

    textpainter.layout(
        maxWidth: min(MediaQuery.of(context).size.width, 600) - 16);

    final int numberOfLines = textpainter.computeLineMetrics().length;

    return ColumnGap(
      crossAxisAlignment: CrossAxisAlignment.end,
      gap: 8,
      children: [
        widget,
        if (numberOfLines > maxLines)
          GestureDetector(
            onTap: onClickExpand,
            child: RowGap(
              gap: 4,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  isExpanded ? "Show Less" : "Show More",
                  style: const TextStyle(
                    color: ConstantUI.PRIMARY_COLOR,
                  ),
                ),
                FaIcon(
                  isExpanded
                      ? FontAwesomeIcons.chevronUp
                      : FontAwesomeIcons.chevronDown,
                  size: 12,
                  color: ConstantUI.PRIMARY_COLOR,
                )
              ],
            ),
          ),
      ],
    );
  }
}
