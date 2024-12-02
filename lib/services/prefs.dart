import 'package:sansgen/keys/pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  SharedPreferences? _prefs;

  Future<void> prefInit() async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
  }

  bool get isFirstInstall {
    final prefBool = _prefs?.getString(KeysPref.firstInstall);
    return prefBool != null ? false : true;
  }

  /// Set first install
  void setNotFirstInstall() {
    _prefs?.setString(KeysPref.firstInstall, 'false');
  }

  /// for getting string from box
  bool? get getOnBoarding {
    return _prefs?.getBool(KeysPref.onBoarding);
  }

  /// for storingtCustomer to app
  Future<void> putOnBoarding (bool on) async {
    await _prefs?.setBool(KeysPref.onBoarding, on);
  }


  /// for getting string from box
  String? get getUserToken {
    return _prefs?.getString(KeysPref.userToken);
  }

  /// for storingtCustomer to app
  Future<void> putUserToken(String token) async {
    await _prefs?.setString(KeysPref.userToken, token);
  }

  Future<void> removeUserToken() async {
    await _prefs?.remove(KeysPref.userToken);
  }


  /// for getting string from box
  String? get getUserUuid {
    return _prefs?.getString(KeysPref.userUuid);
  }

  /// for storingtCustomer to app
  Future<void> putUserUuid(String token) async {
    await _prefs?.setString(KeysPref.userUuid, token);
  }

  Future<void> removeUserUuid() async {
    await _prefs?.remove(KeysPref.userUuid);
  }


  /// for clearing all data in box
  Future<void> clearAllData() async {
    await _prefs?.clear();
  }
}
