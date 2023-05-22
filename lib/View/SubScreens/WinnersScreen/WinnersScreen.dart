import 'package:flutter/material.dart';
import 'package:fursa/Controller/WinnersController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/LocaleStorage.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:provider/provider.dart';

class WinnersScreen extends StatefulWidget {
  WinnersScreen({Key key}) : super(key: key);

  @override
  State<WinnersScreen> createState() => _WinnersScreenState();
}

class _WinnersScreenState extends State<WinnersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WinnersController>(context, listen: false)
        .getWinners(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<WinnersController>(
      builder: (context, winnersController, child) => Scaffold(
          body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: color1,
            title:
                Text('Winners', style: TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            toolbarHeight: 74,
            pinned: true,
          ),
          winnersController.winnersStage == WinnersControllerStage.LOADING
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
              : SliverToBoxAdapter(
                  child: winnersController.winners.data.isEmpty
                      ? Container(
                          height: media.height * 0.8,
                          width: media.width,
                          child: Center(
                              child: AppLocalizations.of(context)
                                          .locale
                                          .languageCode ==
                                      'en'
                                  ? Text(
                                      'There are no winners yet',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      'لا يوجد فائزين حتى الان',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    )),
                        )
                      : Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: List.generate(
                                  winnersController.winners.data.length,
                                  (index) => Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, right: 10, left: 10),
                                        child: Container(
                                          width: media.width,
                                          height: media.height / 2.5,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: standaredBoxShadow,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child:
                                                        CustomFadNetWorkImage(
                                                      width: double.maxFinite,
                                                      height: 140.0,
                                                      boxFit: BoxFit.contain,
                                                      imagePath:
                                                          '${winnersController.winners.data[index].productImage}',
                                                    )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Text(
                                                  '${AppLocalizations.of(context).trans('congratulations')}',
                                                  style: TextStyle(
                                                    color: color1,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Text(
                                                  'لقد حصل ${winnersController.winners.data[index].userName} علي ${winnersController.winners.data[index].productName} ',
                                                  style: TextStyle(
                                                    color: color2,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Text(
                                                  'بتاريخ :  ${winnersController.winners.data[index].date}',
                                                  style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                            )
                          ],
                        ),
                ),
        ],
      )),
    );
  }
}
