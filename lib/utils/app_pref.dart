import 'package:shared_preferences/shared_preferences.dart';

class AppPref{

setUserToken(String token)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString("user_token", token);
  }

  Future<String> getUserToken()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    final token = sp.getString("user_token");

    return token ?? "";
  }

  removeToken() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove("user_token");
  }

}