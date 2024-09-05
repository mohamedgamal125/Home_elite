import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_elite/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_tab_state.dart';

class ProfileTabCubit extends Cubit<ProfileTabState> {
  ProfileTabCubit() : super(ProfileTabInitial());

  final Dio dio=Dio();
  static ProfileTabCubit get(context) => BlocProvider.of(context);

  Future<void> fetchUserData() async {

    emit(ProfileTabLoading());
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
      final user = UserModel.fromJson(response.data);
      print("===========email=========");
      print(user.email);
      print(token);
      emit(ProfileTabSuccess(user: user));
    } catch (error) {
      emit(ProfileTabError(error:error.toString()));
    }
  }
}
