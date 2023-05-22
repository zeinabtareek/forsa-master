import 'package:flutter/material.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Controller/pageIndexController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/Models/LanguageModel.dart';
import 'package:fursa/View/IntroScreens/SplashScreen/SplashScreen.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguageCode;

  List<LanguageModel> languages = [
    LanguageModel(id: 1, code: 'ar', name: 'عربي', isSelected: false),
    LanguageModel(id: 2, code: 'en', name: 'English', isSelected: false),
  ];

  @override
  void initState() {
    super.initState();
    var _locale = Provider.of<LocalizationController>(context, listen: false).locale.languageCode;

    getCurrentLanguage();
  }

  getCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String language = Provider.of<LocalizationController>(context, listen: false).locale.languageCode;
    if (language != null) {
      for (int i = 0; i < languages.length; i++) {
        if (languages[i].code == language) {
          setState(() {
            languages[i].isSelected = true;
            selectedLanguageCode = languages[i].code;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          AppBarBack(title: 'app_language'),
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    '${AppLocalizations.of(context).trans('choose_your_language')}',
                    style: cairoW500(
                      color: const Color(0xFF4D4D4D),
                      size: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        languages.length,
                        (index) => InkWell(
                              onTap: () async {
                                for (int i = 0; i < languages.length; i++) {
                                  setState(() {
                                    languages[i].isSelected = false;
                                    languages[index].isSelected = true;
                                    if (languages[i].isSelected) {
                                      selectedLanguageCode = languages[i].code;
                                    }
                                  });
                                }
                                final prefs = await SharedPreferences.getInstance();
                                Provider.of<LocalizationController>(
                                  context,
                                  listen: false,
                                ).setLocale(Locale(selectedLanguageCode));
                                prefs.setString(
                                  'language',
                                  selectedLanguageCode,
                                );

                                fadNavigate(
                                  context,
                                  SplashScreen(),
                                );
                                Provider.of<PageIndexController>(context, listen: false)
                                    .changeIndexFunctionWithOutNotify(0);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Container(
                                  width: media.width,
                                  height: 50,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: languages[index].isSelected ? color1 : Colors.transparent,
                                    border: Border.all(
                                      color: languages[index].isSelected ? color1 : Colors.blue,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${languages[index].name}',
                                          style: TextStyle(
                                            height: 1,
                                            fontSize: 16,
                                            color: languages[index].isSelected
                                                ? Colors.white
                                                : Colors.grey[700],
                                          ),
                                        ),
                                        Icon(
                                          Icons.check,
                                          size: 18,
                                          color: languages[index].isSelected
                                              ? Colors.white
                                              : Colors.transparent,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
