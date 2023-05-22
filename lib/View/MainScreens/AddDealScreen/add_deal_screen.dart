import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/CategoryController.dart';
import 'package:fursa/Controller/ImagePickerController.dart';
import 'package:fursa/Controller/MyProductsController.dart';
import 'package:fursa/Controller/deal_controller.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Helper/decoration_helper.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/IntroScreens/RegisterScreen.dart/CustomTextForms.dart';
import 'package:fursa/View/MainScreens/AddDealScreen/Body/product_category.dart';
import 'package:fursa/View/MainScreens/AddDealScreen/Body/sub_category.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:provider/provider.dart';

import 'Body/add_pictures.dart';
import 'Body/description_text_field.dart';

class AddDealScreen extends StatefulWidget {
  @override
  State<AddDealScreen> createState() => _AddDealScreenState();
}

class _AddDealScreenState extends State<AddDealScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryController>(context, listen: false)
        .getMainCat(context: context);
  }

  bool loader = false;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer3<MyProductsController, ImagePickerController,
        CategoryController>(
      builder: (context, myProductsController, imagePickerController,
              categoryController, child) =>
          Scaffold(
        body: Stack(
          children: [
            LocaleStorage.token == null
                ? CustomScrollView(
                    slivers: [
                      AppBarBack(title: 'addDeal'),
                      SliverToBoxAdapter(
                        child: Container(
                          width: media.width,
                          height: media.height * 0.8,
                          child: Center(
                              child: AppLocalizations.of(context)
                                          .locale
                                          .languageCode ==
                                      'en'
                                  ? Text('Please login to be able to add deals')
                                  : Text(
                                      'برجاء تسجيل الدخول لكي يمكنك اضافة الصفقات')),
                        ),
                      )
                    ],
                  )
                : CustomScrollView(
                    slivers: [
                      AppBarBack(title: 'addDeal'),
                      SliverToBoxAdapter(
                        child: Consumer<DealController>(
                          builder: (context, dealController, ch) => Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                    '${AppLocalizations.of(context).trans('productName')}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                RegisterTextField(
                                  validator: (String fname) {
                                    if (fname.isEmpty) {
                                    } else {}
                                    return;
                                  },
                                  controller: myProductsController.productTitle,
                                  hintText: 'productName',
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                    '${AppLocalizations.of(context).trans('main_category')}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: CategoriesDropDown(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                    '${AppLocalizations.of(context).trans('productPrice')}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                    width: media.width,
                                    height: 50,
                                    decoration: decorationRadius(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            myProductsController.productPrice,
                                        decoration: InputDecoration(
                                          hintText:
                                              '${AppLocalizations.of(context).trans('productPrice')}',
                                          hintStyle: cairoW400(
                                              color: Color(0xFFB3B3B3)),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                    '${AppLocalizations.of(context).trans('discount')}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                    width: media.width,
                                    height: 50,
                                    decoration: decorationRadius(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: myProductsController
                                            .productDiscount,
                                        decoration: InputDecoration(
                                          hintText:
                                              '${AppLocalizations.of(context).trans('discount')}',
                                          hintStyle: cairoW400(
                                              color: Color(0xFFB3B3B3)),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                    '${AppLocalizations.of(context).trans('productDescription')}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  height: 100,
                                  decoration: decorationRadius(),
                                  child: TextFormField(
                                    maxLines: 5,
                                    controller:
                                        myProductsController.productdescription,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () =>
                                      imagePickerController.multiImagePicker(),
                                  child: AddPictuesTextField(
                                    validator: (String fname) {
                                      if (fname.isEmpty) {
                                      } else {}
                                      return;
                                    },
                                    controller:
                                        dealController.productNameController,
                                    hintText: 'addPictures',
                                  ),
                                ),
                                const SizedBox(height: 6),
                                imagePickerController.imagefiles.isEmpty
                                    ? const SizedBox()
                                    : Container(
                                        height: 180,
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          children: List.generate(
                                            imagePickerController
                                                .imagefiles.length,
                                            (index) => Stack(
                                              children: [
                                                Container(
                                                  width: media.width - 80,
                                                  height: 150,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    boxShadow:
                                                        standaredBoxShadow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: Image.file(
                                                      File(imagePickerController
                                                          .imagefiles[index]
                                                          .path),
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  top: 10,
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        imagePickerController
                                                            .imagefiles
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 40,
                                                      height: 40,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                        size: 40,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: buttonColor1
                                                              .withOpacity(
                                                                  0.6)),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                const SizedBox(height: 40),
                                loader
                                    ? SizedBox()
                                    : DefaultAppButton(
                                        onPressed: () {
                                          setState(() {
                                            loader = true;
                                          });
                                          myProductsController
                                              .addNewProduct(context: context)
                                              .then((value) {
                                            setState(() {
                                              loader = false;
                                            });
                                          });
                                        },
                                        text: 'addDeal',
                                      )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
            loader
                ? Container(
                    width: media.width,
                    height: media.height,
                    color: Colors.white.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: color1,
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
