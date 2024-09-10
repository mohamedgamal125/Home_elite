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

  String ?paymentOption;

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
    try{
      final SharedPreferences pref=await SharedPreferences.getInstance();
      String ?email=await pref.getString('email');
      final token = pref.getString('token');
      print("==========email $email");
      final Dio dio = Dio();
      final url = 'https://backend-coding-yousseftarek80s-projects.vercel.app/user/ads/buy/AddAds';
      final formData = FormData.fromMap({
        'name':"${name.text}",
        'salary':"${price.text}",
        'propertyType':"66da68ebb3dc9ecda5fedfe6",
        'phone':"${'0'+phone.text}",
        'email': email,
        'Area':"${area.text}",
        'Bedrooms':"${bedRooms.text}",
        'Bathrooms':"${bathRooms.text}",
        'title':"${adTitle.text}",
        'Description':"${description.text}",
        'Address':"${location.text}",
        'Payment_option':"${paymentOption}",
        'available':"true",

      });
      final response = await dio.post(url, data: formData, options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),);
      final data = response.data;

      print("=======respose $response");
      if (data['message'] != null) {
        emit(AddRentAdSuccess(message: data['message']));
      }
    }catch(e)
    {
      print(e.toString());
      emit(AddRentAdFailure(error: e.toString()));
    }



  }

}
