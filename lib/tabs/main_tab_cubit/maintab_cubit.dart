import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:home_elite/models/propertyType_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'maintab_state.dart';

class MaintabCubit extends Cubit<MaintabState> {
  MaintabCubit() : super(MaintabInitial());

  Future<void> getPropertyTypes() async {
    emit(MaintabLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final Token = prefs.get("token");
      print("======================Token${Token}=");
      final response = await Dio().get(
          "https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/properties",
          options: Options(headers: {'Authorization': 'Bearer $Token'}));

      print(response.data);
      //
      final List<PropertytypeModel> properties = (response.data as List)
          .map((propertyJson) => PropertytypeModel.fromJson(propertyJson))
          .toList();

      print('=======================================');
      print(properties[0]);
      emit(MaintabSuccess(properties));
    } catch (e) {
      print(e.toString());
    }
  }
}
