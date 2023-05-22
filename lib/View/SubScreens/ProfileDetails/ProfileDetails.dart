import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/ImagePickerController.dart';
import 'package:fursa/Controller/SettingsController.dart';
import 'package:fursa/Controller/UserDataController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/Models/SettingsModel.dart';
import 'package:fursa/View/SharedComponents/AppBar/app_bar_back.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';
import 'package:fursa/View/SharedComponents/CustomFadInImage.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:fursa/View/SubScreens/ChangePassword/change_password_screen.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatefulWidget {
  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  var _chosenValue;
  @override
  void initState() {
    super.initState();
    Provider.of<UserDataController>(context, listen: false)
        .getProfileIntialValues();
  }

  bool loader = false;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer3<UserDataController, SettingsController,
        ImagePickerController>(
      builder: (context, userController, settingsController,
              imagePickerController, child) =>
          Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            AppBarBack(title: 'profile'),
            SliverToBoxAdapter(
              child: Container(
                width: media.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ClipOval(
                              child: imagePickerController.personalImageFile !=
                                      null
                                  ? Image.file(
                                      File(imagePickerController
                                          .personalImageFile.path),
                                      width: 120.0,
                                      height: 120.0,
                                      fit: BoxFit.cover,
                                    )
                                  : CustomFadNetWorkImage(
                                      width: 120.0,
                                      height: 120.0,
                                      boxFit: BoxFit.cover,
                                      imagePath:
                                          "${userController.userProfileDetails.user.image}",
                                    ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                imagePickerController
                                    .showPersonalPicker(context);
                              },
                              child: Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: buttonColor1,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      '${AppLocalizations.of(context).trans('edit')}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '${AppLocalizations.of(context).trans('first_name')}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
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
                          controller: userController.updateFirstNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                '${AppLocalizations.of(context).trans('name')}',
                            hintStyle: cairoW400(color: Color(0xffB3B3B3)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '${AppLocalizations.of(context).trans('last_name')}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
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
                          controller: userController.updateLastNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                '${AppLocalizations.of(context).trans('name')}',
                            hintStyle: cairoW400(color: Color(0xffB3B3B3)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '${AppLocalizations.of(context).trans('email')}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: .0),
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
                          controller: userController.updateEmailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                '${AppLocalizations.of(context).trans('email')}',
                            hintStyle: cairoW400(color: Color(0xffB3B3B3)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '${AppLocalizations.of(context).trans('mobile')}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 0.0),
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
                          controller: userController.updateMobileController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                '${AppLocalizations.of(context).trans('mobile')}',
                            hintStyle: cairoW400(color: Color(0xffB3B3B3)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '${AppLocalizations.of(context).trans('password')}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
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
                          controller: userController.updatePasswordController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                '${AppLocalizations.of(context).trans('password')}',
                            hintStyle: cairoW400(color: Color(0xffB3B3B3)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '${AppLocalizations.of(context).trans('city')}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
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
                            hint: Text(
                                '${userController.userProfileDetails.user.cityName}'),
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
                              userController.setCityIdForUpdate(item.id);
                              // authController.setCityId(item.id);
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '${AppLocalizations.of(context).trans('address')}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
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
                          controller: userController.updateaddressController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                '${userController.userProfileDetails.user.address}',
                            hintStyle: cairoW400(color: Color(0xffB3B3B3)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          userController.userProfileDetails.user
                                      .nationalIdentifierFrontImage !=
                                  null
                              ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: imagePickerController
                                                  .backIDImageFile !=
                                              null
                                          ? Image.file(
                                              File(imagePickerController
                                                  .backIDImageFile.path),
                                              width: media.width / 2.5,
                                              height: 120.0,
                                              fit: BoxFit.cover,
                                            )
                                          : CustomFadNetWorkImage(
                                              width: media.width / 2.5,
                                              height: 120.0,
                                              boxFit: BoxFit.cover,
                                              imagePath:
                                                  "${userController.userProfileDetails.user.nationalIdentifierFrontImage}",
                                            ),
                                    ),
                                    imagePickerController.backIDImageFile !=
                                            null
                                        ? InkWell(
                                            onTap: () {
                                              imagePickerController
                                                  .resetbackIDImageFile();
                                            },
                                            child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: buttonColor1,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                )),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              imagePickerController
                                                  .showbackIDImageFilemageFilePicker(
                                                      context);
                                            },
                                            child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: buttonColor1,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                )),
                                          )
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            width: 10,
                          ),
                          userController.userProfileDetails.user
                                      .nationalIdentifierFrontImage !=
                                  null
                              ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: imagePickerController
                                                  .frontIDImageFile !=
                                              null
                                          ? Image.file(
                                              File(imagePickerController
                                                  .frontIDImageFile.path),
                                              width: media.width / 2.5,
                                              height: 120.0,
                                              fit: BoxFit.cover,
                                            )
                                          : CustomFadNetWorkImage(
                                              width: media.width / 2.5,
                                              height: 120.0,
                                              boxFit: BoxFit.cover,
                                              imagePath:
                                                  "${userController.userProfileDetails.user.nationalIdentifierFrontImage}",
                                            ),
                                    ),
                                    imagePickerController.frontIDImageFile !=
                                            null
                                        ? InkWell(
                                            onTap: () {
                                              imagePickerController
                                                  .resetFrontIDImageFile();
                                            },
                                            child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: buttonColor1,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                )),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              imagePickerController
                                                  .showfrontIDImageFilePicker(
                                                      context);
                                            },
                                            child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: buttonColor1,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                )),
                                          )
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    loader
                        ? Container(
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: buttonColor1)))
                        : DefaultAppButton(
                            text: 'edit_profile_now',
                            onPressed: () {
                              setState(() {
                                loader = true;
                              });
                              userController
                                  .updateProfile(context: context)
                                  .then((value) {
                                userController.getUserData(context: context);
                                setState(() {
                                  loader = false;
                                });
                              });
                            },
                          ),
                    loader
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 0.0),
                            child: InkWell(
                              onTap: () {
                                fadNavigate(context, ChangePasswordScreen());
                              },
                              child: Container(
                                width: media.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 2, color: buttonColor1)),
                                child: Center(
                                    child: Text(
                                  'Change password',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          )
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
