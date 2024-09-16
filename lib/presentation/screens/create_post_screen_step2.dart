// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/presentation/providers/post_provider.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_button.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_input.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_layout.dart';
import 'package:clone_ig_flutter/presentation/widgets/column_gap.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class CreatePostScreenStep2 extends StatefulWidget {
  const CreatePostScreenStep2({super.key, required this.currImage});

  final AssetEntity currImage;

  @override
  State<CreatePostScreenStep2> createState() => _CreatePostScreenStep2State();
}

class _CreatePostScreenStep2State extends State<CreatePostScreenStep2> {
  Uint8List? images;
  String description = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var mediaQuery = MediaQuery.of(context).size;

      widget.currImage
          .thumbnailDataWithSize(
              ThumbnailSize(mediaQuery.width.toInt(), mediaQuery.width.toInt()))
          .then((value) {
        setState(() {
          images = value;
        });
      });
    });
  }

  void onSharePressed() {
    if (images != null) {
      getProvider<PostProvider>(context, false).createNewPost(
        context,
        images!,
        description,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return BaseLayout(
      padding: EdgeInsets.zero,
      appBar: AppBar(
        title: Text(
          "Post Description",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: ConstantUI.FONT_SIZE_LG,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: ColumnGap(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            images != null
                ? Image.memory(
                    images!,
                    fit: BoxFit.cover,
                    width: mediaQuery.width,
                    height: mediaQuery.width,
                  )
                : Container(
                    color: Colors.transparent,
                    width: mediaQuery.width,
                    height: mediaQuery.width,
                  ),
            BaseInput(
              title: "Write a caption",
              minLines: 2,
              maxLines: 10,
              isNoBorder: true,
              onChanged: (val) {
                description = val ?? "";
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<PostProvider>(
                builder: (_, provider, __) => BaseButton(
                  title: 'Share',
                  onPressed: onSharePressed,
                  isLoading: provider.isLoading,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
