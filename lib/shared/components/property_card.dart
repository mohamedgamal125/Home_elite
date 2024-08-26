import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Villa",
                  style: TextStyle(color: Colors.grey),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_outline,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "25.595,000 EGP",
              style: GoogleFonts.arima(fontSize: 26),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text("New Cairo, Egypt",style: TextStyle(color: Colors.grey,fontSize: 12),),


          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
            child: Row(

              children: [

                Row(
                  children: [
                    Image(image: AssetImage("assets/icons/bed_icon.png")),
                    SizedBox(width: 4,),
                    Text("3",style: GoogleFonts.adventPro(fontSize: 10),),
                  ],
                ),
                SizedBox(width:6 ,),
                Row(
                  children: [
                    Image(image: AssetImage("assets/icons/size_icon.png")),
                    SizedBox(width: 4,),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.adventPro(
                          fontSize: 12, // Font size for the base text
                          color: Colors.black, // Color for the base text
                        ),
                        children: [
                          TextSpan(
                            text: '180 ',
                            style:  GoogleFonts.adventPro(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
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
            padding:  EdgeInsets.symmetric(horizontal: 6.0,vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Container(
                      width: 95,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black,width: 2)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(

                          children: [
                            Icon(Icons.email,color: Colors.brown,),
                            SizedBox(width: 8,),
                            Text("Email",style: GoogleFonts.alegreyaSansSc(color: Colors.brown),)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: InkWell(
                    child: Container(
                      width: 95,
                      height: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black,width: 2)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(

                          children: [
                            Icon(Icons.call,color: Colors.brown,),
                            SizedBox(width: 4,),
                            Text("Call",style: GoogleFonts.alegreyaSansSc(color: Colors.brown),)
                          ],
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: InkWell(
                    child: Container(
                      width: 95,
                      height: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xff01C617),
                            width: 2
                          ),

                      ),
                      child: Center(
                        child:Image(image: AssetImage("assets/icons/whats_icon.png"),),
                      ),
                    ),
                    onTap: () {},
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
