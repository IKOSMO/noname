import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

@RoutePage()
class SettingsFullscreenImageScreen extends StatefulWidget {
  const SettingsFullscreenImageScreen({
    super.key,
    required this.entity,
    required this.thumbnailData,
  });

  final AssetEntity entity;
  final Uint8List thumbnailData;

  @override
  State<SettingsFullscreenImageScreen> createState() =>
      _SettingsFullscreenImageScreenState();
}

class _SettingsFullscreenImageScreenState
    extends State<SettingsFullscreenImageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.widthOf(context),
          height: MediaQuery.heightOf(context),
          child: Image.memory(
            widget.thumbnailData,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ],
    );
  }
}
