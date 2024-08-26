part of 'verification_cubit.dart';

@immutable
sealed class VerificationState {}

 class VerificationInitial extends VerificationState {}

class VerificationSuccess extends VerificationState{}
class VerificationError extends VerificationState{
  final String error;
  VerificationError(this.error);
}
class VerificationLoading extends VerificationState{}
