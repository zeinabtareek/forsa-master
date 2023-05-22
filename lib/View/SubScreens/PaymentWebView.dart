// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fursa/Controller/localizationController.dart';
import 'package:fursa/Controller/pageIndexController.dart';
import 'package:fursa/Core/Services/localizationServices/app_localizations.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/View/MainScreens/NavigationHome/NavigationHomeScreen.dart';
import 'package:fursa/View/SharedComponents/NavigationControl.dart';

import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

class ReservationWebPawment extends StatefulWidget {
  var url;
  ReservationWebPawment({this.url});
  @override
  _ReservationWebPawmentState createState() => _ReservationWebPawmentState();
}

class _ReservationWebPawmentState extends State<ReservationWebPawment> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool loader = false;
  var _locale;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    _locale = Provider.of<LocalizationController>(context, listen: false)
        .locale
        .languageCode;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  String successfulUrl = '';

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: color1,
        automaticallyImplyLeading: false,
        title: Text(
          '${AppLocalizations.of(context).trans('payment')}',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          // NavigationControls(_controller.future),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).backgroundColor,
              size: 20,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NavigationHomeScreen()));

              // _controller.future.reload();
            },
          ),
          // SampleMenu(_controller.future),
        ],
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Stack(
        children: [
          Builder(builder: (BuildContext context) {
            return WebView(
              initialUrl: '${widget.url}',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                print("WebView is loading (progress : $progress%)");
              },
              javascriptChannels: <JavascriptChannel>{
                _toasterJavascriptChannel(context),
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
                setState(() {
                  successfulUrl = url;
                });
                print('ttttttttttttttttttttttttttt$successfulUrl');
              },
              gestureNavigationEnabled: true,
            );
          }),
          successfulUrl.contains('api/payment_operation?operation=success')
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 45,
                        width: media.width,
                        child: Center(
                            child: Text(
                          '${AppLocalizations.of(context).trans('donepayment')}',
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontFamily: 'NotoKufiArabic-Light'),
                        )),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Provider.of<PageIndexController>(context, listen: false)
                            .changeIndexFunction(0);
                        fadNavigate(context, NavigationHomeScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 30),
                        child: Container(
                          height: 45,
                          width: media.width,
                          decoration: BoxDecoration(
                            color: buttonColor1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: AppLocalizations.of(context)
                                          .locale
                                          .languageCode ==
                                      'ar'
                                  ? Text(
                                      'الرئيسية',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'NotoKufiArabic-Light'),
                                    )
                                  : Text(
                                      'HOME',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'NotoKufiArabic-Light'),
                                    )),
                        ),
                      ),
                    ),
                  ],
                )
              : successfulUrl.contains('api/payment_operation?operation=fail')
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 45,
                            width: media.width,
                            child: Center(
                                child: AppLocalizations.of(context)
                                            .locale
                                            .languageCode ==
                                        'ar'
                                    ? Text(
                                        'برجاء التأكد من بيانات البطاقة وأعادة المحاولة',
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 14,
                                            fontFamily: 'NotoKufiArabic-Light'),
                                      )
                                    : Text(
                                        'Please check your card details and try again',
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 14,
                                            fontFamily: 'NotoKufiArabic-Light'),
                                      )),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Provider.of<PageIndexController>(context,
                                    listen: false)
                                .changeIndexFunction(0);
                            fadNavigate(context, NavigationHomeScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 30),
                            child: Container(
                              height: 45,
                              width: media.width,
                              decoration: BoxDecoration(
                                color: buttonColor1,
                                borderRadius: BorderRadius.circular(10),
                                // gradient: LinearGradient(
                                //   colors: [
                                //     Color(0xFF61976d),
                                //     Color(0xFFa97460),
                                //     Color(0xFFd85e57),
                                //   ],
                                //   begin: Alignment.centerRight,
                                //   end: Alignment.centerLeft,
                                // ),
                              ),
                              child: Center(
                                  child: AppLocalizations.of(context)
                                              .locale
                                              .languageCode ==
                                          'ar'
                                      ? Text(
                                          'الرئيسية',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily:
                                                  'NotoKufiArabic-Light'),
                                        )
                                      : Text(
                                          'HOME',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily:
                                                  'NotoKufiArabic-Light'),
                                        )),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
        ],
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                final String url = (await controller.data.currentUrl());
                // ignore: deprecated_member_use
                ScaffoldMessenger.of(context)
                  ..showSnackBar(
                    SnackBar(content: Text('Favorited $url')),
                  );
              },
              child: const Icon(Icons.favorite),
            );
          }
          return Container();
        });
  }
}

