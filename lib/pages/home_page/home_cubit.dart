import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_elite/tabs/add_ads/ads_tab.dart';
import 'package:home_elite/tabs/favorite_tab.dart';
import 'package:home_elite/tabs/main_tab_cubit/main_tab.dart';
import 'package:home_elite/tabs/profile_tab/profile_tab.dart';
import 'package:home_elite/tabs/search_tab.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  int current_indx=0;

  List<BottomNavigationBarItem> bottomItems= [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_filled,size: 35,),
        label: ""

    ),

    BottomNavigationBarItem(
        icon: Icon(Icons.search_outlined,size: 35,),
        label: ""
    ),

    BottomNavigationBarItem(
        icon:Icon(Icons.add_circle,size: 35,),
        label: ""
    ),
    BottomNavigationBarItem(
        icon:Icon(Icons.bookmark_outline,size: 35,),
        label: ""
    ),
    BottomNavigationBarItem(
        icon:Icon(Icons.settings,size: 35,),
        label: ""
    ),
  ];

  List<Widget>tabs = [
    MainTab(),
    SearchTab(),
    AdsTab(),
    FavoriteTab(),
    ProfileTab()
  ];

  void changeNavBarState(int index)
  {
    current_indx=index;
    emit(HomeBottomNavBar());
  }
}
