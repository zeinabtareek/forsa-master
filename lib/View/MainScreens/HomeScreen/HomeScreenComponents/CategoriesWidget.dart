import 'package:flutter/material.dart';
import 'package:fursa/Controller/CategoryController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/decoration_helper.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/Models/CategoryModel.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/MainCategoriesScreen/MainCategoriesScreen.dart';
import 'package:fursa/View/SubScreens/subCategoryScreen/SubCategory.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatefulWidget {
  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<CategoryController>(
      builder: (context, categoryController, child) => SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppLocalizations.of(context).trans('categories')}',
                    style: cairoW700(color: Colors.black, size: 16),
                  ),
                  InkWell(
                    onTap: () {
                      fadNavigate(context, MainCategoriesScreen());
                    },
                    child: Text(
                      '${AppLocalizations.of(context).trans('all')}',
                      style: cairoW600(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: media.width,
                height: 170,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        categoryController.someMainCatList == null
                            ? 0
                            : categoryController
                                .someMainCatList.mainCategoryList.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  categoryController.setMainCatId(
                                      categoryController.someMainCatList
                                          .mainCategoryList[index].id
                                          .toString());

                                  fadNavigate(
                                    context,
                                    SubCategoryScreen(
                                      title: '${categories[index].name}',
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: decorationRadius(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        '${categoryController.someMainCatList.mainCategoryList[index].image}',
                                        fit: BoxFit.contain,
                                        width: 105,
                                        height: 100,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '${categoryController.someMainCatList.mainCategoryList[index].title}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff00489A)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
