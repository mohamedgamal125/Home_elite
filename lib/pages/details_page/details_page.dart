import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/models/propertyType_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  final AdModel property;

  DetailsPage({required this.property});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isExpanded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateViews();
  }

  Future<void>updateViews() async{


    try{
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final token = await pref.get("token");

      print("============ad id ${widget.property.id}");
       await Dio().post(
        "https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/ViewAds/${widget.property.id}",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
    }catch(e)
    {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Column for displaying the images
          Column(
            children: [
              // Use ListView.builder to dynamically create the image widgets
              Expanded(
                child: ListView.builder(
                  itemCount: widget.property.img.length,
                  itemBuilder: (context, index) {
                    return Image(
                      image: widget.property.img.isNotEmpty
                          ? NetworkImage(widget.property.img[index].data)
                          : AssetImage("assets/images/property_image.png") as ImageProvider,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200, // Adjust this height as needed
                    );
                  },
                ),
              ),
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

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              // Handle Email action
                                              openEmail(widget.property.email);
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
                                                      style: GoogleFonts.alegreyaSansSc(color: Colors.brown),
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
                                              // Handle Call action
                                              openPhoneCaller(widget.property.phone);
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
                                                      style: GoogleFonts.alegreyaSansSc(color: Colors.brown),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              // Handle WhatsApp action
                                              openWhatsApp(widget.property.phone);
                                            },
                                            child: Container(
                                              height: 32,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: const Color(0xff01C617), width: 2),
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

  void openWhatsApp(String phone)async{

    String url = 'https://wa.me/${phone}';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void openPhoneCaller(String phoneNumber)async{
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openEmail(String email) async{

    final url= "mailto:$email";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
