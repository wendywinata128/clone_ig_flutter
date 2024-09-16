// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BaseInput extends StatefulWidget {
  const BaseInput({
    super.key,
    required this.title,
    this.isPassword = false,
    this.name,
    this.maxLines = 1,
    this.minLines = 1,
    this.isNoBorder = false,
    this.style,
    this.onSubmitted,
    this.onChanged,
  });

  final String title;
  final bool isPassword;
  final String? name;

  final int maxLines;
  final int minLines;

  final bool isNoBorder;
  final TextStyle? style;

  final Function(String?)? onSubmitted;
  final Function(String?)? onChanged;

  @override
  State<BaseInput> createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.name ?? "",
      controller: textEditingController,
      obscureText: widget.isPassword ? true : false,
      style: widget.style,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      decoration: InputDecoration(
        labelText: widget.title,
        fillColor: Colors.white,
        filled: true,
        alignLabelWithHint: true,
        labelStyle:
            TextStyle(fontWeight: FontWeight.w500, color: Colors.grey.shade600),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        enabledBorder: widget.isNoBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.blueGrey.shade300, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
        focusedBorder: widget.isNoBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.blueGrey.shade600, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
        errorBorder: widget.isNoBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade500, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
        focusedErrorBorder: widget.isNoBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade500, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
      ),
      validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return 'Field cannot be empty';
        }

        return null;
      },
      onChanged: (val) {
        if (widget.onChanged != null) {
          widget.onChanged!(val);
        }
      },
      onSubmitted: (val) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(val);
          textEditingController.clear();
        }
      },
    );
  }
}
