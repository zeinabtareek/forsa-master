import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class DealController extends ChangeNotifier {
  TextEditingController productNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController password = TextEditingController();
  List<Product> products = [
    Product(id: '1', name: 'Product 1'),
    Product(id: '2', name: 'Product 2'),
    Product(id: '3', name: 'Product 3'),
    Product(id: '4', name: 'Product 4'),
  ];
  Product _currentProduct = Product();

  void changeProduct(Product product) {
    _currentProduct = product;
  }

  List<Product> productsSubCategory = [
    Product(id: '1', name: 'Product Sub Category 1'),
    Product(id: '2', name: 'Product Sub Category 2'),
    Product(id: '3', name: 'Product Sub Category 3'),
    Product(id: '4', name: 'Product Sub Category 4'),
  ];
  Product _currentSubCategory = Product();

  void changeSubCategory(Product product) {
    _currentSubCategory = product;
  }

  ///
  /// Open Picker
  ///
  void openImagePicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context).locale.languageCode == "en"
                    ? 'Pick an Image'
                    : 'التقط صوره',
                style: Theme.of(context).textTheme.headline6.copyWith(),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: TextButton.icon(
                      icon: ImageIcon(AssetImage('images/camera.png'),
                          color: Colors.white),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      label: Text(
                        AppLocalizations.of(context).locale.languageCode == "en"
                            ? 'Use Camera'
                            : 'استخدم الكاميرا',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        _getImage(ImageSource.camera, context);
                        // Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      icon: Icon(
                        Icons.camera,
                        color: Colors.white,
                      ),
                      label: Text(
                        AppLocalizations.of(context).locale.languageCode == "en"
                            ? 'Use Gallery'
                            : 'استخدم المعرض',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        _getImage(ImageSource.gallery, context);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  ///
  /// Get Image
  ///
  final ImagePicker _picker = ImagePicker();
  List<File> images = [];

  Future<void> _getImage(ImageSource source, BuildContext context) async {
    await _picker
        .pickImage(source: source, maxWidth: 400.0)
        .then((XFile image) {
      if (image != null) {
        File x = File(image.path);
        images.add(x);
        notifyListeners();
        Navigator.pop(context);
      }
    });
  }
}

class Product {
  dynamic id;
  dynamic name;

  Product({this.id, this.name});
}
