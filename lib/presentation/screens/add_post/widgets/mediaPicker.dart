// ignore: file_names
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/screens/add_post/widgets/media_services.dart';

class MediaPicker extends StatefulWidget {
  final int maxCount;
  final RequestType requestType;
  const MediaPicker(
      {super.key, required this.maxCount, required this.requestType});

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];
  @override
  void initState() {
    MediaServices().loadAlbums(widget.requestType).then(
      (value) {
        setState(() {
          albumList = value;
          selectedAlbum = value[0];
        });
        MediaServices().loadAssets(selectedAlbum!).then((value) {
          setState(() {
            assetList = value;
          });
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              title: DropdownButton<AssetPathEntity>(
                value: selectedAlbum,
                onChanged: (AssetPathEntity? value) {
                  setState(() {
                    selectedAlbum = value;
                  });
                  MediaServices().loadAssets(selectedAlbum!).then(
                    (value) {
                      setState(() {
                        assetList = value;
                      });
                    },
                  );
                },
                items: albumList.map<DropdownMenuItem<AssetPathEntity>>(
                    (AssetPathEntity album) {
                  return DropdownMenuItem<AssetPathEntity>(
                    value: album,
                    child: FutureBuilder<int>(
                      future: album.assetCountAsync,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final value = snapshot.data;
                          return Text("${album.name}($value)");
                        } else {
                          return const Center(
                            child:  CircularProgressIndicator(),
                          );
                        } 
                      },
                    ),
                  );
                }).toList(),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, selectedAssetList);
                  },
                  child: const Center(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "OK",
                          style: TextStyle(color:kpurpleMediumColor, fontSize: 18),
                        )),
                  ),
                )
              ],
            ),
            body: assetList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: assetList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      AssetEntity assetEntity = assetList[index];
                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: assetWidget(assetEntity),
                      );
                    })));
  }

  Widget assetWidget(AssetEntity assetEntity) => Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(
                  selectedAssetList.contains(assetEntity) == true ? 15 : 0),
              child: AssetEntityImage(
                assetEntity,
                isOriginal: false,
                thumbnailSize: const ThumbnailSize.square(250),
                fit: BoxFit.cover,
                // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                errorBuilder: (context, error, StackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.error,
                      color: kredcolor,
                    ),
                  );
                },
              ),
            ),
          ),
          if (assetEntity.type == AssetType.video)
            const Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.video_camera_front_rounded,
                    color: kredcolor,
                  ),
                ),
              ),
            ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  selectAsset(assetEntity: assetEntity);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: selectedAssetList.contains(assetEntity) == true
                            ? Colors.blue
                            : kblackColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: kwhiteColor, width: 1.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "${selectedAssetList.indexOf(assetEntity) + 1}",
                        style: TextStyle(
                            color:
                                selectedAssetList.contains(assetEntity) == true
                                    ? kwhiteColor
                                    : Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
  void selectAsset({required AssetEntity assetEntity}) {
    if (selectedAssetList.contains(assetEntity)) {
      setState(() {
        selectedAssetList.remove(assetEntity);
      });
    } else if (selectedAssetList.length < widget.maxCount) {
      setState(() {
        selectedAssetList.add(assetEntity);
      });
    }
  }
}
