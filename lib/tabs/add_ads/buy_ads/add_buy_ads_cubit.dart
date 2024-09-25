import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/userAd.dart';

part 'add_buy_ads_state.dart';

class AddBuyAdsCubit extends Cubit<AddBuyAdsState> {
  AddBuyAdsCubit() : super(AddBuyAdsInitial());

  var propertyType;
  var area = TextEditingController();
  var bedRooms = TextEditingController();
  var bathRooms = TextEditingController();
  var levels = TextEditingController();
  var adTitle = TextEditingController();
  var description = TextEditingController();
  var location = TextEditingController();
  var price = TextEditingController();
  var phone = TextEditingController();
  var name = TextEditingController();
  var finalTotal = TextEditingController();
  String? paymentOption;
  String? availableOption;

  List<File> selectedImages = [];

  static AddBuyAdsCubit get(context) => BlocProvider.of(context);

  List<String> imageUrls = [];

  // todo this list from get properties api
  final List<String> propertyTypes = [
    'Apartments',
    'Villa',
  ];

  final Map<String, String> type = {
    "Apartments": "66da68ebb3dc9ecda5fedfe6",
    "villa": "66f00017eccfcd04a54e906f",
  };

  void removeImageUrl(int index) {
    imageUrls.removeAt(index);
    emit(UpdateImageState()); // Update state after removing image
  }

  void removeSelectedImage(int index) {
    selectedImages.removeAt(index);
    emit(UpdateImageState()); // Update state after removing image
  }
  void PrintData() {
    print("===========================================");
    print("name:${name.text}");
    print("Property type:$propertyType");
    print("Area: ${area.text}");
    print("bedRooms: ${bedRooms.text}");
    print("bathRooms: ${bathRooms.text}");
    print("Levels: ${levels.text}");
    print("Ad Title: ${adTitle.text}");
    print("description: ${description.text}");
    print("location: ${location.text}");
    print("price: ${price.text}");
    print("PaymentOption: ${paymentOption}");

    print("Phone: ${phone.text}");
    print("Available Option: $availableOption");
    print("===========================================");
  }

