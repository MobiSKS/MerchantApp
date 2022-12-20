import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  String? _lat;
  String? get lat => _lat;

  String? _long;
  String? get long => _long;

  String? _ip;
  String? get ip => _ip;

  setValues({Position? position, String? ip}) async {
    _lat = position!.latitude.toString();
    _long = position.longitude.toString();
    _ip = ip;
    notifyListeners();
  }
}
