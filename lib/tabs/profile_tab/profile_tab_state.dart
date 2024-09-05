part of 'profile_tab_cubit.dart';

@immutable
sealed class ProfileTabState {}

final class ProfileTabInitial extends ProfileTabState {}
class ProfileTabLoading extends ProfileTabState{}
class ProfileTabSuccess extends ProfileTabState{
  final UserModel user;

  ProfileTabSuccess({required this.user});
}
class ProfileTabError extends ProfileTabState{

  final String error;

  ProfileTabError({required this.error});
}

