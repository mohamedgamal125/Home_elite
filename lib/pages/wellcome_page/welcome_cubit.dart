import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_elite/pages/wellcome_page/welcome_state.dart';


class GoogleSignUpCubit extends Cubit<GoogleSignUpState> {
  final Dio _dio=Dio();

  GoogleSignUpCubit() : super(GoogleSignUpInitial());
  static GoogleSignUpCubit get(context) => BlocProvider.of(context);


  void signInWithGoogle() async {
    try {
      final url = Uri.parse('https://backend-coding-yousseftarek80s-projects.vercel.app/auth/google');
      final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: "http",
      );

      final token = Uri.parse(result).queryParameters['token'];
      print("=======================Response=============");
      print(token);
    } catch (e) {
      print('Error during sign in: $e');
    }
  }
}

