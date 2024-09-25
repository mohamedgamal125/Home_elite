abstract class GoogleSignUpState {}

class GoogleSignUpInitial extends GoogleSignUpState {}

class GoogleSignUpLoading extends GoogleSignUpState {}

class GoogleSignUpSuccess extends GoogleSignUpState {
  final String token;
  final String message;

  GoogleSignUpSuccess(this.token, this.message);
}

class GoogleSignUpError extends GoogleSignUpState {
  final String error;

  GoogleSignUpError(this.error);
}
