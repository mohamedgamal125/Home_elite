import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  static EditProfileCubit get(context) => BlocProvider.of(context);

  var name = TextEditingController();
  var phone = TextEditingController();

  Future<void> editProfile() async {
    try {

      final SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString("token");

      const String url =
          "https://backend-coding-yousseftarek80s-projects.vercel.app/auth/updateProfile";

      emit(EditeProfileLoading());
      final response = await Dio().post(url,
          data: {
            "name": name.text,
            "phone": phone.text,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if(response.statusCode==200)
        {
          emit(EditeProfileSuccess());
        }
    } catch (e) {
      print(e.toString());
      emit(EditeProfileError(e.toString()));
    }
  }

  void clearData()
  {
    name.clear();
    phone.clear();
  }
}
