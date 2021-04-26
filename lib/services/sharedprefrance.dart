import 'package:shared_preferences/shared_preferences.dart';
class HelperFunctions{
  static String userlogedin='ISLOGGEDIN';
  static String useremailkey='USEREMAILKEY';
  static String usernamekey='USERNAMEKEY';
  //savedata
  static Future<bool> saveuserlogin(bool isloggedin) async
  {
    SharedPreferences pref=await SharedPreferences.getInstance();
    return await pref.setBool(userlogedin, isloggedin);
  }

  static Future<bool> saveusername(String username) async
  {
    SharedPreferences pref=await SharedPreferences.getInstance();
    return await pref.setString(usernamekey, username);
  }
  static Future<bool> saveuseremail(String useremail) async
  {
    SharedPreferences pref=await SharedPreferences.getInstance();
    return await pref.setString(useremailkey, useremail);
  }

  //getdata

  static Future<bool> getuserlogin() async
  {
    SharedPreferences pref=await SharedPreferences.getInstance();
    return await pref.getBool(userlogedin);
  }

  static Future<String> getusername() async
  {
    SharedPreferences pref=await SharedPreferences.getInstance();
    return await pref.getString(usernamekey);
  }

  static Future<String> getuseremail() async
  {
    SharedPreferences pref=await SharedPreferences.getInstance();
    return await pref.getString(useremailkey);
  }



}