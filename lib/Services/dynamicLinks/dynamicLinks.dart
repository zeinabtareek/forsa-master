// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
//
// class AppUtils {
//   ///Build a dynamic link firebase
//   static Future<String> buildDynamicLink(id) async {
//     String url = "https://ebtasm.page.link/post";
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: url,
//       link: Uri.parse('$url/pruduct/$id'),
//       androidParameters: AndroidParameters(
//         packageName: "com.ebtasm.aqar.aqar",
//         minimumVersion: 0,
//       ),
//
//       // socialMetaTagParameters: SocialMetaTagParameters(
//       //     description: "Once upon a time in the town",
//       //     imageUrl:
//       //         Uri.parse("https://flutter.dev/images/flutter-logo-sharing.png"),
//       //     title: "Breaking Code's Post"),
//     );
//     final dynamicUrl = await parameters.buildShortLink();
//     return dynamicUrl.shortUrl.toString();
//   }
// }
