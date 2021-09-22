import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp/presentation/widgets/theme/style.dart';

class CameraPage extends StatefulWidget {
  final List? data;
  final int? id;

  CameraPage({this.data, this.id});

  @override
  _CameraPageState createState() => new _CameraPageState();
}

Future<bool> cameraPermission() async {
  var _status = await Permission.camera.status;
  if (_status.isGranted) {
    return true;
  }
  return false;
}

class _CameraPageState extends State<CameraPage> {
  XFile? _image;

  Future getCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(child: _bodyCameraWidget()),
      ),
      //   FutureBuilder(
      //   future: cameraPermission(),
      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //     if (snapshot.hasData) {
      //       if (snapshot.data == true) {
      //         return Container(
      //           child: _bodyCameraWidget(),
      //         );
      //       }
      //     }
      //     return Center(
      //       child: Container(
      //         child: ElevatedButton(
      //           child: Text("Camera Settings"),
      //           style: ButtonStyle(
      //               backgroundColor:
      //                   MaterialStateProperty.all<Color>(primaryColor)),
      //           onPressed: () {
      //             openAppSettings();
      //           },
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }

  Widget _bodyCameraWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 200.0,
          child: Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path)),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        getGallery();
                      },
                      child: Text("Picture from gallery"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        getCamera();
                      },
                      child: Text("Take picture"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
