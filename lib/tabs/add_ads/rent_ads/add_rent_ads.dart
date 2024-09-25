import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_elite/tabs/add_ads/rent_ads/add_rent_ads_cubit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddRentAds extends StatefulWidget {
  final String? adId;

  AddRentAds({this.adId});

  @override
  State<AddRentAds> createState() => _AddRentAdsState();
}

class _AddRentAdsState extends State<AddRentAds> {
  late var cubit = AddRentAdsCubit.get(context);
  bool isEdite = false;

  void dispose() {
    cubit.clearAllData();
  }

  @override
  void initState() {
    super.initState();
    cubit = AddRentAdsCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.adId != null) {
      isEdite = true;
      cubit.loadAd(widget.adId!);
      print("==========${cubit.adTitle.text}=======");
    } else {
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
                    isEdite ? "Update Ad" : "Ad For Rent ",
                    style: GoogleFonts.roboto(fontSize: 18),
                  )
                ],
              ),
              Divider(
                endIndent: 20,
                indent: 20,
                thickness: 2,
              ),
              BlocBuilder<AddRentAdsCubit, AddRentAdsState>(
                builder: (context, state) {


                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    height: 250,
                    width: 370,
                    decoration: BoxDecoration(
                      border: cubit.selectedImages.isEmpty
                          ? Border.all(color: Colors.grey)
                          : null,
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
                                "Add Images",
                                style: GoogleFonts.alegreyaSansSc(fontSize: 20),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, right: 35),
                                child: Text(
                                  "5mb maximum file size accepted in the following format: .jpg, .jpeg, .png",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: GridView.builder(
                              itemCount: cubit.imageUrls.length + cubit.selectedImages.length + 1,
                              // Allow add button if less than 10 images
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    3, // Number of images in one row
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
                                }
                                else if (index <
                                    cubit.imageUrls.length +
                                        cubit.selectedImages.length) {
                                  // Show the selected images
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: Image.file(
                                          cubit.selectedImages[index],
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
                                  return InkWell(
                                    onTap: () {
                                      cubit.pickImages();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
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
              BlocBuilder<AddRentAdsCubit, AddRentAdsState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name * ",
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Type *",
                              style: GoogleFonts.alegreyaSansSc(),
                            ),
                            Container(
                              height: 32,
                              child: DropdownButtonFormField<String>(
                                onChanged: (value) {
                                  cubit.propertyType = value;
                                },
                                decoration: InputDecoration(
                                  hintText: "Choose",
                                  hintStyle: GoogleFonts.alegreyaSansSc(
                                    fontSize: 16,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 12),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
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
                                },
                                value: cubit.propertyType == "villa"
                                    ? cubit.propertyTypes[1]
                                    : cubit.propertyType == "appartment"
                                        ? cubit.propertyTypes[0]
                                        : null,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Area (M\u00B2) * ",
                                style: GoogleFonts.alegreyaSansSc(),
                              ),
                              Container(
                                height: 32,
                                child: TextFormField(
                                  controller: cubit.area,
                                  onChanged: (value) {
                                    cubit.area.text = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "0",
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "BedRooms * ",
                                style: GoogleFonts.alegreyaSansSc(),
                              ),
                              Container(
                                height: 32,
                                child: TextFormField(
                                  controller: cubit.bedRooms,
                                  onChanged: (value) {
                                    cubit.bedRooms.text = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "0",
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "BathRooms * ",
                                style: GoogleFonts.alegreyaSansSc(),
                              ),
                              Container(
                                height: 32,
                                child: TextFormField(
                                  controller: cubit.bathRooms,
                                  onChanged: (value) {
                                    cubit.bathRooms.text = value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "0",
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Levels * ",
                                style: GoogleFonts.alegreyaSansSc(),
                              ),
                              Container(
                                height: 32,
                                child: TextFormField(
                                  onChanged: (value) {
                                    cubit.levels.text = value;
                                  },
                                  controller: cubit.levels,
                                  decoration: InputDecoration(
                                    hintText: "0",
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ad Title * ",
                                style: GoogleFonts.alegreyaSansSc(),
                              ),
                              Container(
                                height: 32,
                                child: TextFormField(
                                  controller: cubit.adTitle,
                                  onChanged: (value) {
                                    cubit.adTitle.text = value;
                                  },
                                  decoration: InputDecoration(
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description * ",
                                style: GoogleFonts.alegreyaSansSc(),
                              ),
                              Container(
                                height: 32,
                                child: TextFormField(
                                  controller: cubit.description,
                                  onChanged: (value) {
                                    cubit.description.text = value;
                                  },
                                  decoration: InputDecoration(
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Location * ",
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Container(
                            child: IntlPhoneField(
                              controller: cubit.phone,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 12),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "12051556357",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              initialCountryCode: 'EG',
                              onChanged: (phone) {
                                print(phone.completeNumber);
                              },
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment Option * ",
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
                                          color: cubit.paymentOption == 'cash'
                                              ? Colors.brown
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.grey, width: 1.5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Cash",
                                            style: GoogleFonts.alegreyaSansSc(
                                              color:
                                                  cubit.paymentOption == 'cash'
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
                                        cubit
                                            .selectPaymentOption('installment');
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        decoration: BoxDecoration(
                                          color: cubit.paymentOption ==
                                                  'installment'
                                              ? Colors.brown
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.grey, width: 1.5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Installment",
                                            style: GoogleFonts.alegreyaSansSc(
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
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price * ",
                                style: GoogleFonts.alegreyaSansSc(),
                              ),
                              Container(
                                height: 32,
                                child: TextFormField(
                                  controller: cubit.price,
                                  cursorColor: Colors.brown,
                                  onChanged: (value) {
                                    cubit.price.text = value;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 12),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "0000000",
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rental Frequency ",
                              style: GoogleFonts.alegreyaSansSc(),
                            ),
                            Container(
                              height: 32,
                              child: DropdownButtonFormField<String>(
                                onChanged: (value) {
                                  cubit.rentalfreq = value;
                                },
                                decoration: InputDecoration(
                                  hintText: "Choose",
                                  hintStyle: GoogleFonts.alegreyaSansSc(
                                    fontSize: 16,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 12),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                items: cubit.rentalFrequency
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
                                  cubit.rentalfreq = value;
                                },
                                value: cubit.rentalfreq == 'day'
                                    ? cubit.rentalFrequency[0]
                                    : cubit.rentalfreq == 'month'
                                        ? cubit.rentalFrequency[1]
                                        : cubit.rentalfreq == 'year'
                                            ? cubit.rentalFrequency[2]
                                            : null,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Down Payment * ",
                                style: GoogleFonts.alegreyaSansSc(),
                              ),
                              Container(
                                height: 32,
                                child: TextFormField(
                                  controller: cubit.downPayment,
                                  cursorColor: Colors.brown,
                                  onChanged: (value) {
                                    cubit.downPayment.text = value;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 12),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "0000000",
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Insurance * ",
                                style: GoogleFonts.alegreyaSansSc(),
                              ),
                              Container(
                                height: 32,
                                child: TextFormField(
                                  controller: cubit.insurance,
                                  cursorColor: Colors.brown,
                                  onChanged: (value) {
                                    cubit.insurance.text = value;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 12),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "0000000",
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Available Option * ",
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
                                          color: cubit.availableOption == 'true'
                                              ? Colors.brown
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.grey, width: 1.5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "true",
                                            style: GoogleFonts.alegreyaSansSc(
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
                                        cubit.selectAvailableOption('false');
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        decoration: BoxDecoration(
                                          color:
                                              cubit.availableOption == 'false'
                                                  ? Colors.brown
                                                  : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.grey, width: 1.5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "false",
                                            style: GoogleFonts.alegreyaSansSc(
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
                        BlocConsumer<AddRentAdsCubit, AddRentAdsState>(
                          listener: (context, state) {
                            if (state is AddRentAdSuccess) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Ads Added Successfully',
                                btnOkOnPress: () {
                                  cubit.clearAllData();
                                },
                              )..show();
                            } else if (state is AddRentAdFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Can not add Ads! "),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (state is UpdateRentAdSuccess) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Ads Updated Successfully',
                                btnOkOnPress: () {
                                  cubit.clearAllData();
                                },
                              )..show();
                            } else if (state is UpdateRentAdFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Can not update Ads! "),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return state is AddRentAdLoading ||
                                    state is UpdateRentAdLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.brown,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      if (cubit.areFieldsValid()) {
                                        if (isEdite) {
                                          cubit.updateRentAd(widget.adId!);
                                        } else {
                                          cubit.PrintData();
                                          cubit.addRentAds();
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text("Please Fill all data "),
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
                                        color: Color(0xff9D7D43),
                                        // Background color
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Color(
                                                0xff9D7D43)), // Border color
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            isEdite ? "Update" : "Post",
                                            style: GoogleFonts.alegreyaSansSc(
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
