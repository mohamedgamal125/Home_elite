part of 'add_buy_ads_cubit.dart';

@immutable
sealed class AddBuyAdsState {}

final class AddBuyAdsInitial extends AddBuyAdsState {}

class AddBuyAdsLoading extends AddBuyAdsState{}
class AddBuySuccess extends AddBuyAdsState{}
class AddBuyImageSelected extends AddBuyAdsState{}
class AddBuyImageClear extends AddBuyAdsState{}
class AddBuyError extends AddBuyAdsState{

  final String error;

  AddBuyError({required this.error});
}
