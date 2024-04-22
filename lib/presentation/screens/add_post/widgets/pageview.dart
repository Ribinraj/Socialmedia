import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:social_media_app/core/colors.dart';

class PageviewInAddpost extends StatelessWidget {
  const PageviewInAddpost({
    super.key,
    required this.selectedAssetList,
  });

  final List<AssetEntity> selectedAssetList;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: selectedAssetList.length,
      itemBuilder: (context, index) {
        final assetEntity = selectedAssetList[index];
        return Stack(
          children: [
            Positioned.fill(
              child: AssetEntityImage(
                assetEntity,
                isOriginal: false,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.error,
                      color: kredcolor,
                    ),
                  );
                },
              ),
            ),
            if (assetEntity.type == AssetType.video)
              const Positioned(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.image,
                      color: kredcolor,
                    ),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}