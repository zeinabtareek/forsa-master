import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fursa/Controller/CategoryController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/subCategoryScreen/SubCategory.dart';
import 'package:provider/provider.dart';

class MainCategoriesScreen extends StatefulWidget {
  MainCategoriesScreen({Key key}) : super(key: key);

  @override
  State<MainCategoriesScreen> createState() => _MainCategoriesScreenState();
}

class _MainCategoriesScreenState extends State<MainCategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CategoryController>(context, listen: false)
        .getMainCat(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<CategoryController>(
      builder: (context, categoryController, child) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFF00489A),
              elevation: 0.0,
              centerTitle: true,
              title:
                  Text('${AppLocalizations.of(context).trans('categories')}'),
            ),
            categoryController.categoryStage == CategoryControllerStage.LOADING
                ? SliverToBoxAdapter(
                    child: Container(
                    width: media.width,
                    height: media.height * 0.9,
                    child: Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: standaredBoxShadow,
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: buttonColor1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Loading',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
                : SliverPadding(
                    padding: const EdgeInsets.all(15),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return InkWell(
                            onTap: () {
                              categoryController.setMainCatId(categoryController
                                  .mainCatList.mainCategoryList[index].id
                                  .toString());
                              fadNavigate(
                                context,
                                SubCategoryScreen(
                                  title:
                                      '${categoryController.mainCatList.mainCategoryList[index].title}',
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: standaredBoxShadow,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CustomFadNetWorkImage(
                                      imagePath:
                                          '${categoryController.mainCatList.mainCategoryList[index].image}',
                                      width: double.maxFinite,
                                      boxFit: BoxFit.fill,
                                      height: 110.0,
                                    ),
                                  ),
                                  Text(
                                    '${categoryController.mainCatList.mainCategoryList[index].title}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: categoryController
                            .mainCatList.mainCategoryList.length,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
