import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void setTitle(String title) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("title", title);
  }

  Future<String> getTitle() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('title')!;
  }
}
