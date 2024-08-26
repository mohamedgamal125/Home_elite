import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_elite/pages/wellcome_page/welcome_state.dart';


class GoogleSignUpCubit extends Cubit<GoogleSignUpState> {
  final Dio _dio;

  GoogleSignUpCubit(this._dio) : super(GoogleSignUpInitial());
  static GoogleSignUpCubit get(context) => BlocProvider.of(context);
  Future<void> signUpWithGoogle() async {
    emit(GoogleSignUpLoading());

    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        emit(GoogleSignUpFailure(errorMessage: 'Google Sign-In canceled'));
        return;
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      final response = await _dio.post(
        'https://backend-coding-yousseftarek80s-projects.vercel.app/auth/google',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        emit(GoogleSignUpSuccess(
          token: data['token'],
          userId: data['UserIdLogin'],
        ));
      } else {
        emit(GoogleSignUpFailure(
            errorMessage: 'Google Sign-Up failed with status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(GoogleSignUpFailure(errorMessage: e.toString()));
    }
  }
}
