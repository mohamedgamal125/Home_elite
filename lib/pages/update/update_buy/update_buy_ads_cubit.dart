import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_buy_ads_state.dart';

class UpdateBuyAdsCubit extends Cubit<UpdateBuyAdsState> {
  UpdateBuyAdsCubit() : super(UpdateBuyAdsInitial());
}
