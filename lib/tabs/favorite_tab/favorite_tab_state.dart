part of 'favorite_tab_cubit.dart';

@immutable
sealed class FavoriteTabState {}

final class FavoriteTabInitial extends FavoriteTabState {}

class FavoriteTabLoading extends FavoriteTabState{}
class FavoriteTabSuccess extends FavoriteTabState{
  final List<PropertytypeModel> response;

  FavoriteTabSuccess(this.response);
}
class FavoriteTabError extends FavoriteTabState{

  String error;

  FavoriteTabError(this.error);
}
