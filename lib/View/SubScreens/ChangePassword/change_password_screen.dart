import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/AuthController.dart';
import 'package:fursa/Controller/UserDataController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<AuthController>(
      builder: (context, authController, child) => Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            AppBarBack(title: 'changePassword'),
            SliverToBoxAdapter(
              child: Container(
                width: media.width,
                height: media.height * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Container(
                        width: media.width,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: standaredBoxShadow),
                        child: TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                '${AppLocalizations.of(context).trans('password')}',
                            hintStyle: cairoW400(color: Color(0xffB3B3B3)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: media.width,
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: standaredBoxShadow,
                          ),
                          child: TextFormField(
                            controller: passwordConfirmation,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  '${AppLocalizations.of(context).trans('confirm_pass')}',
                              hintStyle: cairoW400(color: Color(0xffB3B3B3)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 36),
                    loader
                        ? Center(
                            child: CircularProgressIndicator(
                              color: color1,
                            ),
                          )
                        : DefaultAppButton(
                            text: 'edit_profile_now',
                            onPressed: () {
                              setState(() {
                                loader = true;
                              });
                              authController
                                  .updateUserPassword(context, password.text,
                                      passwordConfirmation.text)
                                  .then((_) {
                                setState(() {
                                  loader = false;
                                });
                              });
                            },
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