  Future<void> pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {

      selectedImages.addAll(pickedFiles.map((file) => File(file.path)).toList());
      emit(AddBuyImageSelected());
    }
  }

  void updateImageUrls(List<String> urls) {
    imageUrls = urls;
    emit(AddBuyImageSelected());
  }

  void clearSelectedImages() {
    imageUrls.clear();
    selectedImages.clear();
    emit(AddBuyImageClear());
  }

  void selectPaymentOption(String option) {
    paymentOption = option;
    emit(AddBuyPaymentOptionChanged(option));
  }

  void selectAvailableOption(String option) {
    availableOption = option;
    emit(AvailableOptionChanged(option));
  }

  bool areFieldsValid() {
    return propertyType != null &&
        area.text.isNotEmpty &&
        bedRooms.text.isNotEmpty &&
        bathRooms.text.isNotEmpty &&
        levels.text.isNotEmpty &&
        adTitle.text.isNotEmpty &&
        description.text.isNotEmpty &&
        location.text.isNotEmpty &&
        price.text.isNotEmpty &&
        paymentOption != null &&
        phone.text.isNotEmpty;
  }

  Future<void> addAd() async {
    emit(AddBuyAdsLoading());
    try {
      print('========Images Selected=====${selectedImages.length}');

      final SharedPreferences pref = await SharedPreferences.getInstance();
      String? email = await pref.getString('email');
      final token = pref.getString('token');
      print("==========email $email");

      final Dio dio = Dio();
      final url =
          'https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/buy/AddAds';

      print("email from Add Buy Ads =================$email");
      final formData = FormData.fromMap({
        'name': name.text,
        'salary': price.text,
        'propertyType':(propertyType=="Villa") ? "66f00017eccfcd04a54e906f" : "66da68ebb3dc9ecda5fedfe6",
        // Update this based on your logic
        'phone': '0' + phone.text,
        'email': email,
        'Area': area.text,
        'Bedrooms': bedRooms.text,
        'Bathrooms': bathRooms.text,
        'title': adTitle.text,
        'Description': description.text,
        'Address': location.text,
        'Payment_option': paymentOption,
        'available': availableOption,
        'FinalTotal': int.parse(finalTotal.text),
      });

      // Add selected images to formData
      for (int i = 0; i < selectedImages.length; i++) {
        formData.files.add(MapEntry(
          'img', // The field name for the images in your backend API
          await MultipartFile.fromFile(
            selectedImages[i].path,
            filename: 'image_$i.jpg', // Name each file uniquely
          ),
        ));
      }

      // Send the request with the formData
      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final data = response.data;

      print("=======response $response");
      if (data['message'] != null) {
        emit(AddBuyAdSuccess(message: data['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(AddBuyAdFailure(error: e.toString()));
    }
  }

  Future<void> loadAdData(String adId) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString('token');

      print("token ======= $token");
      final Dio dio = Dio();
      final url =
          'https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/buy/getRent/$adId';
      final response = await dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final adData =
          response.data['ad'];

      print("==================================");
      print(adData);

      name.text = adData['name'];
      price.text = adData['salary'].toString();
      propertyType = adData['propertyType']['PropertyType'];
      phone.text = adData['phone'];
      phone.text = phone.text.substring(1);
      area.text = adData['Area'];
      adTitle.text=adData['title'];
      bedRooms.text = adData['Bedrooms'].toString();
      bathRooms.text = adData['Bathrooms'].toString();
      description.text = adData['Description'];
      location.text = adData['Address'];
      paymentOption = adData['Payment_option'].toString();
      availableOption = adData['available'].toString();
      finalTotal.text = adData['FinalTotal'].toString();

      // Handle images
      if (adData['img'] != null) {
        if (adData['img'] is List) {
          imageUrls =
              List<String>.from(adData['img'].map((img) => img['data']));
          print("=============images====");
          print(imageUrls);
          emit(AddBuyImageSelected());
        } else {
          print("Error: 'img' is not a list");
          clearSelectedImages();
        }
      } else {
        clearSelectedImages();
      }
    } catch (e) {
      print("==========${e.toString()}");
    }
  }

  Future<void> updateAd(String adId) async {
    emit(UpdateBuyLoading());
    try {
      print('========selected images=====${selectedImages}');
      print('========image URLs=====${imageUrls}');

      final SharedPreferences pref = await SharedPreferences.getInstance();
      String? email = await pref.getString('email');
      final token = pref.getString('token');
      print("==========email $email");

      final Dio dio = Dio();
      final url =
          'https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/buy/updateSpecificAds/$adId'; // Update API URL

      // Create FormData object
      final formData = FormData.fromMap({
        'name': "${name.text}",
        'salary': "${price.text}",
        'propertyType': (propertyType == "Villa") ? "66f00017eccfcd04a54e906f" : "66da68ebb3dc9ecda5fedfe6",
        'phone': "${'0' + phone.text}",
        'email': email,
        'Area': "${area.text}",
        'Bedrooms': "${bedRooms.text}",
        'Bathrooms': "${bathRooms.text}",
        'title': "${adTitle.text}",
        'Description': "${description.text}",
        'Address': "${location.text}",
        'Payment_option': "${paymentOption}",
        'available': availableOption,
        'FinalTotal': int.parse(finalTotal.text),
      });

      // Add selected images to formData
      for (int i = 0; i < selectedImages.length; i++) {
        formData.files.add(MapEntry(
          'img', // The field name for the images in your backend API
          await MultipartFile.fromFile(
            selectedImages[i].path,
            filename: 'image_$i.jpg', // Name each file uniquely
          ),
        ));
      }
      for (int i = 0; i < imageUrls.length; i++) {
        formData.fields.add(MapEntry('img[$i]', imageUrls[i]));
      }

      // Send the request with the formData
      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final data = response.data;

      print("=======response $response");
      if (data['message'] != null) {
        emit(UpdateBuyAdSuccess(message: data['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(UpdateBuyAdFailure(error: e.toString()));
    }
  }


  void clearAllData() {
    // Clear all TextEditingController fields
    name.clear();
    price.clear();
    area.clear();
    bedRooms.clear();
    bathRooms.clear();
    adTitle.clear();
    description.clear();
    location.clear();
    phone.clear();
    finalTotal.clear();
    levels.clear();

    propertyType = "";
    paymentOption = null;
    availableOption = null;

    clearSelectedImages();
  }
}
