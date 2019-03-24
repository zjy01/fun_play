import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Publish extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<Publish> {
  List<CameraDescription> cameras;
  CameraController controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _setupCameras();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return Container();
    }
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Transform.scale(
      scale: controller.value.aspectRatio / deviceRatio,
      child: Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller),
        ),
      ),
    );
    // return AspectRatio(
    //     aspectRatio:
    //     controller.value.aspectRatio,
    //     child: CameraPreview(controller));
  }

  Future<void> _setupCameras() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[1], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isReady = true;
      });
    });
  }
}
