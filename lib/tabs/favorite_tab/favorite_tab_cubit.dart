import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/propertyType_model.dart';

part 'favorite_tab_state.dart';

class FavoriteTabCubit extends Cubit<FavoriteTabState> {
  FavoriteTabCubit() : super(FavoriteTabInitial());
  static FavoriteTabCubit get(context) => BlocProvider.of(context);

}
