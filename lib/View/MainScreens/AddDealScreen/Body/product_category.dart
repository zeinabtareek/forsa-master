import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fursa/Controller/CategoryController.dart';
import 'package:fursa/Controller/MyProductsController.dart';
import 'package:fursa/Controller/deal_controller.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Models/MainCategoryModel.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:provider/provider.dart';

class ProductDropDown extends StatefulWidget {
  ProductDropDown({Key key}) : super(key: key);

  @override
  State<ProductDropDown> createState() => _ProductDropDownState();
}

class _ProductDropDownState extends State<ProductDropDown> {
  var test = false;

  var selectedMainCat;

  @override
  Widget build(BuildContext context) {
    return Consumer2<MyProductsController, CategoryController>(
      builder: (context, myProductsController, categoryController, child) =>
          // dealController.zoneStage == OrderControllerStage.LOADING
          test
              ? SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: SpinKitCircle(
                    size: 30,
                    color: Colors.white,
                  ),
                )
              : categoryController.mainCatList != null &&
                      categoryController.mainCatList.mainCategoryList.isEmpty
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
                            borderRadius: standeredContainerBorderRadius,
                            boxShadow: standaredBoxShadow,
                            color: Colors.white,
                          ),
                          child: DropdownButtonFormField<MainCategoryItemModel>(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsetsDirectional.only(
                                  start: 16,
                                  end: 8,
                                  bottom: 4,
                                ),
                              ),
                              hint: Text('اختر الفئة الرئيسية'),
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
                                    (item) =>
                                        DropdownMenuItem<MainCategoryItemModel>(
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
                                  selectedMainCat = item;
                                });
                                categoryController.setMainCatId(item.id);
                                categoryController.getMainCategoryDetails(
                                    context: context);
                              }),
                        ),
    );
  }
}
