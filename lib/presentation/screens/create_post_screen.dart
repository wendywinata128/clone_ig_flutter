// ignore_for_file: prefer_const_constructors

import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:clone_ig_flutter/core/utils/global_func.dart';
import 'package:clone_ig_flutter/presentation/screens/create_post_screen_step2.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_button.dart';
import 'package:clone_ig_flutter/presentation/widgets/base_layout.dart';
import 'package:clone_ig_flutter/presentation/widgets/create_post/gallery_show.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  AssetEntity? currImage;

  void onPickImage(AssetEntity image) {
    setState(() {
      currImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return BaseLayout(
      padding: EdgeInsets.zero,
      appBar: AppBar(
        title: Text(
          "New post",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: ConstantUI.FONT_SIZE_LG,
          ),
        ),
        actions: [
          BaseButton(
            title: "Next",
            type: ButtonType.TEXT,
            primaryColor: ConstantUI.PRIMARY_COLOR,
            onPressed: () {
              if (currImage != null) {
                navigateToWidget(
                    context, CreatePostScreenStep2(currImage: currImage!));
              }
            },
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              width: mediaQuery.width,
              height: mediaQuery.width,
              child: FutureBuilder(
                future: currImage?.thumbnailDataWithSize(ThumbnailSize(
                    mediaQuery.width.toInt(), mediaQuery.width.toInt())),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null) {
                    return Image.memory(
                      snapshot.data!,
                      fit: BoxFit.cover,
                      width: mediaQuery.width,
                      height: mediaQuery.width,
                    );
                  }

                  return Container(
                    color: Colors.grey,
                    width: mediaQuery.width,
                    height: mediaQuery.width,
                  );
                },
              ),
            ),
            RepaintBoundary(
              child: SizedBox(
                height: mediaQuery.height * 0.5,
                child: GalleryShow(
                  onPickImage: onPickImage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
