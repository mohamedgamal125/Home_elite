import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAds2 extends StatelessWidget {
  const AddAds2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios_new)),
                Text(
                  "Review your details",
                  style: GoogleFonts.roboto(fontSize: 18),
                )
              ],
            ),
            Divider(
              endIndent: 20,
              indent: 20,
              thickness: 2,
            ),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset("assets/images/profile.png"),
                    title: Text(
                      'Youssef Tarek',
                      style: GoogleFonts.alegreyaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "youssef.tarek@gmail.com",
                      style: GoogleFonts.alegreyaSans(fontSize: 10),
                      maxLines: 1,
                    ),

                  ),
                ),
              ),
            ),
          ],
        ) ,

      ),
    );
  }
}
