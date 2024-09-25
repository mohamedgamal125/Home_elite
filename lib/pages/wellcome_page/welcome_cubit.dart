import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:home_elite/pages/wellcome_page/welcome_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

class GoogleSignUpCubit extends Cubit<GoogleSignUpState> {
  final Dio _dio = Dio();

  GoogleSignUpCubit() : super(GoogleSignUpInitial()) {
    _listenForDeepLinks(); // Start listening for deep links
    _checkExistingToken();
  }

  static GoogleSignUpCubit get(context) => BlocProvider.of(context);

  // Google Sign-Up Method
  Future<void> signUpWithGoogle() async {
    emit(GoogleSignUpLoading());


      // Step 1: Open the authentication URL with flutter_web_auth
      await FlutterWebAuth.authenticate(
        url: "https://backend-coding-yousseftarek80s-projects.vercel.app/auth/google",
        callbackUrlScheme: "yourapp", // Make sure this matches your deep linking scheme
      );

  }

  // Listening for deep links
  void _listenForDeepLinks() {
    uriLinkStream.listen((Uri? uri)async {
      if (uri != null && uri.scheme == 'yourapp' && uri.host == 'callback') {
        final token = uri.queryParameters['token'];
        final email = uri.queryParameters['email'];
        print("==========email $email");
        if(token != null )
          {
            print("=============================Token $token");
            final SharedPreferences pre=await SharedPreferences.getInstance();
            pre.setString("token", token);
            pre.setString('email', email!);
          }

        if (token != null) {
          // Handle the token (e.g., save it, log in the user, etc.)
          emit(GoogleSignUpSuccess(token, "User data if needed"));
        } else {
          emit(GoogleSignUpError("No token found in deep link."));
        }
      }
    }, onError: (err) {
      emit(GoogleSignUpError("Error listening for deep links: ${err.toString()}"));
    });
  }

  Future<void> _checkExistingToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token != null) {
      emit(GoogleSignUpSuccess(token, "User already logged in"));
      // Navigate to home page or perform actions for logged in user
    }
  }
}
