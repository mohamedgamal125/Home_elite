import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  var email = TextEditingController();

  static ResetPasswordCubit get(context) => BlocProvider.of(context);

  Future<void> resetPassword() async {

    try{
      emit(ResetPasswordLoading());
      final response =await Dio().post(
          "https://backend-coding-yousseftarek80s-projects.vercel.app/auth/resetRequest",
          data: {
            "email": email.text,
          });

      if(response.statusCode==200)
        {
          emit(ResetPasswordSuccess(message: response.data['message']));
        }
    }catch(e)
    {
      emit(ResetPasswordError(error: e.toString()));
    }

  }
}
