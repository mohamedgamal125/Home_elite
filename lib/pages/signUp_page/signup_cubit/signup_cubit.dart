import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_elite/pages/signUp_page/signup_cubit/signup_state.dart';

import '../../../models/signup_model.dart';

class SignupCubit extends Cubit<RegisterState> {
  SignupCubit() : super(RegisterInitial());
  final Dio _dio = Dio();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var AddressController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  var Address;
  static SignupCubit get(context) => BlocProvider.of(context);

  final List<String> egyptianCities = [
    'cairo'.tr(),
    'alexandria'.tr(),
    'giza'.tr(),
    'sharm_el_sheikh'.tr(),
    'luxor'.tr(),
    'aswan'.tr(),
    'port_said'.tr(),
    'suez'.tr(),
    'ismailia'.tr(),
    'tanta'.tr(),
    'mansoura'.tr(),
    'zagazig'.tr(),
    'minya'.tr(),
    'assiut'.tr(),
  ];
  Future<void> register() async {
    emit(RegisterLoading());

    try {
      printData();
      final response = await _dio.post(
        'https://backend-coding-yousseftarek80s-projects.vercel.app/auth/register',
        data: {
          'email': emailController.text,
          'password': passwordController.text,
          'confpassword': passwordController.text,
          'phone': phoneController.text,
          'address': Address,
          'username': userNameController.text,
        },
      );

      if (response.statusCode == 200) {
        final SignupResponseModel signupResponse = SignupResponseModel.fromJson(response.data);


        emit(RegisterSuccess(signupResponse));
      } else {
        emit(RegisterFailure('Registration failed with status code ${response.statusCode}'));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
  //==============================================
  //==============================================
  void printData(){

    print("======================================");
    print(userNameController.text);
    print(emailController.text);
    print(passwordController.text);
    print(phoneController.text);
    print(Address);
    print("======================================");
  }
}