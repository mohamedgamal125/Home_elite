import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:home_elite/pages/wellcome_page/welcome_state.dart';

class GoogleSignUpCubit extends Cubit<GoogleSignUpState> {
  final Dio _dio = Dio();

  GoogleSignUpCubit() : super(GoogleSignUpInitial());
  static GoogleSignUpCubit get(context) => BlocProvider.of(context);

  // Google Sign-Up Method
  Future<void> signUpWithGoogle() async {
    emit(GoogleSignUpLoading());

    try {
      // Step 1: Open the authentication URL with flutter_web_auth
      final result = await FlutterWebAuth.authenticate(
        url: "https://backend-coding-yousseftarek80s-projects.vercel.app/auth/google",
        callbackUrlScheme: "yourapp", // Make sure this matches your deep linking scheme
      );

      // Step 2: Extract the token from the callback URL
      final token = Uri.parse(result).queryParameters['token'];

      if (token != null) {
        // Step 3: Send the token to your backend (optional if backend already handles it)
        final response = await _dio.post(
          "https://backend-coding-yousseftarek80s-projects.vercel.app/auth/google/callback",
          data: {
            "token": token,
          },
        );

        if (response.statusCode == 200) {
          emit(GoogleSignUpSuccess(token, response.data['user']));
        } else {
          emit(GoogleSignUpError("Failed to sign up with Google."));
        }
      } else {
        emit(GoogleSignUpError("No token found in the response."));
      }
    } catch (error) {
      emit(GoogleSignUpError(error.toString()));
    }
  }
}
