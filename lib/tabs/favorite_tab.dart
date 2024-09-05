import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/shared/components/property_card.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(

          children: [
            Padding(
              padding:  EdgeInsets.only(left: 20,right:20,top: 35),
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
            
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: PropertyCard(
                        propertyType: "Villa",
                        price: "250000",
                        location: "Giza",
                        bedrooms: 3,
                        size: "180",
                        onTap: (){},
                        name: "any thing",
                    ),
                  );
              },
                itemCount: 2,

              ),
            )
          ],
        )

    );
  }
}
