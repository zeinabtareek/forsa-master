import 'package:flutter/material.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Helper/fonts_helper.dart';
import 'package:fursa/View/IntroScreens/LoginScreen/LoginScreen.dart';
import 'package:fursa/View/SharedComponents/ButtonsStyles.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: CustomScrollView(
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Text(
                    '${AppLocalizations.of(context).trans('verification')}',
                    style: cairoW700(color: Color(0xFFFFD954), size: 30),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: media.width,
                height: media.height * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      child: Container(
                        width: 280,
                        child: Text(
                          '${AppLocalizations.of(context).trans('enterOTPCode')}',
                          textAlign: TextAlign.start,
                          style: cairoW500(color: Color(0xFF00489A)).copyWith(height: 1.4),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 80),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                            backgroundColor: Colors.transparent,
                            appContext: context,

                            // pastedTextStyle: TextStyle(
                            //   color: Colors.green.shade600,
                            //   fontWeight: FontWeight.bold,
                            // ),
                            length: 4,
                            // obscureText: true,
                            // obscuringCharacter: '*',
                            // obscuringWidget: FlutterLogo(
                            //   size: 24,
                            // ),
                            // blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            // validator: (v) {
                            //   if (v.length < 4) {
                            //     return "I'm from validator";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              activeColor: Colors.white,
                              disabledColor: Colors.white,
                              inactiveColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedColor: Colors.white,
                              selectedFillColor: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              fieldHeight: 46,
                              fieldWidth: 46,
                              activeFillColor: Colors.grey[300],
                            ),
                            cursorColor: Colors.black,
                            animationDuration: Duration(milliseconds: 300),
                            enableActiveFill: true,
                            // errorAnimationController: errorController,
                            // controller: textEditingController,
                            autoFocus: true,
                            keyboardType: TextInputType.number,
                            // boxShadows: [
                            //   BoxShadow(
                            //     offset: Offset(0, 1),
                            //     color: Colors.black12,
                            //     blurRadius: 10,
                            //   )
                            // ],
                            onCompleted: (v) {
                              setState(() {
                                fadNavigate(context, LoginScreen());
                              });
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                // currentText = value;
                                // code=value;
                              });
                            },
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          ),
                        )),
                    Spacer(),
                    DefaultAppButton(
                      onPressed: () {
                        fadNavigate(context, LoginScreen());
                      },
                      text: 'confirm',
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
