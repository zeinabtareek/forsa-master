import 'package:flutter/material.dart';
import 'package:fursa/Controller/AuthController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/IntroScreens/RegisterScreen.dart/RegisterBody.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<AuthController>(
      builder: (context, authController, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  width: media.width,
                  alignment: AlignmentDirectional.bottomStart,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF00489A), Color(0xFF1D6BC3)],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 30),
                    child: Text(
                      '${AppLocalizations.of(context).trans('create_account')}',
                      style: cairoW700(color: Color(0xFFFFD954), size: 30),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: RegisterBody(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
