import 'package:shared_preferences/shared_preferences.dart';

class SharedPress {
  saveData(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  saveId(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  saveLatLag(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }


  getData(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  getId(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  getLatLag(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }
  /*clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }*/
}

SharedPress sharedPress = SharedPress();
