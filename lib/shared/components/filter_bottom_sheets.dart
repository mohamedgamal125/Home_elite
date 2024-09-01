import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showPriceBottomSheet(BuildContext context, Function(String, String) onApply) {
  final TextEditingController startPriceController = TextEditingController();
  final TextEditingController endPriceController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    // Enables the bottom sheet to resize with the keyboard
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Image.asset("assets/icons/label_icon.png"),
                    SizedBox(width: 8),
                    Text(
                      'Price Range',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 30,
                        child: TextField(
                          cursorHeight: 20,
                          controller: startPriceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "from",
                            labelStyle: TextStyle(color: Colors.grey,fontSize: 12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text('To',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 30,
                        child: TextField(
                          cursorHeight: 20,
                          controller: endPriceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Any',
                            labelStyle: TextStyle(color: Colors.grey,fontSize: 12),

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff9D7D43),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xff9D7D43)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Apply",
                        style: GoogleFonts.alegreyaSansSc(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                    onPressed: () {
                      String startPrice = startPriceController.text;
                      String endPrice = endPriceController.text;

                      onApply(startPrice,
                          endPrice); // Call the callback to apply the filter
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showBedsBottomSheet(BuildContext context, Function(String) onApply) {
  final TextEditingController numberOfBeds = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Image.asset("assets/icons/bed_icon2.png"),
                    SizedBox(width: 8),
                    Text(
                      'Bathrooms',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  height: 30,
                  margin: EdgeInsets.symmetric(horizontal: 35),
                  child: TextField(
                    cursorHeight: 20,
                    controller: numberOfBeds,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff9D7D43),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xff9D7D43)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Apply",
                        style: GoogleFonts.alegreyaSansSc(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                      onApply(numberOfBeds.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showBathsBottomSheet(BuildContext context, Function(String) onApply) {
  final TextEditingController numberOfBath = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Image.asset("assets/icons/bath_icon.png"),
                    SizedBox(width: 8),
                    Text(
                      'Bathrooms',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  height: 30,
                  margin: EdgeInsets.symmetric(horizontal: 35),
                  child: TextField(
                    cursorHeight: 20,
                    controller: numberOfBath,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff9D7D43),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xff9D7D43)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Apply",
                        style: GoogleFonts.alegreyaSansSc(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                      onApply(numberOfBath.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showBuyRentBottomSheet(BuildContext context,Function(String)onApply) {
  bool isBuySelected = false; // Initial state for the "Buy" button

  String selectedChoice="";
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Row for the Buy and Rent buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isBuySelected = true;
                              selectedChoice = "buy";
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isBuySelected ? Colors.brown : Colors.grey[300], // Background color
                            foregroundColor: isBuySelected ? Colors.white : Colors.black, // Text color
                          ),
                          child: Text("Buy"),
                        ),
                        SizedBox(width: 10), // Space between buttons
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isBuySelected = false;
                              selectedChoice = "rent";
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !isBuySelected ? Colors.brown : Colors.grey[300], // Background color
                            foregroundColor: !isBuySelected ? Colors.white : Colors.black, // Text color
                          ),
                          child: Text("Rent"),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff9D7D43),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xff9D7D43)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Apply",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        onPressed: () {
                          print("Selected choice: $selectedChoice");

                          onApply(selectedChoice);
                          Navigator.pop(context); // Close the bottom sheet
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}


void showBottomSheet(BuildContext context, String label) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filter by $label',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('This is the $label filter bottom sheet.'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Apply $label Filter'),
            ),
          ],
        ),
      );
    },
  );
}
