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

class AddBuyPaymentOptionChanged extends AddBuyAdsState{
  final String selectedOption;
  AddBuyPaymentOptionChanged(this.selectedOption);
}

class AddBuyAdSuccess extends AddBuyAdsState {
  final String message;

  AddBuyAdSuccess({required this.message});
}

class AddBuyAdFailure extends AddBuyAdsState {
  final String error;

  AddBuyAdFailure({required this.error});
}
class AddBuyLoading extends AddBuyAdsState{}