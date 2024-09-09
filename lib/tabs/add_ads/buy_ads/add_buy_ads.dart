import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/tabs/add_ads/buy_ads/add_buy_ads_cubit.dart';

class AddBuyAds extends StatefulWidget {
  const AddBuyAds({super.key});

  @override
  State<AddBuyAds> createState() => _AddBuyAdsState();
}

class _AddBuyAdsState extends State<AddBuyAds> {

  @override
  Widget build(BuildContext context) {
    

  return Scaffold(
    backgroundColor: Colors.white,

      body: BlocProvider(
        create: (context) => AddBuyAdsCubit(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, icon: Icon(Icons.arrow_back_ios_new)),
                  Text(
                    "Ad For Sale ",
                    style: GoogleFonts.roboto(fontSize: 18),
                  )
                ],
              ),
              Divider(
                endIndent: 20,
                indent: 20,
                thickness: 2,
              ),
              BlocBuilder<AddBuyAdsCubit, AddBuyAdsState>(
                builder: (context, state) {
                  var cubit=AddBuyAdsCubit.get(context);
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    height: 200,
                    width: 370,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(14)),
                    child: cubit.selectedImages.isEmpty
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.add_circle_outline_sharp,
                            size: 45,
                          ),
                          onTap: () {
                            cubit.pickImages();
                          },
                        ),
                        Text(
                          "Add Images",
                          style: GoogleFonts.alegreyaSansSc(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 35),
                          child: Text(
                            "5mb maximum file size accepted in the following format: .jpg, .jpeg, .png",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        )
                      ],
                    )
                        : Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.builder(
                        itemCount: cubit.selectedImages.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of images in one row
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        ),
                        itemBuilder: (context, index) {
                          return Image.file(
                            cubit.selectedImages[index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            
              BlocBuilder<AddBuyAdsCubit, AddBuyAdsState>(
              builder: (context, state) {
                var cubit=AddBuyAdsCubit.get(context);
                return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type *",
                          style: GoogleFonts.alegreyaSansSc(),
                        ),
                        Container(
                          height: 32,
                          child: DropdownButtonFormField<String>(
                            onChanged: (value) {
                              cubit.propertyType = value;
                            },
                            decoration: InputDecoration(
                              hintText: "Choose",
                              hintStyle: GoogleFonts.alegreyaSansSc(
                                fontSize: 16,
                              ),
                              contentPadding: EdgeInsets.only(left: 12),
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: cubit.propertyTypes
                                .map<DropdownMenuItem<String>>((String city) {
                              return DropdownMenuItem<String>(
                                value: city,
                                child: Text(
                                  city,
                                  style: TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onSaved: (value) {
                              cubit.propertyType = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Area (M\u00B2) * ",
                            style: GoogleFonts.alegreyaSansSc(),
                          ),
                          Container(
                            height: 32,
                            child: TextFormField(
                              onChanged: (value) {
                                cubit.area.text = value;
                              },
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: GoogleFonts.alegreyaSansSc(
                                  fontSize: 16,
                                ),
                                contentPadding: EdgeInsets.only(left: 12),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "BedRooms * ",
                            style: GoogleFonts.alegreyaSansSc(),
                          ),
                          Container(
                            height: 32,
                            child: TextFormField(
                              onChanged: (value) {
                                cubit.bedRooms.text = value;
                              },
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: GoogleFonts.alegreyaSansSc(
                                  fontSize: 16,
                                ),
                                contentPadding: EdgeInsets.only(left: 12),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "BathRooms * ",
                            style: GoogleFonts.alegreyaSansSc(),
                          ),
                          Container(
                            height: 32,
                            child: TextFormField(
                              onChanged: (value) {
                                cubit.bathRooms.text = value;
                              },
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: GoogleFonts.alegreyaSansSc(
                                  fontSize: 16,
                                ),
                                contentPadding: EdgeInsets.only(left: 12),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Levels * ",
                            style: GoogleFonts.alegreyaSansSc(),
                          ),
                          Container(
                            height: 32,
                            child: TextFormField(
                              onChanged: (value) {
                                cubit.levels.text = value;
                              },
                              decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: GoogleFonts.alegreyaSansSc(
                                  fontSize: 16,
                                ),
                                contentPadding: EdgeInsets.only(left: 12),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ad Title * ",
                            style: GoogleFonts.alegreyaSansSc(),
                          ),
                          Container(
                            height: 32,
                            child: TextFormField(
                              onChanged: (value) {
                                cubit.adTitle.text = value;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 12),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description * ",
                            style: GoogleFonts.alegreyaSansSc(),
                          ),
                          Container(
                            height: 32,
                            child: TextFormField(
                              onChanged: (value) {
                                cubit.description.text = value;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 12),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cubit.PrintData();
                        Navigator.pushNamed(context, "/addAds2");
                      },
                      child: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        width: 350,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Color(0xff9D7D43), // Background color
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Color(0xff9D7D43)), // Border color
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Next",
                              style: GoogleFonts.alegreyaSansSc(
                                textStyle:
                                TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                            SizedBox(width: 8),
                            Image.asset("assets/images/arrow.png",
                                width: 22, height: 22),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
              },
            ),
            ],
                    ),
          ),
        ),
      ),
    );
  }
}
