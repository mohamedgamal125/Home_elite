import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  final Dio _dio = Dio();

  Future<void> verifyPhone(String email, String code) async {
    print("Code ========== $code");
    emit(VerificationLoading());
    try {
      final response = await _dio.post(
          "https://backend-coding-yousseftarek80s-projects.vercel.app/auth/verify-email",
          data: {
            'email': email,
            'code': code,
          });
          print(response.statusCode);
          print(response.data);
          emit(VerificationSuccess());


    } catch (e) {

      emit(VerificationError(e.toString()));
    }
  }
}
