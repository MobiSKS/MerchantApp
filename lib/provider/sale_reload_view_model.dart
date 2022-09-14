import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../const/injection.dart';
import '../../preferences/shared_preference.dart';

class SaleReloadViewModel extends ChangeNotifier {
  final Dio _dio = Injection.injector.get<Dio>();
  final SharedPref _sharedPref = Injection.injector.get<SharedPref>();

  final bool _isLoading = false;
  bool get isLoading => _isLoading;
}
