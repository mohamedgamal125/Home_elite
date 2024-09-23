abstract class GoogleSignUpState {}

class GoogleSignUpInitial extends GoogleSignUpState {}

class GoogleSignUpLoading extends GoogleSignUpState {}

class GoogleSignUpSuccess extends GoogleSignUpState {
  final String token;
  final Map<String, dynamic> user;

  GoogleSignUpSuccess(this.token, this.user);
}

class GoogleSignUpError extends GoogleSignUpState {
  final String error;

  GoogleSignUpError(this.error);
}
