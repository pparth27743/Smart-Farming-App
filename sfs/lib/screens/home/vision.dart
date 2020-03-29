import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Vision extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: ImageCapture());
  }
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(sourcePath: _imageFile.path);
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 30),
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
              SizedBox(width: 50),
              IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
              if (_imageFile != null) ...[
                SizedBox(width: 40),
                Row(children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.crop),
                    onPressed: _cropImage,
                  ),
                  SizedBox(width: 50),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: _clear,
                  ),
                ]),
              ]
            ],
          ),
          if (_imageFile != null) ...[
            Uploader(file: _imageFile),
            SizedBox(
              height: 10,
            ),
            Image.file(_imageFile),
          ],
        ],
      ),
    );
  }
}

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage(
      storageBucket: 'gs://smart-farm-system-94f3f.appspot.com');

  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filepath = 'images/${DateTime.now()}.png';
    setState(() {
      _uploadTask = _storage.ref().child(filepath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;

          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;

          return Column(children: [
            if (_uploadTask.isComplete)
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    "Done Uplaoding",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 50),
                  FlatButton(
                    child: Text(
                      "Disease Scan",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey[900],
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.green[300],
                    onPressed: () {},
                  )
                ],
              ),
            SizedBox(height: 10),
            if (_uploadTask.isPaused)
              FlatButton(
                child: Icon(Icons.play_arrow),
                onPressed: _uploadTask.resume,
              ),
            if (_uploadTask.isInProgress)
              FlatButton(
                  child: Icon(Icons.pause), onPressed: _uploadTask.pause),
            LinearProgressIndicator(value: progressPercent),
            SizedBox(
              height: 10,
            ),
            Text(
              '${(progressPercent * 100).toStringAsFixed(2)} %',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold),
            ),
          ]);
        },
      );
    } else {
      return FlatButton.icon(
          onPressed: _startUpload,
          icon: Icon(Icons.cloud_upload),
          label: Text('Upload to Firebase'));
    }
  }
}
