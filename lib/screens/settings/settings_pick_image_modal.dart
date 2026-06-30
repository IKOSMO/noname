import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_manager/photo_manager.dart';

class SettingsPickImageModal {
  static Future<T?> showModal<T>(BuildContext context) async {
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList();

    final ValueNotifier<String> selectedPathId = ValueNotifier(paths.first.id);

    final ValueNotifier<List<AssetEntity>> entities = ValueNotifier(
      await _getAssets(
        path: paths.firstWhere((elem) => elem.id == selectedPathId.value),
      ),
    );

    DraggableScrollableController draggableScrollableController =
        DraggableScrollableController();

    AssetEntity? selectedEntity;
    Rect? selectedRect;

    if (!context.mounted) return null;

    return await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              controller: draggableScrollableController,
              initialChildSize: 0.6,
              minChildSize: 0.6,
              maxChildSize: 0.93,
              expand: false,
              snap: true,
              snapSizes: [0.6, 0.93],
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: entities,
                        builder: (context, value, child) {
                          return GridView.builder(
                            controller: scrollController,
                            physics: selectedEntity != null
                                ? NeverScrollableScrollPhysics()
                                : AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                              top: 60,
                              bottom: MediaQuery.heightOf(context) * 0.3,
                            ),
                            itemCount: value.length,
                            scrollCacheExtent: ScrollCacheExtent.pixels(
                              MediaQuery.heightOf(context) * 2,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 1.0,
                                  mainAxisSpacing: 1.0,
                                  childAspectRatio: 1.0,
                                ),
                            itemBuilder: (context, index) {
                              final entity = value[index];
                              return Builder(
                                builder: (cellContext) {
                                  return GridItemImage(
                                    onTap: () {
                                      if (selectedEntity == entity) {
                                        setState(() {
                                          selectedEntity = null;
                                          selectedRect = null;
                                        });

                                        return;
                                      }

                                      final RenderBox box =
                                          cellContext.findRenderObject()
                                              as RenderBox;
                                      final offset = box.localToGlobal(
                                        Offset.zero,
                                      );
                                      final rect = offset & box.size;

                                      setState(() {
                                        selectedEntity = entity;
                                        selectedRect = rect;
                                      });
                                    },
                                    entity: entity,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      if (selectedEntity != null && selectedRect != null) ...[
                        Positioned(
                          left: selectedRect!.left,
                          top: draggableScrollableController.size == 0.93
                              ? selectedRect!.top - selectedRect!.height / 2 + 4
                              : (selectedRect!.top -
                                        selectedRect!.height / 2 +
                                        4) -
                                    MediaQuery.heightOf(context) * 0.33,
                          child: Container(
                            width: selectedRect!.width,
                            height: selectedRect!.height,
                            color: Colors.black,
                          ),
                        ),
                      ],

                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: ShaderMask(
                          shaderCallback: (boudns) {
                            return LinearGradient(
                              colors: [Colors.white, Colors.transparent],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 1.0],
                            ).createShader(boudns);
                          },
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(202, 0, 0, 0),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                            child: SizedBox(
                              height: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DropdownButton2<String>(
                                    valueListenable: selectedPathId,
                                    underline: SizedBox.shrink(),
                                    items: paths.map((path) {
                                      return DropdownItem<String>(
                                        value: path.id,
                                        child: Text(
                                          path.name,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) async {
                                      selectedPathId.value =
                                          value ?? paths.first.id;

                                      entities.value = await _getAssets(
                                        path: paths.firstWhere(
                                          (elem) =>
                                              elem.id == selectedPathId.value,
                                        ),
                                      );

                                      log(entities.value.length.toString());
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      padding: EdgeInsets.zero,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: Icon(
                                        Icons.expand_more_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      offset: const Offset(0, -12),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: Radius.circular(40),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 15,
                        child: SizedBox(
                          height: 60,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(103, 0, 0, 0),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    ).then((_) {
      selectedPathId.dispose();
      entities.dispose();
    });
  }

  static Future<List<AssetEntity>> _getAssets({
    required AssetPathEntity path,
    int page = 0,
  }) async {
    return await path.getAssetListPaged(page: page, size: 100);
  }
}

class GridItemImage extends StatefulWidget {
  const GridItemImage({super.key, required this.entity, required this.onTap});

  final AssetEntity entity;
  final VoidCallback onTap;

  @override
  State<GridItemImage> createState() => _GridItemImageState();
}

class _GridItemImageState extends State<GridItemImage> {
  Uint8List? _thumbnailData;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final thumbnailData = await widget.entity.thumbnailDataWithSize(
        ThumbnailSize(200, 200),
        quality: 100,
      );
      if (mounted) {
        setState(() {
          _thumbnailData = thumbnailData;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.grey[800],
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    if (_hasError || _thumbnailData == null) {
      return Container(
        color: Colors.grey[800],
        child: const Icon(Icons.broken_image, color: Colors.white54),
      );
    }

    return InkWell(
      onTap: widget.onTap,
      child: Image.memory(
        _thumbnailData!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
