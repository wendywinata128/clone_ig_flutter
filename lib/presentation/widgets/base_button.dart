// ignore_for_file: constant_identifier_names

import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/presentation/widgets/row_gap.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  FILLED,
  OUTLINED,
  TEXT,
}

ButtonStyle _generateButtonStyle(
    ButtonType buttonType, Color? colors, BorderRadius? borderRadius) {
  if (buttonType == ButtonType.FILLED) {
    return ElevatedButton.styleFrom(
      backgroundColor: ConstantUI.PRIMARY_COLOR,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(16),
      textStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    );
  } else if (buttonType == ButtonType.TEXT) {
    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: colors ?? Colors.grey.shade700,
      padding: const EdgeInsets.all(16),
      textStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    );
  } else {
    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: ConstantUI.PRIMARY_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(999),
        side: const BorderSide(
          color: ConstantUI.PRIMARY_COLOR,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(14),
      textStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    );
  }
}

class BaseButton extends StatelessWidget {
  const BaseButton(
      {super.key,
      required this.title,
      this.type = ButtonType.FILLED,
      this.onPressed,
      this.isLoading = false,
      this.primaryColor,
      this.textSize,
      this.borderRadius});
  final String title;
  final ButtonType type;
  final Function()? onPressed;
  final bool isLoading;
  final Color? primaryColor;
  final double? textSize;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () {
              if (onPressed != null) {
                onPressed!();
              }
            },
      style: _generateButtonStyle(
        type,
        primaryColor,
        borderRadius,
      ),
      child: RowGap(
        gap: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: textSize),
          ),
          if (isLoading)
            const SizedBox(
              height: 12,
              width: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
