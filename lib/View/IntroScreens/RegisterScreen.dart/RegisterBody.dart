import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fursa/Controller/AuthController.dart';
import 'package:fursa/Controller/ImagePickerController.dart';
import 'package:fursa/Controller/SettingsController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/decoration_helper.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/Models/SettingsModel.dart';
import 'package:fursa/View/IntroScreens/LoginScreen/LoginScreen.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'CustomTextForms.dart';

class RegisterBody extends StatefulWidget {
  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer3<AuthController, SettingsController, ImagePickerController>(
      builder: (context, authController, settingsController,
              imagePickerController, ch) =>
          Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: InkWell(
                onTap: () {
                  imagePickerController.showPersonalPicker(context);
                },
                child: Container(
                    width: media.width,
                    height: 100,
                    decoration: decorationRadius(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'برجاء اضافه الصورة الشخصية',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                boxShadow: standaredBoxShadow,
                                color: color1.withOpacity(0.5),
                                shape: BoxShape.circle),
                            child:
                                imagePickerController.personalImageFile != null
                                    ? ClipOval(
                                        child: Image.file(
                                          File(imagePickerController
                                              .personalImageFile.path),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : SizedBox(),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            RegisterTextField(
              validator: (String fname) {
                if (fname.isEmpty) {
                } else {}
                return;
              },
              controller: authController.registerFirstNameController,
              hintText: 'first_name',
            ),
            RegisterTextField(
              validator: (String fname) {
                if (fname.isEmpty) {
                } else {}
                return;
              },
              controller: authController.registerLastNameController,
              hintText: 'last_name',
            ),
            RegisterTextField(
              validator: (String fname) {
                if (fname.isEmpty) {
                } else {}
                return;
              },
              controller: authController.registerEmailController,
              hintText: 'email',
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: AbsorbPointer(
                          absorbing: true,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: '+971',
                              hintStyle: cairoW400(color: Color(0xFFB3B3B3)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: standaredBoxShadow,
                        borderRadius: standeredContainerBorderRadius,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: standaredBoxShadow,
                          borderRadius: standeredContainerBorderRadius),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: authController.registerMobileController,
                          decoration: InputDecoration(
                            hintText:
                                '${AppLocalizations.of(context).trans('mobile')}',
                            hintStyle: cairoW400(color: Color(0xFFB3B3B3)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: standaredBoxShadow,
                  color: Colors.white,
                ),
                child: DropdownButtonFormField<Cities>(
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
                    dropdownColor: Colors.white,
                    // iconEnabledColor: Color(0xFF374957),
                    icon: Image.asset(
                      'images/arrow_down_list.png',
                      width: 30,
                      height: 30,
                    ),
                    hint: Text('اختر  المدينة'),
                    iconDisabledColor: Color(0xFF374957),
                    // value: selectedSubCat,
                    items: settingsController.settings.cities
                        .map(
                          (item) => DropdownMenuItem<Cities>(
                            value: item,
                            child: Text(
                              item.name,
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
                    onChanged: (Cities item) {
                      authController.setCityId(item.id);
                    }),
              ),
            ),
            RegisterTextField(
              validator: (String fname) {
                if (fname.isEmpty) {
                } else {}
                return;
              },
              controller: authController.registerAddressController,
              hintText: 'address',
            ),
            RegisterTextField(
              validator: (String fname) {
                if (fname.isEmpty) {
                } else {}
                return;
              },
              controller: authController.registerPasswordController,
              hintText: 'password',
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('اضافة بطاقه الهوية من الوجه'),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                imagePickerController.showfrontIDImageFilePicker(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(15),
                  color: color1.withOpacity(0.6),
                  strokeWidth: 1,
                  child: imagePickerController.frontIDImageFile != null
                      ? Image.file(
                          File(imagePickerController.frontIDImageFile.path),
                          width: 150,
                          height: 150,
                        )
                      : Container(
                          width: media.width,
                          height: 80,
                          child: Icon(
                            Icons.add,
                            color: color1,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('اضافة بطاقه الهوية من الخلف'),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                imagePickerController
                    .showbackIDImageFilemageFilePicker(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(15),
                  color: color1.withOpacity(0.6),
                  strokeWidth: 1,
                  child: imagePickerController.backIDImageFile != null
                      ? Image.file(
                          File(imagePickerController.backIDImageFile.path),
                          width: 150,
                          height: 150,
                        )
                      : Container(
                          width: media.width,
                          height: 80,
                          child: Icon(
                            Icons.add,
                            color: color1,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                fadNavigate(context, LoginScreen());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  '${AppLocalizations.of(context).trans('have_an_account2')}',
                  style: cairoW600(color: Color(0xFF006CE5), size: 14),
                ),
              ),
            ),
            const SizedBox(height: 40),
            authController.authStage == AuthControllerStage.LOADING
                ? Center(child: CircularProgressIndicator())
                : DefaultAppButton(
                    onPressed: () {
                      authController.registerSubmit(
                          context: context, scaffoldkey: _scaffoldkey);
                    },
                    text: 'sign_up',
                  ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
