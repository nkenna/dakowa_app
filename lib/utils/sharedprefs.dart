import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dakowa_app/models/user.dart';
//import 'package:yarfafa_admin/models/admin.dart';

class SharedPrefs {
  SharedPrefs._privateConstructor();
  static final SharedPrefs instance = SharedPrefs._privateConstructor();

  Future<String> retrieveUserData () async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString("user") ?? "";
  }

  setUserData(User userObject) async{
    
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    if (userObject != null) {
      myPrefs.setString("user", jsonEncode(userObject));

   }
  }

  clearData() async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.clear();
  }

  deleteData(String key) async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.remove(key);
  }

  saveInt(String key, int value) async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setInt(key, value);
  }

  Future<int?> retrieveInt(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getInt(key);
  }

  Future<String> retrieveString (String key) async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? "";
  }

  saveDouble(String key, double value ) async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setDouble(key, value);
  }

  Future<double> retrieveDouble (String key) async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getDouble(key) ?? 0.0;
  }

  saveString(String key, String value) async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }

  Future<bool> saveToken(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.setString(key, value);
  }


  Future<List<String>?> retrieveSearch() async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getStringList("search");
  }

  saveSearch(List<String> value) async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    //List<String> searches = retrieveSearch();
    print(value);
    if(value != null){
      myPrefs.setStringList("search", value);
    }
  }
}
