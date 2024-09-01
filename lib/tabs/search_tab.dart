import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:home_elite/shared/components/property_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_elite/shared/components/filter_bottom_sheets.dart';

import '../models/propertyType_model.dart';
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
    if (cachedAds != null && query.isNotEmpty) {
      setState(() {
        filteredAds = cachedAds!.where((ad) {
          return ad.name.toLowerCase().contains(query) ||
              ad.propertyType.propertyType.toLowerCase().contains(query) ||
              ad.salary.toString().contains(query);
        }).toList();
      });
    } else {
      setState(() {
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
                              fetchFilterdAds();
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
                                searchController.clear();
                              });
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
                        filteredAds = filteredAds ?? cachedAds; // Use filtered ads if available
                        return Column(
                          children: filteredAds!.map((ad) {
                            return PropertyCard(
                              location: ad.address,
                              bedrooms: ad.bedrooms,
                              size: ad.area,
                              price: ad.salary.toString(),
                              propertyType: ad.propertyType.propertyType,
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

      if (response.statusCode == 200) {
        List<AdModel> ads = (response.data as List)
            .map((json) => AdModel.fromJson(json))
            .toList();
        cachedAds = ads; // Cache the fetched ads
        return ads;
      } else {
        throw Exception('Failed to load best ads');
      }
    } catch (e) {
      throw Exception('Error fetching best ads: $e');
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
          // TODO add data for (buy or rent) in the API
        },
      );

      if (response.statusCode == 200) {
        List<AdModel> ads = (response.data as List)
            .map((json) => AdModel.fromJson(json))
            .toList();

        cachedAds = ads; // Cache the fetched ads
        return ads;
      } else {
        throw Exception('Failed to load filtered ads');
      }
    } catch (e) {
      throw Exception('Error fetching filtered ads: $e');
    }
  }
}

