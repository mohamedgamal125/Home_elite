part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}
class ResetPasswordSuccess extends ResetPasswordState{
  final String message;

  ResetPasswordSuccess({required this.message});
}
class ResetPasswordLoading extends ResetPasswordState{}
class ResetPasswordError extends ResetPasswordState{

  final String error;

  ResetPasswordError({required this.error});
}