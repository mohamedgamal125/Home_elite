import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/tabs/add_ads/buy_ads/add_buy_ads_cubit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../Theming/myTheme_data.dart';

class AddBuyAds extends StatefulWidget {
  final String? adId;


  AddBuyAds({this.adId});

  @override
  State<AddBuyAds> createState() => _AddBuyAdsState();
}

class _AddBuyAdsState extends State<AddBuyAds> {
  final _formKey = GlobalKey<FormState>();
  late var cubit=AddBuyAdsCubit.get(context);
  bool isEdite=false;
  @override

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cubit=AddBuyAdsCubit.get(context);

  }

  @override
  void dispose() {

  }

  Widget build(BuildContext context) {
    print("============${widget.adId}======");

    if(widget.adId != null)
      {
        isEdite=true;
        cubit.loadAdData(widget.adId!);
        print("==========${cubit.adTitle.text}=======");
      }
    else
      {

         cubit.clearAllData();
      }


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new)),
                  Text(
                    isEdite?"update".tr() : "adForSale".tr(),
                    style: GoogleFonts.roboto(fontSize: 18),
                  )
                ],
              ),
              Divider(
                endIndent: 20,
                indent: 20,
                thickness: 2,
              ),
      BlocBuilder<AddBuyAdsCubit, AddBuyAdsState>(
        builder: (context, state) {


          return Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            height: 250,
            width: 370,
            decoration: BoxDecoration(
              border: cubit.imageUrls.isEmpty && cubit.selectedImages.isEmpty
                  ? Border.all(color: Colors.grey) // Show border if no images
                  : null, // Remove border if images are present
              borderRadius: BorderRadius.circular(14),
            ),
            child: cubit.selectedImages.isEmpty && cubit.imageUrls.isEmpty
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Icon(
                    Icons.add_circle_outline_sharp,
                    size: 45,
                  ),
                  onTap: () {
                    cubit.pickImages();
                  },
                ),
                Text(
                  "addImage".tr(),
                  style: GoogleFonts.alegreyaSansSc(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 35),
                  child: Text(
                    "imageDes".tr(),
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
              ],
            )
                : Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                itemCount: cubit.imageUrls.length + cubit.selectedImages.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of images in one row
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) {
                  print("========images from update======");
                  print(cubit.imageUrls);
                  if (index < cubit.imageUrls.length) {

                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            cubit.imageUrls[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: InkWell(
                            onTap: () {
                              // Delete image from imageUrls
                              cubit.removeImageUrl(index);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (index < cubit.imageUrls.length + cubit.selectedImages.length) {
                    // Display newly selected images
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.file(
                            cubit.selectedImages[index - cubit.imageUrls.length],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: InkWell(
                            onTap: () {
                              // Delete image from selectedImages
                              cubit.removeSelectedImage(index - cubit.imageUrls.length);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Add more images
                    return InkWell(
                      onTap: () {
                        cubit.pickImages();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.add_circle_outline_sharp,
                          size: 45,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),




      BlocBuilder<AddBuyAdsCubit, AddBuyAdsState>(
                builder: (context, state) {

                  return Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "name".tr(),
                                  style: GoogleFonts.alegreyaSansSc(),
                                ),
                                Container(
                                  height: 32,
                                  child: TextFormField(
                                    controller: cubit.name,
                                    cursorColor: Colors.brown,
                                    onChanged: (value) {
                                      cubit.name.text = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "",
                                      hintStyle: GoogleFonts.alegreyaSansSc(
                                        fontSize: 16,
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(left: 12),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "type".tr(),
                                style: GoogleFonts.alegreyaSansSc(),
                              ),
                              Container(
                                height: 32,
                                child: DropdownButtonFormField<String>(

                                  value:cubit.propertyType=="villa"?cubit.propertyTypes[1]:cubit.propertyType=="apartments"?cubit.propertyTypes[0]:null,
                                  onChanged: (value) {
                                    cubit.propertyType = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "choose".tr(),
                                    hintStyle: GoogleFonts.alegreyaSansSc(
                                      fontSize: 16,
                                    ),
                                    contentPadding: EdgeInsets.only(left: 12),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  items: cubit.propertyTypes
                                      .map<DropdownMenuItem<String>>(
                                          (String city) {
                                        return DropdownMenuItem<String>(
                                          value: city,
                                          child: Text(
                                            city,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        );
                                      }).toList(),
                                  onSaved: (value) {
                                    cubit.propertyType = value;

                                    print("=========Value===========$value");
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "area".tr(),
                                  style: GoogleFonts.alegreyaSansSc(),
                                ),
                                Container(
                                  height: 32,
                                  child: TextFormField(
                                    controller: cubit.area,
                                    cursorColor: Colors.brown,
                                    onChanged: (value) {
                                      cubit.area.text = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "0",
                                      hintStyle: GoogleFonts.alegreyaSansSc(
                                        fontSize: 16,
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(left: 12),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "bedRooms".tr(),
                                  style: GoogleFonts.alegreyaSansSc(),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                Container(
                                  height: 32,
                                  child: TextFormField(
                                    controller: cubit.bedRooms,
                                    cursorColor: Colors.brown,
                                    onChanged: (value) {
                                      cubit.bedRooms.text = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "0",
                                      hintStyle: GoogleFonts.alegreyaSansSc(
                                        fontSize: 16,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(left: 12),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "bathRooms".tr(),
                                  style: GoogleFonts.alegreyaSansSc(),
                                ),
                                Container(
                                  height: 32,
                                  child: TextFormField(
                                    controller: cubit.bathRooms,
                                    cursorColor: Colors.brown,
                                    onChanged: (value) {
                                      cubit.bathRooms.text = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "0",
                                      hintStyle: GoogleFonts.alegreyaSansSc(
                                        fontSize: 16,
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(left: 12),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "level".tr(),
                                  style: GoogleFonts.alegreyaSansSc(),
                                ),
                                Container(
                                  height: 32,
                                  child: TextFormField(
                                    controller: cubit.levels,
                                    cursorColor: Colors.brown,
                                    onChanged: (value) {
                                      cubit.levels.text = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "0",
                                      hintStyle: GoogleFonts.alegreyaSansSc(
                                        fontSize: 16,
                                      ),
                                      contentPadding:
                                      EdgeInsets.only(left: 12),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "adTitle".tr(),
                                  style: GoogleFonts.alegreyaSansSc(),
                                ),
                                Container(
                                  height: 32,
                                  child: TextFormField(
                                    controller: cubit.adTitle,
                                    cursorColor: Colors.brown,
                                    onChanged: (value) {
                                      cubit.adTitle.text = value;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(left: 12),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "desc".tr(),
                                  style: GoogleFonts.alegreyaSansSc(),
                                ),
                                Container(
                                  height: 32,
                                  child: TextFormField(
                                    controller: cubit.description,
                                    cursorColor: Colors.brown,
                                    onChanged: (value) {
                                      cubit.description.text = value;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(left: 12),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "location".tr(),
                                  style: GoogleFonts.alegreyaSansSc(),
                                ),
                                Container(
                                  height: 32,
                                  child: TextFormField(
                                    controller: cubit.location,
                                    cursorColor: Colors.brown,
                                    onChanged: (value) {
                                      cubit.location.text = value;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(left: 12),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Phone Text Filed
                          Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Container(
                              child: IntlPhoneField(
                                controller: cubit.phone,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 8, right: 8, bottom: 80),
                                  focusColor: Colors.brown,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  labelText: 'phone'.tr(),
                                  labelStyle: GoogleFonts.alegreyaSansSc(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                    BorderSide(color: Colors.transparent),
                                  ),
                                ),
                                initialCountryCode: 'EG',
                                onChanged: (phone) {
                                  print(phone.completeNumber);
                                },
                              ),
                              width: 330,
                                height: 70,
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "paymentOption".tr(),
                                  style: GoogleFonts.alegreyaSansSc(),
                                ),
                                Container(
                                  height: 32,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          cubit.selectPaymentOption('cash');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          decoration: BoxDecoration(
                                            color:
                                            cubit.paymentOption == 'cash'
                                                ? MyColor.myDark
                                                : Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.grey,
                                                width: 1.5),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "cash".tr(),
                                              style:
                                              GoogleFonts.alegreyaSansSc(
                                                color: cubit.paymentOption ==
                                                    'cash'
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w100,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          cubit.selectPaymentOption(
                                              'installment');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          decoration: BoxDecoration(
                                            color: cubit.paymentOption ==
                                                'installment'
                                                ? MyColor.myDark
                                                : Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.grey,
                                                width: 1.5),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "installment".tr(),
                                              style:
                                              GoogleFonts.alegreyaSansSc(
                                                color: cubit.paymentOption ==
                                                    'installment'
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w100,
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
                          ),

                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "price".tr(),
                                  style: GoogleFonts.alegreyaSansSc(),
                                ),
                                Container(
                                  height: 32,
                                  child: TextFormField(
                                    controller: cubit.price,
                                    cursorColor: MyColor.myDark,
                                    onChanged: (value) {
                                      cubit.price.text = value;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(left: 12),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "0000000",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "finalTotal".tr(),
                                  style: GoogleFonts.alegreyaSansSc(),
                                ),
                                Container(
                                  height: 32,
                                  child: TextFormField(
                                    controller: cubit.finalTotal,
                                    cursorColor: MyColor.myDark,
                                    onChanged: (value) {
                                      cubit.finalTotal.text = value;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(left: 12),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "0000000",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AvailableOption".tr(),
                                  style: GoogleFonts.alegreyaSansSc(),
                                ),
                                Container(
                                  height: 32,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          cubit.selectAvailableOption('true');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          decoration: BoxDecoration(
                                            color:
                                            cubit.availableOption == 'true'
                                                ? MyColor.myDark
                                                : Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.grey,
                                                width: 1.5),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "true".tr(),
                                              style:
                                              GoogleFonts.alegreyaSansSc(
                                                color: cubit.availableOption ==
                                                    'true'
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w100,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          cubit.selectAvailableOption(
                                              'false');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          decoration: BoxDecoration(
                                            color: cubit.availableOption ==
                                                'false'
                                                ? MyColor.myDark
                                                : Colors.transparent,
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.grey,
                                                width: 1.5),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "false".tr(),
                                              style:
                                              GoogleFonts.alegreyaSansSc(
                                                color: cubit.availableOption ==
                                                    'false'
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w100,
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
                          ),
                          BlocConsumer<AddBuyAdsCubit, AddBuyAdsState>(
                            listener: (context, state) {
                              if (state is AddBuyAdSuccess) {

                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'successAdd'.tr(),

                                  btnOkOnPress: () {
                                    cubit.clearAllData();
                                  },
                                )..show();
                              } else if (state is AddBuyAdFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("cannot add".tr()),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                              else if( state is UpdateBuyAdFailure)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("cannot update".tr()),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              else if( state is UpdateBuyAdSuccess)
                                {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.rightSlide,
                                    title: 'successUpdate'.tr(),

                                    btnOkOnPress: () {
                                      cubit.clearAllData();
                                    },
                                  )..show();
                                }
                            },
                            builder: (context, state) {
                              return state is AddBuyAdsLoading||  state is UpdateBuyLoading
                                  ? Center(
                                child: CircularProgressIndicator(
                                  color: MyColor.myDark,
                                ),
                              )
                                  : InkWell(
                                onTap: () {
                                  if (cubit.areFieldsValid()) {
                                    if(isEdite)
                                      {
                                        // add call for update
                                        cubit.PrintData();
                                        cubit.updateAd(widget.adId!);

                                      }
                                   else{
                                      cubit.PrintData();
                                      cubit.addAd();
                                    }

                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "fillData".tr()),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  width: 350,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color:MyColor.myDark,
                                    // Background color
                                    borderRadius:
                                    BorderRadius.circular(12),
                                    border: Border.all(
                                        color:MyColor.myDark), // Border color
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                       isEdite? "update".tr():"post".tr(),
                                        style:
                                        GoogleFonts.alegreyaSansSc(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}