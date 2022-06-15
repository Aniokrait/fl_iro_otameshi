import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class NativeCamera extends StatefulWidget {
  const NativeCamera({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NativeCameraState();
}

class _NativeCameraState extends State {
  final _picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() async {
      if (pickedFile != null) {
        print('aaaaaaaaaaaaaaaaaaaa${pickedFile.path}');
        //撮影した写真をストレージに保存
        await ImageGallerySaver.saveImage(await pickedFile.readAsBytes());
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ネイティブのカメラ'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getImageFromCamera();
        },
      ),
    );
  }
}
