import 'package:flutter/material.dart';
import 'package:home_elite/shared/components/property_card.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration:BoxDecoration(
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black,width: 1)
                    ),
                    child: TextField(

                      decoration: InputDecoration(
                        hintText: 'City, area or building',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey
                        ),
                        icon: Image.asset("assets/icons/search_icon.png"),
                      ),
                    ),


                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black)
                          ),

                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(

                            children: [
                              Text("Price",style: TextStyle(
                                fontSize: 12,
                              ),),
                              SizedBox(width: 8,),
                              Image(image: AssetImage("assets/icons/down+arrow.png"))
                            ],
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black)
                          ),

                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(

                            children: [
                              Text("Beds",style: TextStyle(
                                fontSize: 12,
                              ),),
                              SizedBox(width: 8,),
                              Image(image: AssetImage("assets/icons/down+arrow.png"))
                            ],
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black)
                          ),

                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(

                            children: [
                              Text("Baths",style: TextStyle(
                                fontSize: 12,
                              ),),
                              SizedBox(width: 8,),
                              Image(image: AssetImage("assets/icons/down+arrow.png"))
                            ],
                          ),

                        ),
                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 6),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(12),
                        //       border: Border.all(color: Colors.black)
                        //   ),
                        //
                        //   margin: EdgeInsets.symmetric(horizontal: 8),
                        //   child: Row(
                        //
                        //     children: [
                        //       Text("Buy Or Rent",style: TextStyle(
                        //         fontSize: 12,
                        //       ),),
                        //       SizedBox(width: 8,),
                        //       Image(image: AssetImage("assets/icons/down+arrow.png"))
                        //     ],
                        //   ),
                        //
                        // ),
                      ],
                    ),
                  ),

                ],
              ),
            ),


            Expanded(
              child: ListView.builder(
                itemCount: 10,
                  itemBuilder:(context,index){
                    return PropertyCard();
                  }
                  ),
            ),


          ],
        ),
      ),
    );
  }
}
