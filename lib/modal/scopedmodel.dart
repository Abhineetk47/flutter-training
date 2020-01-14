import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as prefix0;
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scoped_model/scoped_model.dart';

class FirebaseModel extends Model {
  File image;
  String uploadedFileURL;
  PermissionStatus _status;
  BuildContext context;
  TextEditingController taskTitleInputController;
  TextEditingController taskDescripInputController;
  final String uid;

  FirebaseModel(this.uid); //include this

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((imagee) {
      image = imagee;
      uploadFile();
      notifyListeners();
    });
    notifyListeners();
  }

  Future uploadFile() async {
    String filename = prefix0.basename(image.path);
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      uploadedFileURL = fileURL;
    });
    notifyListeners();
  }

  void askPermission() {
    PermissionHandler()
        .requestPermissions([PermissionGroup.camera]).then(_onStatusRequested);
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> value) {
    final status = value[PermissionGroup.camera];
    if (status == PermissionStatus.granted) {
      imageSelectorCamera();
    } else {
      updateStatus(status);
    }
  }

  updateStatus(PermissionStatus value) {
    if (value != _status) {
      _status = value;
    }
    notifyListeners();
  }

  clearSelection() {}
  void imageSelectorCamera() async {
    Navigator.pop(context);
    await ImagePicker.pickImage(
      source: ImageSource.camera,
    ).then((imagee) {
      image = imagee;
    });
    print("the value of the photo selected from camera");
    notifyListeners();
  }
}
