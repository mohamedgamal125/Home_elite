import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/models/propertyType_model.dart';

import '../../models/userAd.dart';

class PropertyCard2 extends StatelessWidget {
  final UserAd userAd; // Updated from AdModel to UserAd
  final VoidCallback onTap;

  PropertyCard2({
    required this.userAd, // Updated from AdModel to UserAd
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(
                "assets/images/property_image.png",
              ),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                userAd.propertyType.propertyType, // Updated
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "${userAd.salary} EGP", // Updated
                style: GoogleFonts.arima(fontSize: 26),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                userAd.name, // Updated
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  Row(
                    children: [
                      const Image(
                          image: AssetImage("assets/icons/bed_icon.png")),
                      const SizedBox(width: 4),
                      Text(
                        "${userAd.bedrooms}", // Updated
                        style: GoogleFonts.adventPro(fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(width: 6),
                  Row(
                    children: [
                      const Image(
                          image: AssetImage("assets/icons/size_icon.png")),
                      const SizedBox(width: 4),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.adventPro(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: '${userAd.area} ', // Updated
                              style: GoogleFonts.adventPro(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const TextSpan(
                              text: 'm',
                            ),
                            TextSpan(
                              text: '²',
                              style: GoogleFonts.adventPro(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
