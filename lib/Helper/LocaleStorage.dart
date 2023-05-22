import 'package:shared_preferences/shared_preferences.dart';

class LocaleStorage {
  static String userName = '';
  static String userId;
  static String userEmail = '';
  static String userPhone = '';
  static String userAvatar = '';
  static String token = '';
  static String userType = '';
  static String userPassWord = '';
  // static List serviceIds = [];
  // static bool is_verified = false;
  // static bool is_active = false;
  static String dialCode;
  static String geoLocation;
  static String status;
  static String bundleId;
  static String comeFrom = '';
  static String balance;
  static bool is_loggedIn = false;

  static String sharedPreferencesComeFromKey = 'ComeFrom';
  static String sharedPreferencesUserLoggedInKey = 'IsLoggedIn';
  static String sharedPreferencesUsernameInKey = 'Username';
  static String sharedPreferencesUserIdInKey = 'UserId';
  static String sharedPreferencesUserEmailInKey = 'UserEmail';
  static String sharedPreferencesUserPhoneInKey = 'UserPhone';
  static String sharedPreferencesUserPasswordInKey = 'UserPassword';
  static String sharedPreferencesUserAvatarInKey = 'UserAvatar';
  static String sharedPreferencesUserTokenInKey = 'UserToken';
  static String sharedPreferencesUserTypeInKey = 'UserType';
  static String sharedPreferencesIsVerifiedInKey = 'IsVerified';
  static String sharedPreferencesIsActiveInKey = 'IsActive';
  static String sharedPreferencesDialCodeInKey = 'DialCode';
  static String sharedPreferencesGeoLocationInKey = 'GeoLocation';
  static String sharedPreferencesNationalitiesInKey = 'Nationalities';
  static String sharedPreferencesPaymentMethodsInKey = 'PaymentMethods';
  static String sharedPreferencesStatusInKey = 'status';
  static String sharedPreferencesBundleIdInKey = 'BundleId';
  static String sharedPreferencesServiceIdInKey = 'ServiceId';
  static String sharedPreferencesBalanceInKey = 'Balance';
  static String sharedPreferencesDeviceTokenInKey = 'DeviceToken';

// User Balance
  static Future<bool> saveComeFromInSharedPreferences(String comeFrom) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferencesComeFromKey, comeFrom);
  }

  static Future<String> getUserComeFromInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(sharedPreferencesComeFromKey);
  }

  // User Device Token
  static Future<bool> saveDeviceTokenInSharedPreferences(
      String deviceToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(
        sharedPreferencesDeviceTokenInKey, deviceToken);
  }

  static Future<String> getDeviceTokenInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesDeviceTokenInKey);
  }

// User Balance
  static Future<bool> saveBalanceInSharedPreferences(String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferencesBalanceInKey, description);
  }

  static Future<String> getUserBalanceInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesBalanceInKey);
  }

//serviceIds
  static Future<bool> saveServiceIdInSharedPreferences(
      List<String> listServicesIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setStringList(
        sharedPreferencesServiceIdInKey, listServicesIds);
  }

  static Future<List> getServiceIdInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesServiceIdInKey);
  }

//userLogin
  static Future<bool> saveUserLoggedInSharedPreferences(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setBool(sharedPreferencesUserLoggedInKey, isLoggedIn);
  }

  static Future<bool> getUserLoggedInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesUserLoggedInKey);
  }

  // is_verified key
  static Future<bool> saveUserIsVerifiedInSharedPreferences(
      bool isVerified) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setBool(sharedPreferencesIsVerifiedInKey, isVerified);
  }

  static Future<bool> getUserIsVerifiedInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesIsVerifiedInKey);
  }

  // is_active key
  static Future<bool> saveUserIsActiveInSharedPreferences(bool isActive) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setBool(sharedPreferencesIsActiveInKey, isActive);
  }

  static Future<bool> getUserIsActiveInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesIsActiveInKey);
  }

  // user_id
  static Future<bool> saveUserIdInSharedPreferences(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferencesUserIdInKey, userId);
  }

  static Future<String> getUserIdInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesUserIdInKey);
  }

  // status
  static Future<bool> saveStatusInSharedPreferences(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferencesStatusInKey, status);
  }

  static Future<String> getStatusInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesStatusInKey);
  }

  // bundleId
  static Future<bool> saveBundleIdInSharedPreferences(String bundleId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferencesBundleIdInKey, bundleId);
  }

  static Future<String> getBundleIdInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesBundleIdInKey);
  }

  // DialCode key
  static Future<bool> saveDialCodeInSharedPreferences(String dialCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferencesDialCodeInKey, dialCode);
  }

  static Future<String> getDialCodeInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesDialCodeInKey);
  }

  // GeoLocation key
  static Future<bool> saveGeoLocationInSharedPreferences(
      String geoLocation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(
        sharedPreferencesGeoLocationInKey, geoLocation);
  }

  static Future<String> getGeoLocationInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesGeoLocationInKey);
  }

  // user_token
  static Future<bool> saveUserTokenInSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferencesUserTokenInKey, token);
  }

  static Future<String> getUserTokenInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesUserTokenInKey);
  }

  // user_name
  static Future<bool> saveUsernameInSharedPreferences(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferencesUsernameInKey, username);
  }

  static Future<String> getUsernameInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesUsernameInKey);
  }

  // user_email
  static Future<bool> saveUserEmailInSharedPreferences(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferencesUserEmailInKey, username);
  }

  static Future<String> getUserEmailInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesUserEmailInKey);
  }

// user_password
  static Future<bool> saveUserPasswordInSharedPreferences(
      String userPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(
        sharedPreferencesUserPasswordInKey, userPassword);
  }

  static Future<String> getUserPasswordInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesUserPasswordInKey);
  }

  // user_phone
  static Future<bool> saveUserPhoneInSharedPreferences(String userPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferencesUserPhoneInKey, userPhone);
  }

  static Future<String> getUserPhoneInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesUserPhoneInKey);
  }

  // user_avatar
  static Future<bool> saveUserAvatarInSharedPreferences(
      String userAvatar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferencesUserAvatarInKey, userAvatar);
  }

  static Future<String> getUserAvatarInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesUserAvatarInKey);
  }

  // UserType key
  static Future<bool> saveUserTypeInSharedPreferences(String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString(sharedPreferencesUserTypeInKey, userType);
  }

  static Future<String> getUserTypeInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesUserTypeInKey);
  }

  // Nationalities
  static Future<bool> saveNationalitiesInSharedPreferences(
      List<String> nationalities) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setStringList(
        sharedPreferencesNationalitiesInKey, nationalities);
  }

  static Future<List<dynamic>> getNationalitiesInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesNationalitiesInKey);
  }

  // PaymentMethods
  static Future<bool> savePaymentMethodsInSharedPreferences(
      List<String> paymentMethods) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setStringList(
        sharedPreferencesPaymentMethodsInKey, paymentMethods);
  }

  static Future<List<dynamic>> getPaymentMethodsInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.get(sharedPreferencesPaymentMethodsInKey);
  }

  static void saveUserStatusInSharedPreferences(responseJson) {}
}
