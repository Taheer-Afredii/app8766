import 'package:shared_preferences/shared_preferences.dart';

class CustomerLocalDB {
  static Future<void> setCustomerUserRecord({
    String? uid,
    required String email,
    String? password,
    String? name,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cuid', uid ?? "");
    prefs.setString('cpassword', password ?? "");

    prefs.setString('cemail', email);
    prefs.setString('cname', name ?? "");
  }

  static Future<void> removeCustomerUserRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cuid');
    prefs.remove('cpassword');
    prefs.remove('cemail');
    prefs.remove('cname');
  }
}
