import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/shared/components/property_card.dart';
import 'package:home_elite/tabs/favorite_tab/favorite_tab_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/propertyType_model.dart';
import '../../models/user.dart';
import '../../pages/details_page/details_page.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 35),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 6,
                decoration: BoxDecoration(color: Color(0xff9D7D43)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  "Saved properties",
                  style: GoogleFonts.alegreyaSansSc(
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff263A27)),
                  ),
                ),
              ),
            ],
          ),
        ),

        FutureBuilder<List<AdModel>>(
          future: getFavorite(),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                    color: Colors.brown,
                  ));
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return Center(child: Text('No favorite ads available'));
            } else {
              final ads = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                    itemCount: ads.length,
                    itemBuilder: (context,index){
                      final ad =ads[index];
                      return PropertyCard(

                          adModel: ad,
                          onTap: () {
                            print("===============Is Favorite ${ad.isFavorite}");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsPage(property: ad)));
                          },
                      );
                    }
                ),
              );
            }
          },
        ),
      ],
    ));
  }

  Future<List<AdModel>> getFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final Token = prefs.get("token");
    try {

      print("======================Token${Token}=");

      final response = await Dio().get(
          "https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/favorite",
          options: Options(headers: {'Authorization': 'Bearer $Token'}));

      if(response.statusCode==200)
        {

          final List<dynamic> data = response.data['favoriteAds'];
          final List<AdModel> favoriteAds=data.map((json) => AdModel.fromJson(json)).toList();
          final UserResponse = await Dio().get(
            'https://backend-coding-yousseftarek80s-projects.vercel.app/auth/user',
            options: Options(
              headers: {
                'Authorization': 'Bearer $Token',
              },
            ),
          );

          print(UserResponse.data);
          //

          User2 user=User2.fromJson(UserResponse.data);

          final favoriteAdIds = user.favorite?.map((fav) => fav.ad).toSet() ?? {};

          for(var ad in favoriteAds!)
          {
            ad.isFavorite = favoriteAdIds.contains(ad.id);
          }


          return favoriteAds;
        }
      else {
        throw("Error while get Favorite Ads");
      }

    } catch (e) {
      print(e.toString());
      throw(e.toString());
    }
  }
}