enum MenuOptions {
  showUserAgent,
  listCookies,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
}

class SampleMenu extends StatelessWidget {
  SampleMenu(this.controller);

  final Future<WebViewController> controller;
  final CookieManager cookieManager = CookieManager();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        return PopupMenuButton<MenuOptions>(
          onSelected: (MenuOptions value) {
            switch (value) {
              case MenuOptions.showUserAgent:
                _onShowUserAgent(controller.data, context);
                break;
              case MenuOptions.listCookies:
                _onListCookies(controller.data, context);
                break;
              case MenuOptions.clearCookies:
                _onClearCookies(context);
                break;
              case MenuOptions.addToCache:
                _onAddToCache(controller.data, context);
                break;
              case MenuOptions.listCache:
                _onListCache(controller.data, context);
                break;
              case MenuOptions.clearCache:
                _onClearCache(controller.data, context);
                break;
              case MenuOptions.navigationDelegate:
                _onNavigationDelegateExample(controller.data, context);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
            PopupMenuItem<MenuOptions>(
              value: MenuOptions.showUserAgent,
              child: const Text('Show user agent'),
              enabled: controller.hasData,
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.listCookies,
              child: Text('List cookies'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCookies,
              child: Text('Clear cookies'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.addToCache,
              child: Text('Add to cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.listCache,
              child: Text('List cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCache,
              child: Text('Clear cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.navigationDelegate,
              child: Text('Navigation Delegate example'),
            ),
          ],
        );
      },
    );
  }

  void _onShowUserAgent(
      WebViewController controller, BuildContext context) async {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    await controller.evaluateJavascript(
        'Toaster.postMessage("User Agent: " + navigator.userAgent);');
  }

  void _onListCookies(
      WebViewController controller, BuildContext context) async {
    final String cookies =
        await controller.evaluateJavascript('document.cookie');
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Cookies:'),
          _getCookieList(cookies),
        ],
      ),
    ));
  }

  void _onAddToCache(WebViewController controller, BuildContext context) async {
    await controller.evaluateJavascript(
        'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";');
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Added a test entry to cache.'),
    ));
  }

  void _onListCache(WebViewController controller, BuildContext context) async {
    await controller.evaluateJavascript('caches.keys()'
        '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
        '.then((caches) => Toaster.postMessage(caches))');
  }

  void _onClearCache(WebViewController controller, BuildContext context) async {
    await controller.clearCache();
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Cache cleared."),
    ));
  }

  void _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(context)
      ..showSnackBar(SnackBar(
        content: Text(message),
      ));
  }

  void _onNavigationDelegateExample(
      WebViewController controller, BuildContext context) async {
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(kNavigationExamplePage));
    await controller.loadUrl('data:text/html;base64,$contentBase64');
  }

  Widget _getCookieList(String cookies) {
    if (cookies == null || cookies == '""') {
      return Container();
    }
    final List<String> cookieList = cookies.split(';');
    final Iterable<Text> cookieWidgets =
        cookieList.map((String cookie) => Text(cookie));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: cookieWidgets.toList(),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        await controller.goBack();
                      } else {
                        // ignore: deprecated_member_use
                        Navigator.pop(context);
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoForward()) {
                        await controller.goForward();
                      } else {
                        // ignore: deprecated_member_use
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("No forward history item")),
                        );
                        return;
                      }
                    },
            ),
          ],
        );
      },
    );
  }
}
