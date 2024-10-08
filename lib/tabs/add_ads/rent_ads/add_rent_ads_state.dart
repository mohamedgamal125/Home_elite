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

class AddRentPaymentOption extends AddRentAdsState{
  final String selectOption;

  AddRentPaymentOption(this.selectOption);
}

class AvailableOption extends AddRentAdsState{
  final String availableOption;

  AvailableOption( this.availableOption);
}
class AddRentAdSuccess extends AddRentAdsState{
  final String message;
  AddRentAdSuccess({required this.message});
}

class UpdateImageState extends AddRentAdsState{}

class AddRentAdFailure extends AddRentAdsState{
  final String error;
  AddRentAdFailure({required this.error});
}
class AddRentAdLoading extends AddRentAdsState{}



class UpdateRentAdSuccess extends AddRentAdsState{
  final String message;
  UpdateRentAdSuccess({required this.message});
}

class UpdateRentAdFailure extends AddRentAdsState{
  final String error;
  UpdateRentAdFailure({required this.error});
}
class UpdateRentAdLoading extends AddRentAdsState{}
