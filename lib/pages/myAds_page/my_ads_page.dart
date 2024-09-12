import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/pages/myAds_page/my_ads_page_cubit.dart';

import '../../shared/components/property_card2.dart';

class MyAdsPage extends StatelessWidget {
  const MyAdsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocProvider(
        create: (context) => MyAdsPageCubit()..fetchUserAds(),
        child: SafeArea(

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 50),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 6,
                      decoration:
                      BoxDecoration(color: Color(0xff9D7D43)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Text(
                        "My Ads",
                        style: GoogleFonts.alegreyaSansSc(
                            textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff263A27))),
                      ),
                    )
                  ],
                ),
              ),

              Expanded(
                child: BlocBuilder<MyAdsPageCubit, MyAdsPageState>(
                  builder: (context, state) {
                    if (state is MyAdsPageLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MyAdsPageSuccess) {
                      final ads = state.userAdsResponse.userAds;
                      return ListView.builder(
                        itemCount: ads.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PropertyCard2(
                              userAd: ads[index],
                              onTap: (){},
                            ),
                          );
                        },
                      );
                    } else if (state is MyAdsPageError) {
                      return Center(child: Text("Error: ${state.error}"));
                    }
                    return const Center(child: Text("No Ads Found"));
                  },
                ),
              ),


            ],
          ),
        ),
      ),

    );
  }
}
