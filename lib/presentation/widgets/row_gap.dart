import 'package:flutter/material.dart';

class RowGap extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double gap;

  const RowGap({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.children = const <Widget>[],
    this.gap = 0,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> convertChildrenToGapChildren() {
      List<Widget> result = [];

      final listWidget = (children
          .asMap()
          .entries
          .map((child) => ([
                child.value,
                if (child.key < children.length - 1)
                  SizedBox(
                    width: gap,
                  )
              ]))
          .toList());

      listWidget.asMap().forEach((key, value) {
        result.addAll(value);
      });

      return result;
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: convertChildrenToGapChildren(),
    );
  }
}
