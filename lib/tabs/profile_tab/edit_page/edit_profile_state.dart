part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}
class EditeProfileLoading extends EditProfileState{}
class EditeProfileSuccess extends EditProfileState{}
class EditeProfileError extends EditProfileState{
  final String error;

  EditeProfileError(this.error);
}
