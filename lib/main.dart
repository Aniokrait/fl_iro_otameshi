import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:iroiro_flutter_tameshi/camera.dart';

import 'native_camera.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  //利用可能なカメラを取得する
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      // home: TakePictureScreen(
      //   camera: firstCamera,
      // ),
      home: NativeCamera(),
    ),
  );
}
