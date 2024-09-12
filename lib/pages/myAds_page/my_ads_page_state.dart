part of 'my_ads_page_cubit.dart';

@immutable
sealed class MyAdsPageState {}

final class MyAdsPageInitial extends MyAdsPageState {}

class MyAdsPageLoading extends MyAdsPageState{}
class MyAdsPageSuccess extends MyAdsPageState{
  final UserAdsResponse userAdsResponse;

  MyAdsPageSuccess({required this.userAdsResponse});
}
class MyAdsPageError extends MyAdsPageState{

  final String error;

  MyAdsPageError(this.error);
}
