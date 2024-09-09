import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_rent_ads_state.dart';

class AddRentAdsCubit extends Cubit<AddRentAdsState> {
  AddRentAdsCubit() : super(AddRentAdsInitial());

  var propertyType;
  var area=TextEditingController();
  var bedRooms=TextEditingController();
  var bathRooms=TextEditingController();
  var levels=TextEditingController();
  var adTitle=TextEditingController();
  var description=TextEditingController();

  List<File> selectedImages = [];
  static AddRentAdsCubit get(context) => BlocProvider.of(context);

  final List<String> propertyTypes = [
    'Apartments',
    'Villa',
  ];

  void PrintData()
  {

    print("===========================================");
    print("Property type:$propertyType");
    print("Area: ${area.text}");
    print("bedRooms: ${bedRooms.text}");
    print("bathRooms: ${bathRooms.text}");
    print("Levels: ${levels.text}");
    print("Ad Title: ${adTitle.text}");
    print("description: ${description.text}");
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
}
