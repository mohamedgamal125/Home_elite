import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_elite/tabs/add_ads/buy_ads/add_buy_ads.dart';

import 'package:home_elite/tabs/main_tab_cubit/main_tab.dart';
import 'package:home_elite/tabs/profile_tab/profile_tab.dart';
import 'package:home_elite/tabs/search_tab.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';

import '../../tabs/add_ads/ads_tab.dart';
import '../../tabs/favorite_tab/favorite_tab.dart';
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

  void changeNavBarState(int index, BuildContext context) {
    if (index == 2) {
      // Show the bottom sheet when the add button is pressed
      _showAddOptions(context);
    } else {
      current_indx = index;
      emit(HomeBottomNavBar());
    }
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('buy'.tr(), style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AddBuyAds(),
                  ));
                },
              ),
              ListTile(
                title: Text('rent'.tr(), style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/AddRentAds");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}