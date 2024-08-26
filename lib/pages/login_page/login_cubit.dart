import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login_response.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Dio dio;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  LoginCubit(this.dio) : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> loginUser(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await dio.post(
        'https://backend-coding-yousseftarek80s-projects.vercel.app/auth/login',
        data: {
          "email": email,
          "password": password,
        },
      );
      final loginResponse = LoginResponse.fromJson(response.data);
      //===========================Store Token and user id in Shared Preference==========

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', loginResponse.token);
      await prefs.setString('userIdLogin', loginResponse.userIdLogin);
      await prefs.setString('message', loginResponse.message);

      print("===========================================");
      print("===================Shared Data from login========================");
      print(prefs.get("token"));
      print(prefs.get("userIdLogin"));
      print(prefs.get("message"));

      emit(LoginSuccess(loginResponse));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}