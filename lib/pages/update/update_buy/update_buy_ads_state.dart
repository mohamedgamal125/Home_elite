part of 'update_buy_ads_cubit.dart';

@immutable
sealed class UpdateBuyAdsState {}

final class UpdateBuyAdsInitial extends UpdateBuyAdsState {}


class UpdateBuyPaymentOptionChange extends UpdateBuyAdsState{

  final String selectedOption;

  UpdateBuyPaymentOptionChange(this.selectedOption);
}

class  AvailableOptionChanged extends UpdateBuyAdsState{

final String selectedOption;

AvailableOptionChanged(this.selectedOption);
}


class UpdateBuyAdSuccess extends UpdateBuyAdsState {
  final String message;

  UpdateBuyAdSuccess({required this.message});
}

class UpdateBuyAdFailure extends UpdateBuyAdsState {
  final String error;

  UpdateBuyAdFailure({required this.error});
}
class UpdateBuyLoading extends UpdateBuyAdsState{}