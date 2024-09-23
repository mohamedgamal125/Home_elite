import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/models/propertyType_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class PropertyCard extends StatefulWidget {

  final AdModel adModel;


  final VoidCallback onTap;
  final VoidCallback onFavoriteUpdate;

  PropertyCard({
    required this.adModel,
    required this.onTap,
    required this.onFavoriteUpdate
  });

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: widget.adModel.img.isNotEmpty
                  ? NetworkImage(widget.adModel.img[0].data)
                  : AssetImage("assets/images/property_image.png") as ImageProvider,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200, // You can adjust this height to suit your design
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.adModel.propertyType.propertyType,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  IconButton(
                    onPressed: () {
                      if(widget.adModel.isFavorite)
                        {
                          //delete
                          deleteFromFavorite();
                        }
                      else {
                        addToFavorite();
                      }


                    },
                    icon:  Icon(
                      widget.adModel.isFavorite? Icons.bookmark : Icons.bookmark_outline,
                      size: 25,
                      color: widget.adModel.isFavorite?Colors.red:Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "${widget.adModel.salary} EGP",
                style: GoogleFonts.arima(fontSize: 28,fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.adModel.name,
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
                        "${widget.adModel.bedrooms}",
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
                              text: '${widget.adModel.area} ',
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
                                // Smaller font size for superscript
                                color:
                                    Colors.black, // Color for the superscript
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
                        print("=========Email======${widget.adModel.email}");
                        openEmail(widget.adModel.email);
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
                        openPhoneCaller(widget.adModel.phone);
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

                        String phone=widget.adModel.phone;
                        print("=========Phone to chat======$phone");
                        if(phone.isNotEmpty)
                          {
                            openWhatsApp(phone);
                          }
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
      ),
    );
  }

  Future<void>deleteFromFavorite()async{

    try {
      final prefs = await SharedPreferences.getInstance();
      final Token = prefs.get("token");

      setState(() {
        widget.adModel.isFavorite=false;
      });
      print("Token   $Token");
      print(widget.adModel.id);
      final response = await Dio().post(
          "https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/DeleteFavorite/${widget.adModel.id}",
          options: Options(
              headers: {'Authorization': 'Bearer $Token'}
          )
      );

      if(response.statusCode==200)
      {

        setState(() {
          widget.adModel.isFavorite=false;
        });
        print("================add to favorite response ========================");
        print(response);

        widget.onFavoriteUpdate();
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> addToFavorite() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final Token = prefs.get("token");

      setState(() {
        widget.adModel.isFavorite=true;
      });
      print("Token   $Token");
      print(widget.adModel.id);
      final response = await Dio().post(
          "https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/AddFavorite/${widget.adModel.id}",
        options: Options(
            headers: {'Authorization': 'Bearer $Token'}
        )
      );

      if(response.statusCode==200)
        {

          setState(() {
            widget.adModel.isFavorite=true;
          });
          print("================add to favorite response ========================");
          print(response);
        }
    } catch (e) {
      print(e.toString());
    }
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

