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
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        UserAdsResponse userAds = UserAdsResponse.fromJson(response.data);

        // Check if the list of ads is empty
        if (userAds.userAds.isEmpty) {
          emit(MyAdsPageEmpty());
        } else {
          emit(MyAdsPageSuccess(userAdsResponse: userAds));
        }
      } else {
        emit(MyAdsPageError('Failed to fetch user ads: ${response.statusMessage}'));
      }
    } catch (e) {
      emit(MyAdsPageError(e.toString()));
    }
  }


  // todo add logic of delete and edit functions]

  Future<void> deleteAds(UserAd ad) async {

    try{
      emit(DeleteMyAdsPageLoading());

      final SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString("token");

      if(ad.adType=="buy"){
        final response = await Dio().post(
          "https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/buy/deleteSpecificAds/${ad.id}",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          emit(DeleteMyAdsPageSuccess(response.data['message']));
          fetchUserAds();
        }
      }
      else
        {
          final response = await Dio().post(
            "https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/rent/deleteSpecificAds/${ad.id}",
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          );

          if (response.statusCode == 200) {
            emit(DeleteMyAdsPageSuccess(response.data['message']));
            fetchUserAds();
          }
        }

    }catch(e){

      emit(DeleteMyAdsPageError(e.toString()));
    }
  }
}
