
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/models/propertyType_model.dart';

class DetailsPage extends StatefulWidget {
  final AdModel property;


  DetailsPage({required this.property});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Column for displaying the images
          Column(
            children: [
              Image.asset('assets/images/property_image.png', fit: BoxFit.cover, height: 200.0),
              Image.asset('assets/images/property_image.png', fit: BoxFit.cover, height: 200.0),
              Image.asset('assets/images/property_image.png', fit: BoxFit.cover, height: 200.0),
            ],
          ),
          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded; // Toggle between expanded and collapsed
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: isExpanded
                    ? MediaQuery.of(context).size.height * 0.75
                    : MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          isExpanded ? Icons.expand_more : Icons.expand_less,
                          size: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.property.salary} EGP',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${widget.property.address}',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                  
                            // Action buttons: Email, Call, WhatsApp
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
                            ),
                  
                            // Additional data shown when expanded
                            if (isExpanded) ...[
                              Divider(),
                              Text(
                                'Property Details',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                      '${widget.property.description}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.king_bed, size: 20),
                                      SizedBox(width: 4),
                                      Text('${widget.property.bedrooms} Bedrooms', style: TextStyle(fontSize: 16)),
                                      SizedBox(width: 16),
                                      Icon(Icons.bathtub, size: 20),
                                      SizedBox(width: 4),
                                      Text('${widget.property.bathrooms} Bathrooms', style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.square_foot, size: 20),
                                      SizedBox(width: 4),
                                      Text('${widget.property.area} m²', style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ],
                              ),
                  
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

