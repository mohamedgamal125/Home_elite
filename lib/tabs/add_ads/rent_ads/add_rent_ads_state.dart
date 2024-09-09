part of 'add_rent_ads_cubit.dart';

@immutable
sealed class AddRentAdsState {}

final class AddRentAdsInitial extends AddRentAdsState {}

class AddRentSuccess extends AddRentAdsState{}
class AddRentImageSelected extends AddRentAdsState{}
class AddRentImageClear extends AddRentAdsState{}
class AddRentError extends AddRentAdsState{

  final String error;
  AddRentError({required this.error});
}