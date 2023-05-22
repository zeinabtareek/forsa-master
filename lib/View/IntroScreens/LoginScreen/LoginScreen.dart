import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fursa/Controller/AuthController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/decoration_helper.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/IntroScreens/RegisterScreen.dart/RegisterScreen.dart';
import 'package:fursa/View/MainScreens/NavigationHome/NavigationHomeScreen.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<AuthController>(
      builder: (context, authController, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: Color(0xFFE5E5E5),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // 'Create Account',
                          '${AppLocalizations.of(context).trans('welcome2')}',
                          style: cairoW700(color: Color(0xFFFFD954), size: 25),
                        ),
                        SizedBox(height: 8),
                        Text(
                          // 'Create Account',
                          '${AppLocalizations.of(context).trans('sign_in')}',
                          style: cairoW700(color: Color(0xFFFFD954), size: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Container(
                          width: media.width,
                          height: 50,
                          decoration: decorationRadius(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(fontSize: 14),
                              controller: authController.emailController,
                              decoration: InputDecoration(
                                hintText:
                                    '${AppLocalizations.of(context).trans('email')}',
                                hintStyle: cairoW400(
                                    color: Color(0xFFB3B3B3), size: 14),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Container(
                        width: media.width,
                        height: 50,
                        decoration: decorationRadius(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: authController.passwordController,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              hintText:
                                  '${AppLocalizations.of(context).trans('password')}',
                              hintStyle:
                                  cairoW400(color: Color(0xFFB3B3B3), size: 14),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          fadNavigate(context, RegisterScreen());
                        },
                        child: Container(
                          width: media.width,
                          child: Text(
                            '${AppLocalizations.of(context).trans('have_no_acc_register2')}',
                            textAlign: TextAlign.start,
                            style:
                                cairoW600(color: Color(0xFF006CE5), size: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    authController.authStage == AuthControllerStage.LOADING
                        ? CircularProgressIndicator()
                        : DefaultAppButton(
                            onPressed: () {
                              authController.loginSubmit(
                                  context: context, scaffoldkey: _scaffoldkey);
                            },
                            text: 'login',
                          ),
                    authController.authStage == AuthControllerStage.LOADING
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: InkWell(
                              onTap: () {
                                fadNavigate(context, NavigationHomeScreen());
                              },
                              child: Container(
                                  width: media.width,
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      '${AppLocalizations.of(context).trans('userGuest')}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: buttonColor1, width: 2),
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                    const SizedBox(height: 40),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
