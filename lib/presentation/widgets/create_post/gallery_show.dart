import 'dart:typed_data';

import 'package:clone_ig_flutter/core/constants/ui.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryShow extends StatefulWidget {
  const GalleryShow({super.key, required this.onPickImage});

  final void Function(AssetEntity image) onPickImage;

  @override
  GalleryShowState createState() => GalleryShowState();
}

class GalleryShowState extends State<GalleryShow> {
  List<AssetEntity> mediaFiles = [];
  List<AssetPathEntity> listAlbums = [];
  int curIdx = 0;
  AssetEntity? pickedImage;

  @override
  void initState() {
    super.initState();
    fetchMedia(0);
  }

  Future<void> fetchMedia(int idx) async {
    final PermissionState result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );

      List<AssetEntity> media =
          await albums[idx].getAssetListPaged(page: 0, size: 100);

      setState(() {
        if (media.isNotEmpty) {
          if (pickedImage == null) {
            pickedImage = media[0];
            widget.onPickImage(pickedImage!);
          }
        }
        curIdx = idx;
        mediaFiles = media;
        listAlbums = albums;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: DropdownButton(
            elevation: 0,
            underline: const SizedBox(),
            isExpanded: false,
            style: const TextStyle(
              fontSize: ConstantUI.FONT_SIZE_LG,
              color: Colors.black,
            ),
            onChanged: (val) {
              if (val != null) {
                fetchMedia(val);
              }
            },
            value: curIdx,
            items: [
              ...listAlbums.asMap().entries.map((entry) => DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value.name),
                  ))
            ],
          ),
        ),
        if (mediaFiles.isEmpty)
          const Center(child: Text("Theres no image in your gallery")),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: mediaFiles.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  widget.onPickImage(mediaFiles[index]);
                },
                child: FutureBuilder<Uint8List?>(
                  future: mediaFiles[index]
                      .thumbnailDataWithSize(const ThumbnailSize(200, 200)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      return Image.memory(snapshot.data!, fit: BoxFit.cover);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
