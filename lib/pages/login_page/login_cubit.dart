import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login_response.dart';
import '../../models/user.dart';
import '../../models/user_model.dart';
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


      emit(LoginSuccess(loginResponse));
      await fetchUserData();
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> fetchUserData() async {


    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.get("token");
      final response = await dio.get(
        'https://backend-coding-yousseftarek80s-projects.vercel.app/auth/user',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final user = User2.fromJson(response.data);

      print(response.data);
      print("===========email=========");
      print(user.email);
      print(token);



      await prefs.setString('email', user.email!);
      await prefs.setString('name', user.username!);
      await prefs.setString('phone', user.phone!);
      final favoriteListJson = user.favorite?.map((fav) => fav.toJson()).toList() ?? [];
      final favoriteListString = jsonEncode(favoriteListJson);

      // Store the JSON string in SharedPreferences
      await prefs.setString('favorites', favoriteListString);

    } catch (error) {
      print(error.toString());
    }
  }
}