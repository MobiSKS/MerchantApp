
import 'package:flutter/cupertino.dart';

class LocationProvider with ChangeNotifier{


  Map<String, dynamic>? deviceInfo;
  var deviceLat;
  var deviceLong;

  

  getLocation(lat, long){
    deviceLat = lat;
    deviceLong = long;
    notifyListeners();
  }

}