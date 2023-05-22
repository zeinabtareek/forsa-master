import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ImagePickerControllerStage { LOADING, DONE, ERROR }

class ImagePickerController extends ChangeNotifier {
  XFile imageFile;

  Future captureImage(context, ImageSource imageSource) async {
    imageFile = null;
    try {
      await ImagePicker().pickImage(source: imageSource).then((val) {
        imageFile = val;
      });

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  resetImagePicker() {
    imageFile = null;
    notifyListeners();
  }

  void showPicker(context) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library,
                          color: Theme.of(context).primaryColor),
                      title: new Text('Photo Library'),
                      onTap: () {
                        captureImage(context, ImageSource.gallery);
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: new Text('Camera'),
                    onTap: () {
                      captureImage(context, ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  XFile personalImageFile;
  capturePersonalImage(context, ImageSource imageSource) async {
    personalImageFile = null;
    try {
      await ImagePicker().pickImage(source: imageSource).then((val) {
        personalImageFile = val;
      });

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  void showPersonalPicker(context) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library,
                          color: Theme.of(context).primaryColor),
                      title: new Text('Photo Library'),
                      onTap: () {
                        capturePersonalImage(context, ImageSource.gallery);
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: new Text('Camera'),
                    onTap: () {
                      capturePersonalImage(context, ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  XFile frontIDImageFile;
  capturefrontIDImageFileImage(context, ImageSource imageSource) async {
    frontIDImageFile = null;
    try {
      await ImagePicker().pickImage(source: imageSource).then((val) {
        frontIDImageFile = val;
      });

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  void showfrontIDImageFilePicker(context) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library,
                          color: Theme.of(context).primaryColor),
                      title: new Text('Photo Library'),
                      onTap: () {
                        capturefrontIDImageFileImage(
                            context, ImageSource.gallery);
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: new Text('Camera'),
                    onTap: () {
                      capturefrontIDImageFileImage(context, ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  resetFrontIDImageFile() {
    frontIDImageFile = null;
    notifyListeners();
  }

  XFile backIDImageFile;
  capturebackIDImageFileFileImage(context, ImageSource imageSource) async {
    backIDImageFile = null;
    try {
      await ImagePicker().pickImage(source: imageSource).then((val) {
        backIDImageFile = val;
      });

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  resetbackIDImageFile() {
    backIDImageFile = null;
    notifyListeners();
  }

  void showbackIDImageFilemageFilePicker(context) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library,
                          color: Theme.of(context).primaryColor),
                      title: new Text('Photo Library'),
                      onTap: () {
                        capturebackIDImageFileFileImage(
                            context, ImageSource.gallery);
                      }),
                  new ListTile(
                    leading: new Icon(
                      Icons.photo_camera,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: new Text('Camera'),
                    onTap: () {
                      capturebackIDImageFileFileImage(
                          context, ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  final ImagePicker imgpicker = ImagePicker();
  List<XFile> imagefiles = [];
  multiImagePicker() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
    notifyListeners();
  }
}
