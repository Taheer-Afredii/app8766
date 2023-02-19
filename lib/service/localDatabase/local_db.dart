import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static Future<void> setBusinessUserRecord({
    String? uid,
    String? email,
    String? password,
    String? name,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('buid', uid!);
    prefs.setString('bpassword', password ?? "");

    prefs.setString('bemail', email!);
    prefs.setString('bname', name ?? "");
  }

  static Future<void> removeBusinessUserRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('buid');
    prefs.remove('bpassword');
    prefs.remove('bemail');
    prefs.remove('bname');
  }
}
