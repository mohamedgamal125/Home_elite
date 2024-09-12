import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:home_elite/models/userAd.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'my_ads_page_state.dart';

class MyAdsPageCubit extends Cubit<MyAdsPageState> {
  MyAdsPageCubit() : super(MyAdsPageInitial());

  Future<void> fetchUserAds() async {
    try {
      emit(MyAdsPageLoading());

      final SharedPreferences pref = await SharedPreferences.getInstance();
      final token = await pref.get("token");

      final response = await Dio().get(
          "https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/UserAds",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          }
        )
      );

      if(response.statusCode==200)
        {
          UserAdsResponse userAds = UserAdsResponse.fromJson(response.data);
          emit(MyAdsPageSuccess(userAdsResponse: userAds));
        }

    } catch (e) {
      emit(MyAdsPageError(e.toString()));
    }
  }
}
