import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PropertyCard extends StatelessWidget {
  // final String imageUrl;
  final String propertyType;
  final String price;
  final String location;
  final int bedrooms;
  final String size;
  // final VoidCallback onEmailTap;
  // final VoidCallback onCallTap;
  // final VoidCallback onWhatsAppTap;

  const PropertyCard({

    required this.propertyType,
    required this.price,
    required this.location,
    required this.bedrooms,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  propertyType,
                  style: const TextStyle(color: Colors.grey),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_outline,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "$price EGP",
              style: GoogleFonts.arima(fontSize: 26),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              location,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Row(
                  children: [
                    const Image(image: AssetImage("assets/icons/bed_icon.png")),
                    const SizedBox(width: 4),
                    Text(
                      "$bedrooms",
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
                          fontSize: 12, // Font size for the base text
                          color: Colors.black, // Color for the base text
                        ),
                        children: [
                          TextSpan(
                            text: '$size ',
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
                              fontSize: 12, // Smaller font size for superscript
                              color: Colors.black, // Color for the superscript
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.email, color: Colors.brown),

                            Text(
                              "Email",
                              style: GoogleFonts.alegreyaSansSc(
                                  color: Colors.brown),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.call, color: Colors.brown),

                            Text(
                              "Call",
                              style: GoogleFonts.alegreyaSansSc(
                                  color: Colors.brown),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: const Color(0xff01C617), width: 2),
                      ),
                      child: const Center(
                        child: Image(
                          image: AssetImage("assets/icons/whats_icon.png"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
