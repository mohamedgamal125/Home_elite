import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/pages/details_page/details_page.dart';
import 'package:home_elite/shared/components/property_card.dart';
import 'package:home_elite/tabs/main_tab_cubit/maintab_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../models/propertyType_model.dart';

class MainTab extends StatefulWidget {
  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  bool isSwitched = false;
  late Future<List<AdModel>> bestAdsFuture;
  int selectedIndex = 0; // 0 for buy and 1 for rent
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  String? selectedPropertyType; // Added selected property type

  @override
  void initState() {
    bestAdsFuture = fetchBestAds();
    super.initState();
    context.read<MaintabCubit>().getPropertyTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/house_background.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10, // Adjust the bottom position as needed
                    left: 10, // Adjust the left position as needed
                    right: 10, // Adjust the right position as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Switch
                        Container(
                          width: 120,
                          child: ToggleSwitch(
                            minWidth: 90.0,
                            initialLabelIndex: selectedIndex,
                            cornerRadius: 20.0,
                            activeFgColor: Colors.black,
                            inactiveBgColor: Color(0xffB9AD97),
                            inactiveFgColor: Colors.black.withOpacity(0.4),
                            totalSwitches: 2,
                            labels: ['Buy', 'Rent'],
                            fontSize: 12,
                            activeBgColors: [
                              [Colors.white],
                              [Colors.white]
                            ],
                            onToggle: (index) {
                              print('switched to: $index');
                              setState(() {
                                selectedIndex = index!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              border: Border.all(color: Colors.brown),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: TextField(
                              controller: searchController,
                              cursorColor: Colors.brown,
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value.toLowerCase();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'City',
                                hintStyle: GoogleFonts.akayaTelivigala(
                                    color: Colors.grey),
                                border: InputBorder.none,
                                icon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 4,
                          decoration: BoxDecoration(color: Color(0xff9D7D43)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                            "Property Types",
                            style: GoogleFonts.alegreyaSansSc(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocConsumer<MaintabCubit, MaintabState>(
                      listener: (context, state) {
                        if (state is MaintabError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is MaintabLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.brown,
                            ),
                          );
                        } else if (state is MaintabSuccess) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            child: Row(
                              children: state.response.map((propertyType) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 12),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Set the selected property type
                                      setState(() {
                                        selectedPropertyType = propertyType.propertyType.toLowerCase();
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Image(
                                          image: propertyType.propertyType == 'appartment'
                                              ? AssetImage(
                                              "assets/icons/Apartment_icon.png")
                                              : AssetImage(
                                              "assets/icons/Villa_icon.png"),
                                          width: 30,
                                          height: 30,
                                        ),
                                        Text(propertyType.propertyType,
                                            style: GoogleFonts.abyssinicaSil(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w100)),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        } else {
                          return Center(child: Text("No data available"));
                        }
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 4,
                          decoration: BoxDecoration(color: Color(0xff9D7D43)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                            "Best views property",
                            style: GoogleFonts.alegreyaSansSc(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    FutureBuilder<List<AdModel>>(
                      future: bestAdsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                                color: Colors.brown,
                              ));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: CircularProgressIndicator(
                                color: Colors.brown,
                              ));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No best ads available'));
                        } else {
                          final ads = snapshot.data!;
                          final filteredAds = ads.where((ad) {
                            // Filter by buy/rent
                            final matchesAdType = selectedIndex == 0
                                ? ad.adType == 'buy'
                                : ad.adType == 'rent';

                            // Filter by search query
                            final matchesSearchQuery = searchQuery.isEmpty ||
                                ad.name.toLowerCase().contains(searchQuery) ||
                                ad.area.toLowerCase().contains(searchQuery);

                            // Filter by selected property type
                            final matchesPropertyType = selectedPropertyType == null ||
                                ad.propertyType.propertyType.toLowerCase() == selectedPropertyType;

                            return matchesAdType && matchesSearchQuery && matchesPropertyType;
                          }).toList();

                          return Column(
                            children: filteredAds.map((ad) {
                              return PropertyCard(
                                onFavoriteUpdate: (){},
                                adModel: ad,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsPage(property: ad)));
                                },
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<AdModel>> fetchBestAds() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('bestAds');
    final lastFetchTime = prefs.getInt('lastFetchTime') ?? 0;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final cacheDuration = 60 * 3 * 1000; // 1 hour cache duration (milliseconds)

    // Check cache validity
    if (cachedData != null && (currentTime - lastFetchTime) < cacheDuration) {
      final List<dynamic> cachedJson = jsonDecode(cachedData);
      return cachedJson.map((json) => AdModel.fromJson(json)).toList();
    }

    // Fetch from API if cache is invalid or expired
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('No authorization token found.');
    }

    try {
      final response = await Dio().get(
        'https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/bestADS',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = response.data;
        final ads = jsonResponse.map((json) => AdModel.fromJson(json)).toList();

        // Cache the fetched data
        await prefs.setString('bestAds', jsonEncode(jsonResponse));
        await prefs.setInt('lastFetchTime', currentTime);

        return ads;
      } else {
        throw Exception('Failed to fetch best ads.');
      }
    } catch (e) {
      throw Exception('Error fetching best ads: $e');
    }
  }
}
