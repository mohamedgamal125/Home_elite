import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void initState() {
    // TODO: implement initState
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
                            initialLabelIndex: 1,
                            cornerRadius: 20.0,
                            activeFgColor: Colors.black,
                            inactiveBgColor: Color(0xffB9AD97),
                            inactiveFgColor: Colors.black.withOpacity(0.4),
                            totalSwitches: 2,
                            labels: ['Buy', 'Rent'],
                            fontSize: 12,
                            activeBgColors: [[Colors.white],[Colors.white]],
                            onToggle: (index) {
                              print('switched to: $index');
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

                              cursorColor: Colors.brown,
                              decoration: InputDecoration(
                                hintText: 'City',
                                hintStyle: GoogleFonts.akayaTelivigala(color: Colors.grey),
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
                                      // Handle button click
                                    },
                                    child: Row(
                                      children: [
                                        Image(
                                          image: propertyType.propertyType ==
                                                  'appartment'
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

                    SizedBox(height: 20), // Add some space

                    FutureBuilder<List<AdModel>>(
                      future: fetchBestAds(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(color: Colors.brown,));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No best ads available'));
                        } else {
                          final ads = snapshot.data!;
                          return Column(
                            children: ads.map((ad) {
                              return PropertyCard(
                                location: ad.address,
                                bedrooms: ad.bedrooms,
                                size: ad.area,

                                price: ad.salary.toString(),
                                propertyType:ad.propertyType.propertyType,
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              // PropertyCard widgets in a Column
            ],
          ),
        ),
      ),
    );
  }

  Future<List<AdModel>> fetchBestAds() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Replace with the actual key where the token is stored

    try {
      final response = await Dio().get(
        'https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/bestADS',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final List<dynamic> data = response.data;
      return data.map((json) => AdModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load best ads');
    }
  }
}
