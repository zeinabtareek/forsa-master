import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/CategoryController.dart';
import 'package:fursa/Controller/ImagePickerController.dart';
import 'package:fursa/Controller/MyProductsController.dart';
import 'package:fursa/Controller/ProductsController.dart';
import 'package:fursa/Controller/deal_controller.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/decoration_helper.dart';
import 'package:fursa/View/IntroScreens/RegisterScreen.dart/CustomTextForms.dart';
import 'package:fursa/View/MainScreens/AddDealScreen/Body/add_pictures.dart';
import 'package:fursa/View/MainScreens/AddDealScreen/Body/product_category.dart';
import 'package:fursa/View/MainScreens/AddDealScreen/Body/sub_category.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SubScreens/UpdateMyProduct/updateCategoriesDropDown.dart';
import 'package:provider/provider.dart';

class UpdateMyProduct extends StatefulWidget {
  @override
  State<UpdateMyProduct> createState() => _UpdateMyProductState();
}

class _UpdateMyProductState extends State<UpdateMyProduct> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryController>(context, listen: false)
        .getMainCat(context: context);
    Provider.of<ProductsController>(context, listen: false)
        .getInialValues(context: context);
  }

  bool loader = false;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer4<MyProductsController, ImagePickerController,
        ProductsController, CategoryController>(
      builder: (context, myProductsController, imagePickerController,
              productsController, categoryController, child) =>
          Scaffold(
        body: productsController.productStage == ProductsControllerStage.LOADING
            ? Container()
            : Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      AppBarBack(title: 'update_deal'),
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
                                  controller:
                                      productsController.updateProductTitle,
                                  hintText: 'productName',
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: updateCategoriesDropDown(),
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
                                RegisterTextField(
                                  validator: (String fname) {
                                    if (fname.isEmpty) {
                                    } else {}
                                    return;
                                  },
                                  controller:
                                      productsController.updateProductprice,
                                  hintText: 'productPrice',
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
                                RegisterTextField(
                                  validator: (String fname) {
                                    if (fname.isEmpty) {
                                    } else {}
                                    return;
                                  },
                                  controller:
                                      productsController.updateProductDiscount,
                                  hintText: 'discount',
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                    width: media.width,
                                    height: 100,
                                    decoration: decorationRadius(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: TextFormField(
                                        controller: productsController
                                            .updateProductDescription,
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
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
                                    ? Container(
                                        height: 200,
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          children: List.generate(
                                            productsController.myProductDetails
                                                .data.productImages.length,
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
                                                    child:
                                                        CustomFadNetWorkImage(
                                                      width: 150.0,
                                                      height: 150.0,
                                                      imagePath:
                                                          productsController
                                                              .myProductDetails
                                                              .data
                                                              .productImages[
                                                                  index]
                                                              .image,
                                                    ),
                                                  ),
                                                ),
                                                //   Positioned(
                                                //     right: 10,
                                                //     top: 10,
                                                //     child: InkWell(
                                                //       onTap: () {
                                                //         setState(() {
                                                //           // imagePickerController
                                                //           //     .imagefiles
                                                //           //     .removeAt(index);
                                                //         });
                                                //       },
                                                //       child: Container(
                                                //         width: 40,
                                                //         height: 40,
                                                //         child: Icon(
                                                //           Icons.close,
                                                //           color: Colors.white,
                                                //           size: 40,
                                                //         ),
                                                //         decoration: BoxDecoration(
                                                //             shape:
                                                //                 BoxShape.circle,
                                                //             color: buttonColor1
                                                //                 .withOpacity(
                                                //                     0.6)),
                                                //       ),
                                                //     ),
                                                //   )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 200,
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
                                                      width: 150,
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
                                loader
                                    ? const SizedBox()
                                    : DefaultAppButton(
                                        onPressed: () {
                                          setState(() {
                                            loader = true;
                                          });
                                          productsController
                                              .updateProduct(
                                                  context: context,
                                                  productId: productsController
                                                      .myProductDetails
                                                      .data
                                                      .productDetails
                                                      .id)
                                              .then((value) {
                                            setState(() {
                                              loader = false;
                                            });
                                          });
                                        },
                                        text: 'update',
                                      ),
                                const SizedBox(height: 40),
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
