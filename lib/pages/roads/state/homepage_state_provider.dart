
import 'package:flutter/material.dart';
import 'package:traffix/models/places_model.dart';
import 'package:traffix/utils/rest_api.dart';

class HomePageStateProvider extends ChangeNotifier
{

  bool showBottomDrawer = true;
  RESTAPI api = RESTAPI();

  void setShowBottomDrawer(bool value){
    showBottomDrawer = value;
    print("\n Bottom Scroll State : $showBottomDrawer");
    notifyListeners();
  }

  List<String> kTopListLink = [
    'Sơn Trà',
    'Hải Châu',
    'Liên Chiểu',
    'Thanh Khê',
    'Cẩm Lệ',
    'Ngũ Hành Sơn',
  ];

  Future<List<PlaceModel>> getFeaturedPlaces() async {
    return await api.getFeaturedPlaces();    
  }

  Future<List<PlaceModel>> getAllPlaces() async {
    return await api.getAllPlaces();    
  }

  Future<void> getTopList() async {

      await Future.delayed(const Duration(milliseconds: 500), (){});

      notifyListeners();
      
  }

}