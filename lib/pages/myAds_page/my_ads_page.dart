import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/Theming/myTheme_data.dart';
import 'package:home_elite/pages/myAds_page/my_ads_page_cubit.dart';
import 'package:home_elite/tabs/add_ads/buy_ads/add_buy_ads.dart';
import 'package:home_elite/tabs/add_ads/rent_ads/add_rent_ads.dart';

import '../../models/propertyType_model.dart';
import '../../models/userAd.dart';
import '../../shared/components/property_card2.dart';
import '../../tabs/add_ads/buy_ads/add_buy_ads_cubit.dart';

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({super.key});

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {

  @override
  void initState() {
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => MyAdsPageCubit()..fetchUserAds(),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 6,
                      decoration: BoxDecoration(color: MyColor.myTitleColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0,right: 8),
                      child: Text(
                        "myAds".tr(),
                        style: GoogleFonts.alegreyaSansSc(
                            textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: MyColor.myTitleColor)),
                      ),
                    ),
                    

                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<MyAdsPageCubit, MyAdsPageState>(
                  builder: (context, state) {
                    if (state is MyAdsPageLoading) {
                      return  Center(
                          child: CircularProgressIndicator(
                        color: MyColor.myDark,
                      ));
                    } else if (state is MyAdsPageSuccess) {
                      final ads = state.userAdsResponse.userAds;
                      return ListView.builder(
                        itemCount: ads.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PropertyCard2(
                              userAd: ads[index],
                              onDelete: () {
                                print(
                                    "==================${ads[index].id}======================");
                                final cubit = context.read<MyAdsPageCubit>();
                                cubit.deleteAds(ads[index]);
                              },
                              onEdit: () {
                                print(
                                    "==================${ads[index].id}======================");

                                if(ads[index].adType=="buy")
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddBuyAds(
                                              adId: ads[index].id,
                                            )));
                                  }

                                else
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddRentAds(
                                              adId: ads[index].id,
                                            )));
                                  }
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is MyAdsPageError) {
                      print(state.error);
                      return Center(child: Text(""));
                    } else if (state is MyAdsPageEmpty) {
                      return  Center(child: Text("noData".tr()));
                    }
                    return Container();
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
