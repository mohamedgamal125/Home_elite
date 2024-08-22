

import 'package:equatable/equatable.dart';

abstract class GoogleSignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GoogleSignUpInitial extends GoogleSignUpState {}

class GoogleSignUpLoading extends GoogleSignUpState {}

class GoogleSignUpSuccess extends GoogleSignUpState {
  final String token;
  final String userId;

  GoogleSignUpSuccess({required this.token, required this.userId});

  @override
  List<Object?> get props => [token, userId];
}

class GoogleSignUpFailure extends GoogleSignUpState {
  final String errorMessage;

  GoogleSignUpFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
