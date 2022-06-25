import 'dart:io';

import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'login.dart';
import 'native_camera.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  //利用可能なカメラを取得する
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  //iosのエミュレータはカメラがないので、カメラを取得できない。
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  if(Platform.isAndroid || (Platform.isIOS && iosInfo.isPhysicalDevice)) {
    final firstCamera = cameras.first;
  }

  //firebase_auth用の初期化
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      // home: TakePictureScreen(
      //   camera: firstCamera,
      // ),
      home: const LoginScreen(),
    ),
  );
}
