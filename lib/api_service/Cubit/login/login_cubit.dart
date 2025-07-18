import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shoping_app/api_service/api_client.dart';
import 'package:shoping_app/screen/home_screen.dart';
import 'package:shoping_app/utils/app_pref.dart';
import 'package:shoping_app/utils/check_Network.dart';
import 'package:shoping_app/utils/common_toast.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  UserLogin(String email, String password,BuildContext context) async {
    if (await isNetworkAvaliable()) {
      emit(LoginLoading());
      try {
        final result = await ApiClient().userLogIn(email, password);
        print("login Successful $result");
        await AppPref().setUserToken(result["token"]);

        emit(LoginLoaded());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      } catch (e) {
        emit(LoginError());
        CommonToast("Somthing Went Error");
      }
    } else {
      //toast
      CommonToast("Network Error");

    }
  }
}

//   ApiClient().userLogIn(email, password).then((value){
//   print(value);
//
//   emit(LoginLoaded());
//   }).onError(error, stackTrace){
//
//   emit(LoginError());
//   }
// }
