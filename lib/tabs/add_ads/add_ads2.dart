// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:home_elite/tabs/add_ads/rent_ads/add_rent_ads_cubit.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AddAds2 extends StatefulWidget {
//   const AddAds2({super.key});
//
//   @override
//   State<AddAds2> createState() => _AddAds2State();
// }
//
// class _AddAds2State extends State<AddAds2> {
//   String _name = 'Loading...';
//   String _email = 'Loading...';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }
//
//   Future<void> _loadUserData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _name = prefs.getString('name') ?? 'No Name';
//       _email = prefs.getString('email') ?? 'No Email';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.arrow_back_ios_new)),
//                 Text(
//                   "Review your details",
//                   style: GoogleFonts.roboto(fontSize: 18),
//                 ),
//               ],
//             ),
//             Divider(
//               endIndent: 20,
//               indent: 20,
//               thickness: 2,
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Card(
//                       elevation: 8.0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                       color: Colors.white,
//                       child: Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: ListTile(
//                           leading: Image.asset("assets/images/profile.png"),
//                           title: Text(
//                             _name,
//                             style: GoogleFonts.alegreyaSans(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           subtitle: Text(
//                             _email,
//                             style: GoogleFonts.alegreyaSans(fontSize: 10),
//                             maxLines: 1,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 12.0),
//                       child: Text(
//                         "Phone Number",
//                         style: GoogleFonts.alegreyaSansSc(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                             fontSize: 20),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//              Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 12.0, vertical: 12),
//                   child: InkWell(
//                     onTap: () {
//
//                       context.read<AddRentAdsCubit>().PrintData();
//
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       height: 44,
//                       decoration: BoxDecoration(
//                         color: Color(0xff9D7D43), // Background color
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Color(
//                             0xff9D7D43)), // Border color
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Post",
//                           style: GoogleFonts.alegreyaSansSc(
//                             textStyle: TextStyle(
//                                 color: Colors.white, fontSize: 18),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
