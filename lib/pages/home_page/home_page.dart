import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_elite/pages/home_page/home_cubit.dart';
import 'package:home_elite/tabs/add_ads/buy_ads/add_buy_ads_cubit.dart';

import 'package:home_elite/tabs/main_tab_cubit/maintab_cubit.dart';
import 'package:home_elite/tabs/profile_tab/profile_tab_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => MaintabCubit(),
        ),
        BlocProvider(create: (context) => ProfileTabCubit()
        ),
      ],
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: cubit.tabs[cubit.current_indx],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.brown,
              currentIndex: cubit.current_indx,
              selectedIconTheme: IconThemeData(
                color: Colors.brown,
              ),
              items: cubit.bottomItems,
              onTap: (index) {
                cubit.changeNavBarState(index,context);
                print(index);
              },
            ),
          );
        },
      ),
    );
  }
}