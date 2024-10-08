import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/propertyType_model.dart';
import '../../../models/userAd.dart';

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
  List<String> imageUrls = [];
  List<File> selectedImages = [];
  static AddRentAdsCubit get(context) => BlocProvider.of(context);
  List<PropertytypeModel> propertyTypeStrings=[];
  List<String> propertyStrings=[];

  List<PropertytypeModel> properties=[];
  Future<void> getPropertyTypes() async {


    try {
      final prefs = await SharedPreferences.getInstance();
      final Token = prefs.get("token");
      print("======================Token${Token}=");
      final response = await Dio().get(
          "https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/properties",
          options: Options(headers: {'Authorization': 'Bearer $Token'}));

      print(response.data);
      //
      properties = (response.data as List)
          .map((propertyJson) => PropertytypeModel.fromJson(propertyJson))
          .toList();

      // Create a list of property types
      propertyStrings = properties.map((property) => property.propertyType).toList();

      print('=======================================');
      print(propertyStrings);

      PrintData();

      print('=======================================');
      print(propertyStrings);
      PrintData();

    } catch (e) {
      print(e.toString());
    }
  }


  void updateImageUrls(List<String> urls) {
    imageUrls = urls;
    emit(AddRentImageSelected());
  }
  final List<String> propertyTypes = [
    'appartment'.tr(),
    'villa'.tr(),
  ];

  final List<String> rentalFrequency = [
    'day',
    'month',
    'year',
  ];

  String getTranslatedPropertyType(String propertyType) {
    switch (propertyType) {
      case 'appartment':
        return 'appartment'.tr();
      case 'villa':
        return 'villa'.tr();
      case 'Library':
        return 'library'.tr();
      case 'Office':
        return 'office'.tr();
      default:
        return propertyType; // Return the original if no translation is found
    }
  }
  void removeImageUrl(int index)
  {
    imageUrls.removeAt(index);
    emit(UpdateImageState());
  }


  void removeSelectedImage(int index)
  {
    selectedImages.removeAt(index);
    emit(UpdateImageState());
  }

  void PrintData()
  {

    print("===========================================");
    print("name:${name.text}");
    print(propertyStrings);
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

      selectedImages.addAll(pickedFiles.map((file) => File(file.path)).toList());
      emit(AddRentImageSelected());
    }
  }

  void clearSelectedImages() {
    imageUrls.clear();
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

        adTitle.text.isNotEmpty &&
        description.text.isNotEmpty &&
        location.text.isNotEmpty &&
        price.text.isNotEmpty &&
        paymentOption != null ;
  }

  Future<void> addRentAds() async {
    String? id;
    for(PropertytypeModel p in properties)
    {
      if(p.propertyType==propertyType)
      {
        print("==============IDS +++${p.id}");
        id= p.id;
      }
    }
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
        'propertyType': id,
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
      for (int i = 0; i < selectedImages.length; i++) {
        formData.files.add(MapEntry(
          'img', // The field name for the images in your backend API
          await MultipartFile.fromFile(
            selectedImages[i].path,
            filename: 'image_$i.jpg', // Name each file uniquely
          ),
        ));
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
      propertyType = data['propertyType']['PropertyType'];
      phone.text = data['phone'].substring(1);
      area.text = data['Area'];
      bedRooms.text = data['Bedrooms'].toString();
      bathRooms.text = data['Bathrooms'].toString();
      adTitle.text = data['title'];
      description.text = data['Description'];
      location.text = data['Address'];
      paymentOption = data['Payment_option'];
      availableOption = data['available'].toString();
      rentalfreq = data['rentDuration'];
      downPayment.text = data['DownPayment'].toString();
      insurance.text = data['Insurance'].toString();


      print("freq============$rentalfreq");
      if (data['img'] != null) {
        if (data['img'] is List) {
          imageUrls =
          List<String>.from(data['img'].map((img) => img['data']));
          print("=============images after load from rent page ====");
          print(imageUrls);
          emit(AddRentImageSelected());
        } else {
          print("Error: 'img' is not a list");
          clearSelectedImages();
        }
      } else {
        clearSelectedImages();
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
      final url = 'https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/rent/updateSpecificAds/$adId'; // Update API URL

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
        emit(UpdateRentAdSuccess(message: data['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(UpdateRentAdFailure(error: e.toString()));
    }
  }


}
