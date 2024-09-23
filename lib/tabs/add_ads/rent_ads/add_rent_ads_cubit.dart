import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_rent_ads_state.dart';

class AddRentAdsCubit extends Cubit<AddRentAdsState> {
  AddRentAdsCubit() : super(AddRentAdsInitial());

  var propertyType;
  var rentalfreq;
  var area=TextEditingController();
  var bedRooms=TextEditingController();
  var bathRooms=TextEditingController();
  var levels=TextEditingController();
  var adTitle=TextEditingController();
  var description=TextEditingController();
  var location=TextEditingController();
  var price=TextEditingController();
  var phone=TextEditingController();
  var name=TextEditingController();
  var downPayment=TextEditingController();
  var insurance= TextEditingController();



  String ?paymentOption;
  String ?availableOption;

  List<File> selectedImages = [];
  static AddRentAdsCubit get(context) => BlocProvider.of(context);

  final List<String> propertyTypes = [
    'Apartments',
    'Villa',
  ];

  final List<String> rentalFrequency = [
    'day',
    'month',
    'year',
  ];

  void PrintData()
  {

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
    print("rental freq: ${rentalfreq}");
    print("down payment: ${downPayment.text}");
    print("AvailableOption: $availableOption");
    print("Insurance: ${insurance.text}");
    print("===========================================");
  }

  Future<void> pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {
      selectedImages = pickedFiles.map((file) => File(file.path)).toList();
      emit(AddRentImageSelected());
    }
  }
  void clearSelectedImages() {
    selectedImages.clear();
    emit(AddRentImageClear());
  }

  void selectPaymentOption(String option) {
    paymentOption = option;
    emit(AddRentPaymentOption(option));
  }

  void selectAvailableOption(String option) {
    availableOption = option;
    emit(AvailableOption(option));
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
        paymentOption != null ;
  }

  Future<void> addRentAds() async {
    emit(AddRentAdLoading());
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      String? email = await pref.getString('email');
      final token = pref.getString('token');
      print("==========email $email");

      final Dio dio = Dio();
      final url = 'https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/rent/rent/add_ADS';

      // Create FormData
      final formData = FormData.fromMap({
        'name': name.text,
        'salary': price.text,
        'propertyType': (propertyType=="Villa") ? "66f00017eccfcd04a54e906f" : "66da68ebb3dc9ecda5fedfe6",
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
        'rentDuration': rentalfreq,
        'DownPayment': int.parse(downPayment.text),
        'Insurance': int.parse(insurance.text),
      });

      // Add images to FormData
      if (selectedImages.isNotEmpty) {
        for (var image in selectedImages) {
          formData.files.add(MapEntry(
            'img', // Key for the image file
            await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
          ));
        }
      }

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
        emit(AddRentAdSuccess(message: data['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(AddRentAdFailure(error: e.toString()));
    }
  }


  Future<void> loadAd(String adId) async {

    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString('token');
      final Dio dio = Dio();

      print(adId);

      final url = 'https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/rent/getRent/$adId';
      final response = await dio.get(url, options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ));

      final data = response.data['ad'];

      print(response.data);
      name.text = data['name'];
      price.text = data['salary'].toString();
      propertyType = data['propertyType']['_id'];
      phone.text = data['phone'].substring(1);
      area.text = data['Area'];
      bedRooms.text = data['Bedrooms'].toString();
      bathRooms.text = data['Bathrooms'].toString();
      adTitle.text = data['title'];
      description.text = data['Description'];
      location.text = data['Address'];
      paymentOption = data['Payment_option'];
      availableOption = data['available'] ? "Available" : "Not Available";
      rentalfreq = data['rentDuration'];
      downPayment.text = data['DownPayment'].toString();
      insurance.text = data['Insurance'].toString();

      if (data['img'] != null && data['img'].isNotEmpty) {
        selectedImages = data['img'].map<File>((img) => File(img['data'])).toList();
      }


    } catch (e) {
      print(e.toString());

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
    downPayment.clear();
    insurance.clear();
    levels.clear();

    propertyType = null;
    rentalfreq = null;
    paymentOption = null;
    availableOption = null;
    clearSelectedImages();
  }


  Future<void> updateRentAd(String adId) async {
    emit(UpdateRentAdLoading());
    try {
      print('========image=====${selectedImages}');

      final SharedPreferences pref = await SharedPreferences.getInstance();
      String? email = await pref.getString('email');
      final token = pref.getString('token');
      print("==========email $email");

      final Dio dio = Dio();
      final url = 'https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/rent/update/$adId'; // Update API URL

      final formData = FormData.fromMap({
        'name': name.text,
        'salary': price.text,
        'propertyType':(propertyType=="Villa") ? "66f00017eccfcd04a54e906f" : "66da68ebb3dc9ecda5fedfe6",
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
        'rentDuration': rentalfreq,
        'DownPayment': int.parse(downPayment.text),
        'Insurance': int.parse(insurance.text),
      });

      if (selectedImages.isNotEmpty) {
        formData.files.add(MapEntry(
          'img',
          MultipartFile.fromFileSync(selectedImages[0].path, filename: 'image.jpg'),
        ));
      }

      final response = await dio.put(
        url,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final data = response.data;

      print("=======response $response");
      if (data['message'] != null) {
        emit(UpdateRentAdSuccess(message: data['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(UpdateRentAdFailure(error: e.toString()));
    }
  }


}
