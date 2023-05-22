import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fursa/Controller/CategoryController.dart';
import 'package:fursa/Controller/MyProductsController.dart';
import 'package:fursa/Controller/ProductsController.dart';
import 'package:fursa/Controller/deal_controller.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Models/MainCategoryDetailsModel.dart';
import 'package:fursa/Models/MainCategoryModel.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:provider/provider.dart';

class CategoriesDropDown extends StatefulWidget {
  CategoriesDropDown({Key key}) : super(key: key);

  @override
  State<CategoriesDropDown> createState() => _CategoriesDropDownState();
}

class _CategoriesDropDownState extends State<CategoriesDropDown> {
  var test = false;

  var selectedMainCat;
  var selectedSubCat;

  @override
  Widget build(BuildContext context) {
    return Consumer4<DealController, CategoryController, MyProductsController,
            ProductsController>(
        builder: (context, dealController, categoryController,
                myProductsController, productsController, child) =>
            categoryController.categoryStage == CategoryControllerStage.LOADING
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      categoryController.mainCatList != null &&
                              categoryController
                                  .mainCatList.mainCategoryList.isEmpty
                          ? Container(
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                child: Text(
                                  '${AppLocalizations.of(context).trans('noZones')}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                            )
                          : categoryController.mainCatList == null
                              ? SizedBox()
                              : Container(
                                  width: double.infinity,
                                  height: 50,
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        standeredContainerBorderRadius,
                                    boxShadow: standaredBoxShadow,
                                    color: Colors.white,
                                  ),
                                  child: DropdownButtonFormField<
                                          MainCategoryItemModel>(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsetsDirectional.only(
                                          start: 16,
                                          end: 8,
                                          bottom: 4,
                                        ),
                                      ),
                                      hint: Text(
                                          '${AppLocalizations.of(context).trans('main_category')}'),
                                      isDense: false,
                                      itemHeight: 55,
                                      dropdownColor: color1,
                                      iconEnabledColor: Color(0xFF374957),
                                      icon: Image.asset(
                                        'images/arrow_down_list.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      iconDisabledColor: Color(0xFF374957),
                                      value: selectedMainCat,
                                      items: categoryController
                                          .mainCatList.mainCategoryList
                                          .map(
                                            (item) => DropdownMenuItem<
                                                MainCategoryItemModel>(
                                              value: item,
                                              child: Text(
                                                item.title,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Color(0xffB3B3B3),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (MainCategoryItemModel item) {
                                        myProductsController
                                            .setSelectedMainCatId(item.id);
                                        setState(() {
                                          selectedSubCat = null;
                                          selectedMainCat = item;
                                        });
                                        categoryController
                                            .setMainCatId(item.id);
                                        categoryController
                                            .getMainCategoryDetails(
                                                context: context);
                                      }),
                                ),
                      selectedMainCat != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                '${AppLocalizations.of(context).trans('sub_category')}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : SizedBox(),
                      selectedMainCat != null &&
                              categoryController.categoryDetailsSatge ==
                                  CategoryControllerStage.DONE
                          ? Container(
                              width: double.infinity,
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: standeredContainerBorderRadius,
                                boxShadow: standaredBoxShadow,
                                color: Colors.white,
                              ),
                              child: DropdownButtonFormField<SubCategories>(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsetsDirectional.only(
                                      start: 16,
                                      end: 8,
                                      bottom: 4,
                                    ),
                                  ),
                                  isDense: false,
                                  itemHeight: 55,
                                  iconEnabledColor: Color(0xFF374957),
                                  icon: Image.asset(
                                    'images/arrow_down_list.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  hint: Text(
                                      '${AppLocalizations.of(context).trans('sub_category')}'),
                                  iconDisabledColor: Color(0xFF374957),
                                  value: selectedSubCat,
                                  items: categoryController
                                      .mainCategoryDetails.data.subCategories
                                      .map(
                                        (item) =>
                                            DropdownMenuItem<SubCategories>(
                                          value: item,
                                          child: Text(
                                            item.title,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Color(0xffB3B3B3),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (SubCategories item) {
                                    myProductsController
                                        .setSelectedSubCatId(item.id);
                                    setState(() {
                                      selectedSubCat = item;
                                    });
                                  }),
                            )
                          : SizedBox(),
                    ],
                  ));
  }
}
