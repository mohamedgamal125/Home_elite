import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      emit(LoginSuccess(loginResponse));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}