import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/models/propertyType_model.dart';
import '../../models/userAd.dart';

class PropertyCard2 extends StatelessWidget {
  final UserAd userAd;
  final VoidCallback onEdit; // Callback for edit action
  final VoidCallback onDelete; // Callback for delete action

  PropertyCard2({
    required this.userAd,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = userAd.img?.isNotEmpty == true ? userAd.img!.first.data : 'assets/images/property_image.png';
    return Card (

      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 150, // Adjust height as needed
            errorBuilder: (context, error, stackTrace) {
              // Placeholder image in case of an error
              return Image.asset(
                'assets/images/property_image.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150, // Adjust height as needed
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  userAd.propertyType!.propertyType!,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Icon(Icons.remove_red_eye_outlined,color: CupertinoColors.inactiveGray,),
                    SizedBox(width: 3,),
                    Text("${userAd.views}",style: TextStyle(fontWeight: FontWeight.w100,color: Colors.grey),)
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "${userAd.salary} EGP",
              style: GoogleFonts.arima(fontSize: 26),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              userAd.name!,
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
                      "${userAd.bedrooms}",
                      style: GoogleFonts.adventPro(fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(width: 6),
                Row(
                  children: [
                    const Image(image: AssetImage("assets/icons/size_icon.png")),
                    const SizedBox(width: 4),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.adventPro(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '${userAd.area} ',
                            style: GoogleFonts.adventPro(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(text: 'm'),
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
          // Add buttons here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align buttons to the right
              children: [
                InkWell(
                  child: Container(
                    width:155 ,
                    height: 35,
                    decoration:BoxDecoration(
                        border: Border.all(color: Colors.red,width: 1.5),
                        borderRadius: BorderRadius.circular(16)
                    ) ,

                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Delete",style: GoogleFonts.alegreyaSansSc(color: Colors.red,fontSize: 14,fontWeight: FontWeight.bold),),
                        SizedBox(width: 6,),
                        Icon(CupertinoIcons.delete,size: 18,color: Colors.red,),

                      ],
                    ),
                  ),
                  onTap: () {
                    onDelete();
                  },
                ),
                InkWell(
                  child: Container(
                    width:155 ,
                    height: 35,
                    decoration:BoxDecoration(
                        border: Border.all(color: Colors.brown,width: 1.5),
                        borderRadius: BorderRadius.circular(16)
                    ) ,

                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Edit",style: GoogleFonts.alegreyaSansSc(color: Colors.brown,fontSize: 14,fontWeight: FontWeight.bold),),
                        SizedBox(width: 6,),
                        Icon(Icons.edit_outlined,size: 18,color: Colors.brown,),

                      ],
                    ),
                  ),
                  onTap: () {
                    onEdit();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
