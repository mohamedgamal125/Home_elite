import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:home_elite/models/signup_model.dart';
import 'package:home_elite/models/user.dart';
import 'package:home_elite/shared/components/property_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_elite/shared/components/filter_bottom_sheets.dart';

import '../models/propertyType_model.dart';
import '../models/user_model.dart';
import '../pages/details_page/details_page.dart';
import '../models/user.dart';
import '../shared/components/filtter_button.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  bool isFiltered = false;
  bool isPriceFiltered = false;
  bool isBedsFiltered = false;
  bool isBathsFiltered = false;
  bool isBuyRentFiltered = false;

  String startPrice = "";
  String endPrice = "";

  String num_beds = "";
  String num_bath = "";
  String _choice = "";

  List<AdModel>? cachedAds;
  List<AdModel>? Data;
  List<AdModel>? filteredAds;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterAds);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  void _filterAds() {
    final query = searchController.text.toLowerCase();

    if ( query.isNotEmpty) {
      setState(() {
        filteredAds = cachedAds!.where((ad) {
           return ad.name.toLowerCase().contains(query); //||
          //     ad.propertyType.propertyType.toLowerCase().contains(query) ||ad.address.toLowerCase().contains(query);
        }).toList();
      });

    } else {
      setState(() {
        print("======i am in else=====");
        filteredAds = cachedAds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: TextField(
                      controller: searchController, // Set the controller
                      decoration: InputDecoration(
                        hintText: 'City, area or building',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                        icon: Image.asset("assets/icons/search_icon.png"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FilterButton(
                            label: "Price",
                            color: isPriceFiltered ? Colors.brown : Colors.white,
                            onPressed: () => showPriceBottomSheet(context, (start, end) {
                              setState(() {
                                startPrice = start;
                                endPrice = end;
                                isPriceFiltered = true;
                                isFiltered = true;
                              });

                            }),
                          ),
                          FilterButton(
                            label: "Beds",
                            color: isBedsFiltered ? Colors.brown : Colors.white,
                            onPressed: () => showBedsBottomSheet(context, (numBeds) {
                              setState(() {
                                num_beds = numBeds;
                                isBedsFiltered = true;
                                isFiltered = true;
                              });
                            }),
                          ),
                          FilterButton(
                            label: "Baths",
                            color: isBathsFiltered ? Colors.brown : Colors.white,
                            onPressed: () => showBathsBottomSheet(context, (numBath) {
                              setState(() {
                                num_bath = numBath;
                                isBathsFiltered = true;
                                isFiltered = true;
                              });
                            }),
                          ),
                          FilterButton(
                            label: "Buy & Rent",
                            color: isBuyRentFiltered ? Colors.brown : Colors.white,
                            onPressed: () => showBuyRentBottomSheet(context, (choice) {
                              setState(() {
                                _choice = choice;
                                isBuyRentFiltered = true;
                                isFiltered = true;

                                print(_choice);
                              });
                            }),
                          ),
                          FilterButton(
                            label: "Reset",
                            onPressed: () {
                              setState(() {
                                isFiltered = false;
                                isBathsFiltered = false;
                                isBedsFiltered = false;
                                isBuyRentFiltered = false;
                                isPriceFiltered = false;
                                startPrice = "";
                                endPrice = "";
                                num_beds = "";
                                num_bath = "";
                                _choice = "";

                                // Reset the filtered ads to cached ads
                                filteredAds = List.from(cachedAds ?? []);

                                searchController.clear();
                              });
                              setState(() {

                              });
                              setState(() {

                              });
                              print("=======IsFilterd $isFiltered");
                            },
                            color: Colors.brown,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SingleChildScrollView(
                  child: FutureBuilder<List<AdModel>>(
                    future: isFiltered ? fetchFilterdAds() : fetchBestAds(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.brown,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No Ads available'));
                      } else {
                        cachedAds = snapshot.data; // Cache the fetched ads
                         // Use filtered ads if available

                        filteredAds=filteredAds ?? cachedAds;

                        return Column(
                          children: filteredAds!.map((ad) {
                            return PropertyCard(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsPage(property: ad)));
                              },
                             adModel: ad,
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<AdModel>> fetchBestAds() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await Dio().get(
        'https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/getAds',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      print(token);

      if (response.statusCode == 200) {
        List<AdModel> ads = (response.data as List)
            .map((json) => AdModel.fromJson(json))
            .toList();
        cachedAds = ads;
        // Cache the fetched ads
        print(cachedAds);

        final UserResponse = await Dio().get(
          'https://backend-coding-yousseftarek80s-projects.vercel.app/auth/user',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        print(UserResponse.data);
        //

         User2 user=User2.fromJson(UserResponse.data);

        final favoriteAdIds = user.favorite?.map((fav) => fav.ad).toSet() ?? {};

        for(var ad in cachedAds!)
          {
            ad.isFavorite = favoriteAdIds.contains(ad.id);
          }

        return ads;
      } else {
        throw Exception('Failed to load  ads');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Error fetching ads: $e');
    }
  }

  Future<List<AdModel>> fetchFilterdAds() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await Dio().get(
        'https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/filter',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: {
          "minSalary": startPrice.isEmpty ? '' : int.parse(startPrice),
          "maxSalary": endPrice.isEmpty ? '' : int.parse(endPrice),
          "bedrooms": num_beds.isEmpty ? '' : int.parse(num_beds),
          "bathrooms": num_bath.isEmpty ? '' : int.parse(num_bath),
          "propertyType":_choice.isEmpty?'':_choice,
        },
      );

      print("response data ");
      print(response.data);
      if (response.statusCode == 200) {
        List<AdModel> ads = (response.data as List)
            .map((json) => AdModel.fromJson(json))
            .toList();



        filteredAds=ads;// Cache the fetched ads
        return ads;
      } else {
        throw Exception('Failed to load filtered ads');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Error fetching filtered ads: $e');
    }
  }
}

