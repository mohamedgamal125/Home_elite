part of 'add_ads_cubit.dart';

@immutable
sealed class AddAdsState {}

final class AddAdsInitial extends AddAdsState {}

class AddAdsLoading extends AddAdsState{}

class AddAdsSuccess extends AddAdsState{}
class AddAdsImagesSelected extends AddAdsState{}
class AddAdsImagesCleared extends AddAdsState{}

class AddAdsError extends AddAdsState{
  final String error;

  AddAdsError(this.error);

}
