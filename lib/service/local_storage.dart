import 'package:shared_preferences/shared_preferences.dart';




///
/// This LocalStorageStore class for save,get and delete user token using
/// SharedPreferences class.
///
class LocalStorageStore{
  void saveOtpUserToken({String? token}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('login', token!);
    print(_prefs.getString('login').toString()+">>>>>>>>>>>>>>>>>got<<<<<<<");
  }
  userDeleteToken()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('login');
    print(_prefs.getString('login').toString()+">>>>>>>>>>>>>>>>>got2<<<<<<<");
    //return _prefs.getString('token').toString();
  }
  Future<String>getUserToken()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    print(_prefs.getString('login').toString()+">>>>>>>>>>>>>>>>>got2<<<<<<<");
    return _prefs.getString('login').toString();
  }
  Future<String> getPhoneNumber() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //_prefs.setString('mobile', mobile!);
    print(_prefs.getString('mobile').toString() + ">>>>>>>>>>saveed<<<<<<<<<<");
    return _prefs.getString('mobile').toString();
  }
  userDeletePhoneNumber()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('mobile');
    print(_prefs.getString('mobile').toString()+">>>>>>>>>>>>>>>>>got2<<<<<<<");
    //return _prefs.getString('token').toString();
  }
}

class ThemePreference {
  static const THEME_STATUS = 'THEME_STATUS';

  void setTheme(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(THEME_STATUS) ?? false;
  }
}